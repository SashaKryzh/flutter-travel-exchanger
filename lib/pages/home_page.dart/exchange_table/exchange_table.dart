import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' hide Provider;
import 'package:provider/provider.dart';
import 'package:travel_exchanger/config/theme/app_theme.dart';
import 'package:travel_exchanger/domain/exchange_between.dart';
import 'package:travel_exchanger/domain/value.dart';
import 'package:travel_exchanger/pages/home_page.dart/exchange_table/exchange_table_background.dart';
import 'package:travel_exchanger/pages/home_page.dart/exchange_table/exchange_table_providers.dart';
import 'package:travel_exchanger/pages/home_page.dart/exchange_table/exchange_values_from.dart';
import 'package:travel_exchanger/utils/extensions.dart';
import 'package:travel_exchanger/widgets/debug_container.dart';

const kExchangeRowExpandAnimationDuration = Duration(milliseconds: 200);
const kExpandAnimationCurve = Curves.easeInOut;

const kValuePadding = 20.0;
double get activationDelta => kValuePadding * 0.8;

/// Handles side drag activation
class ExchangeTable extends ConsumerStatefulWidget {
  const ExchangeTable({super.key});

  @override
  ConsumerState<ExchangeTable> createState() => _ExchangeTableState();
}

class _ExchangeTableState extends ConsumerState<ExchangeTable> with SingleTickerProviderStateMixin {
  late final _animationController = AnimationController(duration: Duration.zero, vsync: this);
  late var animation = Tween(begin: Offset.zero, end: Offset.zero).animate(_animationController);

  var dragActivated = false;
  var dragActivatedLeft = false;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _updateDrag(double delta) {
    final dragDelta = animation.value.dx + delta;

    setState(() {
      animation = Tween(
        begin: _offset(animation.value.dx),
        end: _offset(dragDelta),
      ).animate(_animationController);
    });
    _animationController.duration = Duration.zero;
    _animationController.reforward();

    if (dragActivatedLeft && dragDelta > 0 || !dragActivatedLeft && dragDelta < 0) {
      dragActivated = false;
    }

    if (!dragActivated && dragDelta.abs() > activationDelta) {
      dragActivated = true;
      dragActivatedLeft = dragDelta < 0;

      final notifier = ref.read(exchangeValuesFromNotifierProvider.notifier);

      if (dragActivatedLeft) {
        notifier.increase();
      } else {
        notifier.decrease();
      }

      HapticFeedback.mediumImpact();
    }
  }

  void _resetDrag() {
    dragActivated = false;

    setState(() {
      animation = Tween(
        begin: _offset(animation.value.dx),
        end: _offset(0),
      ).animate(_animationController);
    });
    _animationController.duration = const Duration(milliseconds: 100);
    _animationController.reforward();
  }

  Offset _offset(double dx) {
    dx = dx.clamp(-kValuePadding, kValuePadding);
    return Offset(dx, 0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onHorizontalDragUpdate: (details) => _updateDrag(details.delta.dx),
      onHorizontalDragEnd: (_) => _resetDrag(),
      child: Provider.value(
        value: _SlideAnimationProvider(animation),
        child: ExchangeTableBackgroundWrapper(
          columnsCount: ref.watch(exchangeBetweenProvider).length,
          child: _TableBackgroundShadow(
            child: LayoutBuilder(
              builder: (context, constraints) => Provider.value(
                value: _ExchangeTableLayoutProperties(tableHeight: constraints.maxHeight),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: constraints,
                    child: const _ExchangeTableContent(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TableBackgroundShadow extends ConsumerWidget {
  const _TableBackgroundShadow({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expandedRowsState = ref.watch(exchangeTableExpandedRowsProvider);

    return Container(
      color: levelShadowColor(
        context,
        level: expandedRowsState.lastExpandedLevel ?? 0,
        lastShownLevel: expandedRowsState.lastShownLevel,
      ),
      child: child,
    );
  }
}

class _SlideAnimationProvider extends Equatable {
  final Animation<Offset> animation;

  const _SlideAnimationProvider(this.animation);

  @override
  List<Object?> get props => [animation];
}

class _ExchangeTableLayoutProperties extends Equatable {
  const _ExchangeTableLayoutProperties({
    required this.tableHeight,
  });

  final double tableHeight;

  double get rowHeight => tableHeight / 10;
  double get expandedRowHeight => rowHeight * 8;
  double get nestedRowHeight => expandedRowHeight / 9;

  @override
  List<Object?> get props => [tableHeight];
}

//
// =============================================================================
//

/// Handles scroll to expanded row
class _ExchangeTableContent extends ConsumerStatefulWidget {
  const _ExchangeTableContent();

  @override
  ConsumerState<_ExchangeTableContent> createState() => _ExchangeTableContentState();
}

class _ExchangeTableContentState extends ConsumerState<_ExchangeTableContent> {
  final _scrollController = ScrollController();
  final _offsets = <double>[];

  late _ExchangeTableLayoutProperties _layoutProperties;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _expand({required int level, required int index}) {
    final double offset;

    if (level == 0) {
      offset = index * _layoutProperties.rowHeight;
    } else {
      offset =
          _offsets.last + _layoutProperties.rowHeight + _layoutProperties.nestedRowHeight * index;
    }

    _offsets.add(offset);
    _scrollTo(_offsets.last);
  }

  void _collapse() {
    _offsets.removeLast();
    _scrollTo(_offsets.lastOrNull ?? 0);
  }

  void _collapseAll() {
    _offsets.clear();
    _scrollTo(0);
  }

  void _scrollTo(double offset) {
    _scrollController.animateTo(
      offset,
      duration: kExchangeRowExpandAnimationDuration,
      curve: kExpandAnimationCurve,
    );
  }

  @override
  Widget build(BuildContext context) {
    _layoutProperties = context.watchLayoutProperties;

    ref.listen(exchangeTableExpandedRowsProvider, (prev, next) {
      if (prev == next) return;

      if (prev == null || prev.rows.length < next.rows.length) {
        _expand(level: next.rows.last.level, index: next.rows.last.index);
      } else if (next.rows.isEmpty && _offsets.length > 1) {
        _collapseAll();
      } else {
        _collapse();
      }
    });

    final values = ref.watch(exchangeValuesProvider);

    return SingleChildScrollView(
      controller: _scrollController,
      // Fixes scroll behavior on Android.
      physics: const NeverScrollableScrollPhysics().applyTo(const BouncingScrollPhysics()),
      child: Column(
        children: values
            .mapIndexed(
              (index, value) => _ExpandableRow(
                level: 0,
                index: index,
                value: value,
              ),
            )
            .toList(),
      ),
    );
  }
}

class _ExpandableRow extends ConsumerStatefulWidget {
  const _ExpandableRow({
    required this.level,
    required this.index,
    required this.value,
  }) : assert(level >= 0 && level < 100, 'Most likely you have infinite loop');

  final int level;
  final int index;
  final double value;

  @override
  ConsumerState<_ExpandableRow> createState() => _ExpandableRowState();
}

class _ExpandableRowState extends ConsumerState<_ExpandableRow>
    with SingleTickerProviderStateMixin {
  late final _animationController =
      AnimationController(duration: kExchangeRowExpandAnimationDuration, vsync: this);
  late var _animation = Tween(begin: 0.0, end: 0.0)
      .animate(CurvedAnimation(parent: _animationController, curve: kExpandAnimationCurve));

  bool get _canExpand => ref.read(exchangeValuesFromNotifierProvider).step(widget.level) != null;

  late _ExchangeTableLayoutProperties _layoutProperties;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  var _isExpanded = false;
  var _renderChildren = false;

  void _expandNotify() {
    ref
        .read(exchangeTableExpandedRowsProvider.notifier)
        .expand(level: widget.level, index: widget.index);
  }

  void _expand() {
    setState(() {
      _isExpanded = true;
      _renderChildren = true;
      _animation = Tween(
        begin: 0.0,
        end: _layoutProperties.expandedRowHeight,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: kExpandAnimationCurve,
      ));
    });
    _animationController.reforward();
  }

  void _collapse({bool updateNotifier = true}) {
    if (updateNotifier) {
      ref.read(exchangeTableExpandedRowsProvider.notifier).collapse();
    }

    setState(() {
      _isExpanded = false;
      _animation = Tween(
        begin: _layoutProperties.expandedRowHeight,
        end: 0.0,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: kExpandAnimationCurve,
      ));
    });
    _animationController.reforward();

    Future.delayed(kExchangeRowExpandAnimationDuration, () {
      setState(() {
        _renderChildren = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _layoutProperties = context.watchLayoutProperties;

    final levelState = ref.watch(
      exchangeTableExpandedRowsProvider.select(
        (rowsState) => rowsState.rows.firstWhereOrNull((row) => row.level == widget.level),
      ),
    );

    final index = widget.index;
    final expandedIndex = levelState?.index;
    final isExpandedState = index == expandedIndex;
    final isAfterExpanded = index - 1 == expandedIndex;

    if (_isExpanded != isExpandedState) {
      isExpandedState ? _expand() : _collapse(updateNotifier: false);
    }

    void onTap() {
      HapticFeedback.mediumImpact();
      if (_isExpanded || isAfterExpanded) {
        ref.read(exchangeTableExpandedRowsProvider.notifier).collapse();
      } else if (_canExpand) {
        _expandNotify();
      }
    }

    void onLongPress() {
      if (_isExpanded || isAfterExpanded) {
        ref.read(exchangeTableExpandedRowsProvider.notifier).collapseAll();
      }
    }

    final bool showBottomBorder;
    if (isExpandedState) {
      showBottomBorder = true;
    } else if (index < 9 && !isAfterExpanded) {
      showBottomBorder = true;
    } else {
      showBottomBorder = false;
    }

    final rowHeight = widget.level == 0 || isExpandedState || isAfterExpanded
        ? _layoutProperties.rowHeight
        : _layoutProperties.nestedRowHeight;

    final adjustedAnimation = Animation.fromValueListenable(
      _animation,
      transformer: (height) => height / _layoutProperties.expandedRowHeight,
    );

    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          onLongPress: onLongPress,
          child: AnimatedContainer(
            duration: kExchangeRowExpandAnimationDuration,
            height: rowHeight,
            child: _ValuesRow(
              value: widget.value,
              level: widget.level,
              bottomBorder: showBottomBorder,
            ),
          ),
        ),
        SizeTransition(
          sizeFactor: adjustedAnimation,
          child: Column(
            children: _renderChildren
                ? (betweenValues(
                          ref.read(exchangeValuesFromNotifierProvider),
                          widget.value,
                          widget.level,
                        ) ??
                        [])
                    .mapIndexed(
                    (i, e) {
                      // ignore: avoid-recursive-widget-calls
                      return _ExpandableRow(
                        value: e,
                        index: i,
                        level: widget.level + 1,
                      );
                    },
                  ).toList()
                : [],
          ),
        ),
      ],
    );
  }
}

//
// =============================================================================
//

class _ValuesRow extends ConsumerWidget {
  const _ValuesRow({
    required this.value,
    required this.level,
    required this.bottomBorder,
  }) : assert(level >= 0 && level < 100, 'Most likely you have infinite loop');

  final double value;
  final int level;
  final bool bottomBorder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final convertedValues = ref.watch(convertedValuesProvider(value));
    final isThree = convertedValues.$2 != null;
    final currency = ref.watch(exchangeBetweenProvider).from;

    final shadowColor = levelShadowColor(
      context,
      level: level,
      lastShownLevel: ref.watch(exchangeTableExpandedRowsProvider).lastShownLevel,
    );

    return ExchangeTableBackgroundWrapper(
      columnsCount: ref.watch(exchangeBetweenProvider).length,
      child: AnimatedContainer(
        duration: kExchangeRowExpandAnimationDuration,
        decoration: BoxDecoration(
          border: Border(
            bottom: bottomBorder
                ? BorderSide(
                    color: context.tableTheme.borderColor,
                    width: 1,
                  )
                : BorderSide.none,
          ),
          color: shadowColor,
        ),
        child: Row(
          children: [
            Expanded(
              child: _ValueItem(
                value: Value(value, currency),
                isFrom: true,
                level: level,
                group: ref.watch(autoSizeGroupProvider(level)),
                alignment: ColumnAlignment.right,
              ),
            ),
            Expanded(
              child: _ValueItem(
                value: convertedValues.$1,
                isFrom: false,
                level: level,
                group: ref.watch(autoSizeGroupProvider(level)),
                alignment: isThree ? ColumnAlignment.center : ColumnAlignment.left,
              ),
            ),
            if (convertedValues.$2 != null)
              Expanded(
                child: _ValueItem(
                  value: convertedValues.$2!,
                  isFrom: false,
                  level: level,
                  group: ref.watch(autoSizeGroupProvider(level)),
                  alignment: ColumnAlignment.left,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

enum ColumnAlignment {
  left,
  center,
  right,
}

class _ValueItem extends StatelessWidget {
  const _ValueItem({
    required this.value,
    required this.isFrom,
    required this.level,
    required this.group,
    required this.alignment,
  });

  final Value value;
  final bool isFrom;
  final int level;
  final AutoSizeGroup group;
  final ColumnAlignment alignment;

  @override
  Widget build(BuildContext context) {
    final value = this.value;

    final width = MediaQuery.sizeOf(context).width / 2;

    final animation = context.watch<_SlideAnimationProvider>().animation;
    final adjustedAnimation = Animation.fromValueListenable(
      animation,
      transformer: (offset) => Offset(offset.dx / width, offset.dy),
    );

    return Center(
      child: SlideTransition(
        position: adjustedAnimation,
        child: Align(
          alignment: switch (alignment) {
            ColumnAlignment.left => Alignment.centerLeft,
            ColumnAlignment.center => Alignment.center,
            ColumnAlignment.right => Alignment.centerRight,
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kValuePadding),
            child: AutoSizeText(
              group: group,
              overflow: TextOverflow.visible,
              maxLines: 1,
              style: context.textTheme.bodyLarge?.copyWith(fontSize: 17),
              switch (value) {
                MoneyValue() => value.formatM(
                    showFullNumber: level > 2,
                    truncateDecimal: isFrom,
                    roundFractionDigits: level == 0,
                  ),
                TimeValue() => value.format(),
              },
            ),
          ),
        ),
      ),
    );
  }
}

//
// =============================================================================
//

extension on BuildContext {
  _ExchangeTableLayoutProperties get watchLayoutProperties => watch();
}

Color levelShadowColor(BuildContext context, {required int level, required int lastShownLevel}) {
  final opacities = context.isDark ? [0.0, 0.2, 0.3] : [0.0, 0.1, 0.2];
  final double opacity;
  if (level == 0) {
    opacity = opacities[0];
  } else if (level == 1 || level < lastShownLevel) {
    opacity = opacities[1];
  } else {
    opacity = opacities[2];
  }
  return Colors.black.withOpacity(opacity);
}
