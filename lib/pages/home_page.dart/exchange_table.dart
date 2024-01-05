import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' hide Provider;
import 'package:provider/provider.dart';
import 'package:travel_exchanger/pages/home_page.dart/exchange_table_background.dart';
import 'package:travel_exchanger/pages/home_page.dart/exchange_table_providers.dart';
import 'package:travel_exchanger/utils/extensions.dart';

const exchangeRowExpandAnimationDuration = Duration(milliseconds: 200);
const expandAnimationCurve = Curves.easeInOut;

var valuePadding = 30.0;
double get activationDelta => valuePadding * 0.8;

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
    dx = dx.clamp(-valuePadding, valuePadding);
    return Offset(dx, 0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onHorizontalDragUpdate: (details) => _updateDrag(details.delta.dx),
      onHorizontalDragEnd: (_) => _resetDrag(),
      child: ProxyProvider0(
        create: (_) => _SlideAnimationProvider(animation),
        update: (_, __) => _SlideAnimationProvider(animation),
        child: TableColumnsBackgroundWrapper(
          columnsCount: 2,
          child: LayoutBuilder(
            builder: (context, constraints) => ProxyProvider0(
              create: (_) => _ExchangeTableLayoutProperties(tableHeight: constraints.maxHeight),
              update: (_, __) => _ExchangeTableLayoutProperties(tableHeight: constraints.maxHeight),
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

/// Handles expansion of rows
class _ExchangeTableContent extends ConsumerStatefulWidget {
  const _ExchangeTableContent();

  @override
  ConsumerState<_ExchangeTableContent> createState() => _ExchangeTableContentState();
}

class _ExchangeTableContentState extends ConsumerState<_ExchangeTableContent> {
  late final _layoutProperties = context.layoutProperties;

  final _scrollController = ScrollController();
  final _offsets = <double>[];

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

  void _scrollTo(double offset) {
    _scrollController.animateTo(
      offset,
      duration: exchangeRowExpandAnimationDuration,
      curve: expandAnimationCurve,
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(exchangeTableExpandedRowsNotifierProvider, (prev, next) {
      if (prev == null || prev.length < next.length) {
        _expand(level: next.last.level, index: next.last.index);
      } else {
        _collapse();
      }
    });

    final values = ref.watch(exchangeValuesProvider);

    return SingleChildScrollView(
      controller: _scrollController,
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: values.mapIndexed(
          (i, e) {
            return _ExpandableRow(
              level: 0,
              index: i,
              value: e,
            );
          },
        ).toList(),
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

  final double value;
  final int index;
  final int level;

  @override
  ConsumerState<_ExpandableRow> createState() => _ExpandableRowState();
}

class _ExpandableRowState extends ConsumerState<_ExpandableRow>
    with SingleTickerProviderStateMixin {
  late final _layoutProperties = context.layoutProperties;

  late final _animationController =
      AnimationController(duration: exchangeRowExpandAnimationDuration, vsync: this);
  late var _animation = Tween(begin: 0.0, end: 0.0)
      .animate(CurvedAnimation(parent: _animationController, curve: expandAnimationCurve));

  bool get _canExpand => ref.read(exchangeValuesFromNotifierProvider).step(widget.level) != null;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  var _isExpanded = false;
  var _renderChildren = false;

  void _onExpand({required bool isExpanded, required bool isAfterExpanded}) {
    if (isAfterExpanded) {
      ref.read(exchangeTableExpandedRowsNotifierProvider.notifier).collapse();
    } else if (isExpanded) {
      _collapse();
    } else if (_canExpand) {
      _expand();
    }
  }

  void _expand({bool updateNotifier = true}) {
    if (updateNotifier) {
      ref
          .read(exchangeTableExpandedRowsNotifierProvider.notifier)
          .expand(level: widget.level, index: widget.index);
    }

    setState(() {
      _isExpanded = true;
      _renderChildren = true;
      _animation = Tween(
        begin: 0.0,
        end: _layoutProperties.expandedRowHeight,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: expandAnimationCurve,
      ));
    });
    _animationController.reforward();
  }

  void _collapse({bool updateNotifier = true}) {
    if (updateNotifier) {
      ref.read(exchangeTableExpandedRowsNotifierProvider.notifier).collapse();
    }

    setState(() {
      _isExpanded = false;
      _animation = Tween(
        begin: _layoutProperties.expandedRowHeight,
        end: 0.0,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: expandAnimationCurve,
      ));
    });
    _animationController.reforward();

    Future.delayed(exchangeRowExpandAnimationDuration, () {
      setState(() {
        _renderChildren = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final index = widget.index;

    final expandedIndex = ref
        .watch(exchangeTableExpandedRowsNotifierProvider
            .select((rows) => rows.firstWhereOrNull((e) => e.level == widget.level)))
        ?.index;

    final isExpanded = index == expandedIndex;
    final isAfterExpanded = index - 1 == expandedIndex;

    if (_isExpanded != isExpanded) {
      isExpanded ? _expand(updateNotifier: false) : _collapse(updateNotifier: false);
    }

    final bool showBottomBorder;
    if (isExpanded) {
      showBottomBorder = true;
    } else if (index < 9 && !isAfterExpanded) {
      showBottomBorder = true;
    } else {
      showBottomBorder = false;
    }

    final rowHeight = widget.level == 0 || isExpanded || isAfterExpanded
        ? _layoutProperties.rowHeight
        : _layoutProperties.nestedRowHeight;

    final adjustedAnimation = Animation.fromValueListenable(
      _animation,
      transformer: (height) => height / _layoutProperties.expandedRowHeight,
    );

    return Column(
      children: [
        GestureDetector(
          onTap: () => _onExpand(isExpanded: isExpanded, isAfterExpanded: isAfterExpanded),
          child: AnimatedContainer(
            duration: exchangeRowExpandAnimationDuration,
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
            // TODO: handle swipe less when level doesn't exists for a smaller number
            children: _renderChildren
                ? (betweenValues(ref.read(exchangeValuesFromNotifierProvider), widget.value,
                            widget.level) ??
                        [])
                    .mapIndexed(
                    (i, e) {
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

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: bottomBorder
              ? const BorderSide(
                  color: Colors.black,
                  width: 1,
                )
              : BorderSide.none,
        ),
        color: Colors.black.withOpacity((0.2 * level).clamp(0, 1)),
      ),
      child: Row(
        children: [
          Expanded(
            child: _ValueItem(
              value: value,
              alignment: _ValueItemAlignment.right,
            ),
          ),
          Expanded(
            child: _ValueItem(
              value: convertedValues.$1,
              alignment: _ValueItemAlignment.left,
            ),
          ),
        ],
      ),
    );
  }
}

enum _ValueItemAlignment {
  left,
  center,
  right,
}

class _ValueItem extends StatelessWidget {
  const _ValueItem({
    required this.value,
    required this.alignment,
  });

  final double value;
  final _ValueItemAlignment alignment;

  @override
  Widget build(BuildContext context) {
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
            _ValueItemAlignment.left => Alignment.centerLeft,
            _ValueItemAlignment.center => Alignment.center,
            _ValueItemAlignment.right => Alignment.centerRight,
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: valuePadding),
            child: Text(
              value.toStringAsFixed(2),
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
  _ExchangeTableLayoutProperties get layoutProperties => read<_ExchangeTableLayoutProperties>();
}
