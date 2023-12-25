import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' hide Provider;
import 'package:logger/logger.dart';
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
        create: (_) => SlideAnimationProvider(animation),
        update: (_, __) => SlideAnimationProvider(animation),
        child: Stack(
          children: [
            const TableColumnsBackground(
              columnsCount: 2,
            ),
            LayoutBuilder(
              builder: (context, constraints) => Provider(
                create: (_) => ExchangeTableLayoutProperties(tableHeight: constraints.maxHeight),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: constraints,
                    child: const _ExchangeTableContent(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SlideAnimationProvider extends Equatable {
  final Animation<Offset> animation;

  const SlideAnimationProvider(this.animation);

  @override
  List<Object?> get props => [animation];
}

class ExchangeTableLayoutProperties extends Equatable {
  const ExchangeTableLayoutProperties({
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
  int? _expandedIndex;

  @override
  void initState() {
    // ref.listen(exchangeTableExpandedRowsNotifierProvider, (_, next) => );
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onExpandChanged(
    bool expanded, {
    required int level,
    required int index,
  }) {
    if (expanded) {
      final double offset;
      if (level == 0) {
        offset = index * _layoutProperties.rowHeight;
      } else {
        offset =
            _offsets.last + _layoutProperties.rowHeight + _layoutProperties.nestedRowHeight * index;
      }

      _offsets.add(offset);
      _scrollTo(_offsets.last);
    } else {
      _offsets.removeLast();
      _scrollTo(_offsets.lastOrNull ?? 0);
    }

    if (level == 0) {
      setState(() {
        _expandedIndex = expanded ? index : null;
      });
    }
  }

  // void _collapse() {
  //     _offsets.removeLast();
  //     _scrollTo(_offsets.lastOrNull ?? 0);
  // }

  void _scrollTo(double offset) {
    _scrollController.animateTo(
      offset,
      duration: exchangeRowExpandAnimationDuration,
      curve: expandAnimationCurve,
    );
  }

  @override
  Widget build(BuildContext context) {
    final values = ref.watch(exchangeValuesProvider);

    return SingleChildScrollView(
      controller: _scrollController,
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: values.mapIndexed(
          (i, e) {
            return ExchangeTableExpandableRow(
              level: 0,
              index: i,
              value: e,
              onExpandChanged: (index, isExpanded, level) => _onExpandChanged(
                isExpanded,
                index: index,
                level: level,
              ),
              bottomBorder: (i < 9 || i == _expandedIndex) && i - 1 != _expandedIndex,
            );
          },
        ).toList(),
      ),
    );
  }
}

class ExchangeTableExpandableRow extends StatefulWidget {
  const ExchangeTableExpandableRow({
    super.key,
    required this.value,
    required this.index,
    required this.level,
    required this.onExpandChanged,
    this.onChildExpandChanged,
    required this.bottomBorder,
  }) : assert(level >= 0 && level < 100, 'Most likely you have infinite loop');

  final double value;
  final int index;
  final int level;
  final void Function(int index, bool isExpanded, int level) onExpandChanged;

  /// Should be used only internally
  final ValueChanged<bool>? onChildExpandChanged;
  final bool bottomBorder;

  @override
  State<ExchangeTableExpandableRow> createState() => _ExchangeTableExpandableRowState();
}

class _ExchangeTableExpandableRowState extends State<ExchangeTableExpandableRow>
    with SingleTickerProviderStateMixin {
  late final layoutProperties = context.layoutProperties;

  late final _controller = AnimationController(
    duration: exchangeRowExpandAnimationDuration,
    vsync: this,
  );
  late var animation = Tween(
    begin: 0.0,
    end: layoutProperties.expandedRowHeight,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: expandAnimationCurve,
  ));

  var isExpanded = false;
  var renderChildren = false;
  var expandedChildrenCount = 0;

  void _toggleExpanded() {
    if (isExpanded) {
      // Close
      setState(() {
        isExpanded = false;
        expandedChildrenCount = 0;
      });

      widget.onExpandChanged(widget.index, isExpanded, widget.level);

      animation = Tween(
        begin: layoutProperties.expandedRowHeight,
        end: 0.0,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: expandAnimationCurve,
      ));
      _controller.reset();
      _controller.forward();

      Future.delayed(exchangeRowExpandAnimationDuration, () {
        setState(() {
          renderChildren = false;
        });
      });
    } else {
      // Open
      setState(() {
        renderChildren = true;
      });

      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          isExpanded = !isExpanded;
        });
        widget.onExpandChanged(widget.index, isExpanded, widget.level);

        animation = Tween(
          begin: 0.0,
          end: layoutProperties.expandedRowHeight,
        ).animate(CurvedAnimation(
          parent: _controller,
          curve: expandAnimationCurve,
        ));
        _controller.reset();
        _controller.forward();
      });
    }
  }

  void _childExpandedChanged(int index, bool expanded, int level) {
    widget.onExpandChanged(index, expanded, level);

    setState(() {
      expandedChildrenCount += expanded ? 1 : -1;
    });

    animation = Tween(
      begin: expandedContentHeight,
      end: nextExpandedContentHeight(expandedChildrenCount),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: expandAnimationCurve,
    ));
  }

  double get expandedContentHeight =>
      layoutProperties.expandedRowHeight * (expandedChildrenCount + 1);

  double nextExpandedContentHeight(int nextExpandedChildrenCount) =>
      layoutProperties.expandedRowHeight * (nextExpandedChildrenCount + 1);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _toggleExpanded,
          child: AnimatedContainer(
            duration: exchangeRowExpandAnimationDuration,
            height: isExpanded
                ? layoutProperties.rowHeight
                : widget.level == 0
                    ? layoutProperties.rowHeight
                    : layoutProperties.nestedRowHeight,
            child: ValuesRow(
              value: widget.value,
              level: widget.level,
              bottomBorder: widget.bottomBorder,
            ),
          ),
        ),
        SizeTransition(
          sizeFactor: Animation.fromValueListenable(
            animation,
            transformer: (height) => height / expandedContentHeight,
          ),
          child: SizedBox(
            height: expandedContentHeight,
            child: Column(
              children: renderChildren
                  ? betweenValues(widget.value)
                      .mapIndexed(
                        (i, e) => ExchangeTableExpandableRow(
                          value: e,
                          index: i,
                          level: widget.level + 1,
                          onExpandChanged: (index, value, level) =>
                              _childExpandedChanged(index, value, level),
                          bottomBorder: true,
                        ),
                      )
                      .toList()
                  : [],
            ),
          ),
        ),
      ],
    );
  }
}

//
// =============================================================================
//

class ValuesRow extends StatelessWidget {
  const ValuesRow({
    super.key,
    required this.value,
    required this.level,
    required this.bottomBorder,
  }) : assert(level >= 0 && level < 100, 'Most likely you have infinite loop');

  final double value;
  final int level;
  final bool bottomBorder;

  @override
  Widget build(BuildContext context) {
    final convertedValue = value * 9.2;

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
            child: ValueItem(
              value: value,
              alignment: ValueItemAlignment.right,
            ),
          ),
          Expanded(
            child: ValueItem(
              value: convertedValue,
              alignment: ValueItemAlignment.left,
            ),
          ),
        ],
      ),
    );
  }
}

enum ValueItemAlignment {
  left,
  center,
  right,
}

class ValueItem extends StatelessWidget {
  const ValueItem({
    super.key,
    required this.value,
    required this.alignment,
  });

  final double value;
  final ValueItemAlignment alignment;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width / 2;

    final animation = context.watch<SlideAnimationProvider>().animation;
    final adjustedAnimation = Animation.fromValueListenable(
      animation,
      transformer: (offset) => Offset(offset.dx / width, offset.dy),
    );

    return Center(
      child: SlideTransition(
        position: adjustedAnimation,
        child: Align(
          alignment: switch (alignment) {
            ValueItemAlignment.left => Alignment.centerLeft,
            ValueItemAlignment.center => Alignment.center,
            ValueItemAlignment.right => Alignment.centerRight,
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
  ExchangeTableLayoutProperties get layoutProperties => read<ExchangeTableLayoutProperties>();
}
