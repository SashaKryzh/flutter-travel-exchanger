import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' hide Provider;
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:travel_exchanger/pages/home_page.dart/exchange_table_providers.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: SafeArea(
        child: ExchangeTable(),
      ),
    );
  }
}

var valuePadding = 30.0;
double get activationDelta => valuePadding * 0.8;

class ExchangeTable extends ConsumerStatefulWidget {
  const ExchangeTable({super.key});

  @override
  ConsumerState<ExchangeTable> createState() => _ExchangeTableState();
}

class _ExchangeTableState extends ConsumerState<ExchangeTable> with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(duration: Duration.zero, vsync: this);
  late var animation = Tween(begin: Offset.zero, end: Offset.zero).animate(_controller);

  var activated = false;
  var activatedLeft = false;

  void _updateDrag(double delta) {
    final dragDelta = animation.value.dx + delta;
    // logger.d('Update drag: $dragDelta');

    _controller.duration = Duration.zero;
    animation = Tween(
      begin: _offset(animation.value.dx),
      end: _offset(dragDelta),
    ).animate(_controller);
    _controller
      ..reset()
      ..forward();
    setState(() {});

    if (activatedLeft && dragDelta > 0 || !activatedLeft && dragDelta < 0) {
      activated = false;
    }

    if (!activated && dragDelta.abs() > activationDelta) {
      activated = true;
      final notifier = ref.read(exchangeValuesFromNotifierProvider.notifier);

      final draggedLeft = dragDelta < 0;
      if (draggedLeft) {
        notifier.increase();
      } else {
        notifier.decrease();
      }

      activatedLeft = draggedLeft;
    }
  }

  void _resetDrag() {
    // logger.d('Reset drag');
    activated = false;

    _controller.duration = const Duration(milliseconds: 100);
    animation = Tween(
      begin: _offset(animation.value.dx),
      end: _offset(0),
    ).animate(_controller);
    _controller
      ..reset()
      ..forward();
    setState(() {});
  }

  Offset _offset(double dx) {
    dx = dx.clamp(-valuePadding, valuePadding);
    return Offset(dx, 0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onHorizontalDragUpdate: (details) {
        _updateDrag(details.delta.dx);
      },
      onHorizontalDragEnd: (details) {
        _resetDrag();
      },
      child: ProxyProvider0(
        create: (_) => SlideAnimationProvider(animation),
        update: (context, value) => SlideAnimationProvider(animation),
        child: Stack(
          children: [
            const TableColumnsBackground(
              columnsCount: 2,
            ),
            LayoutBuilder(
              builder: (context, constraints) => Provider(
                create: (_) => ExchangeTableLayoutProperties(
                  tableHeight: constraints.maxHeight,
                ),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: constraints,
                    child: const _ExchangeTableRows(),
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

const exchangeRowExpandAnimationDuration = Duration(milliseconds: 200);

class _ExchangeTableRows extends ConsumerStatefulWidget {
  const _ExchangeTableRows();

  @override
  ConsumerState<_ExchangeTableRows> createState() => _ExchangeTableRowsState();
}

class _ExchangeTableRowsState extends ConsumerState<_ExchangeTableRows> {
  final _scrollController = ScrollController();
  int? _expandedIndex;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  List<double> offsets = [];

  @override
  Widget build(BuildContext context) {
    final values = ref.watch(exchangeValuesProvider);

    final layoutProperties = context.read<ExchangeTableLayoutProperties>();

    void onExpandChanged(int index, int level, bool isExpanded) {
      if (isExpanded) {
        final double offset;
        if (level == 0) {
          offset = index * layoutProperties.rowHeight;
        } else {
          offset =
              offsets.last + layoutProperties.rowHeight + layoutProperties.nestedRowHeight * index;
        }

        offsets.add(offset);

        _scrollController.animateTo(
          offset,
          duration: exchangeRowExpandAnimationDuration,
          curve: Curves.easeInOut,
        );
      } else {
        offsets.removeLast();
        _scrollController.animateTo(
          offsets.lastOrNull ?? 0,
          duration: exchangeRowExpandAnimationDuration,
          curve: Curves.easeInOut,
        );
      }
      if (level == 0) {
        setState(() {
          _expandedIndex = isExpanded ? index : null;
        });
      }
    }

    return SingleChildScrollView(
      controller: _scrollController,
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: values
            .mapIndexed(
              (i, e) => ExchangeTableExpandableRow(
                height: layoutProperties.rowHeight,
                value: e,
                index: i,
                level: 0,
                onExpandChanged: (index, isExpanded, level) =>
                    onExpandChanged(index, level, isExpanded),
                bottomBorder: (i < 9 || i == _expandedIndex) && i - 1 != _expandedIndex,
                layoutProperties: layoutProperties,
              ),
            )
            .toList(),
      ),
    );
  }
}

class TableColumnsBackground extends StatelessWidget {
  const TableColumnsBackground({
    super.key,
    required this.columnsCount,
  });

  final int columnsCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            color: Colors.grey,
          ),
        ),
        for (var i = 1; i < columnsCount; i++) ...[
          const VerticalDivider(
            width: 1,
            color: Colors.black,
          ),
          Expanded(
            child: Container(
              color: Colors.grey[300],
            ),
          ),
        ],
      ],
    );
  }
}

class ExchangeTableExpandableRow extends StatefulWidget {
  const ExchangeTableExpandableRow({
    super.key,
    required this.value,
    required this.height,
    required this.index,
    required this.level,
    required this.onExpandChanged,
    this.onChildExpandChanged,
    required this.bottomBorder,
    required this.layoutProperties,
  }) : assert(level >= 0 && level < 100, 'Most likely you have infinite loop');

  final double value;
  final double height;
  final int index;
  final int level;
  final void Function(int index, bool isExpanded, int level) onExpandChanged;

  /// ! Temp
  final ExchangeTableLayoutProperties layoutProperties;

  /// Should be used only internally
  final ValueChanged<bool>? onChildExpandChanged;
  final bool bottomBorder;

  @override
  State<ExchangeTableExpandableRow> createState() => _ExchangeTableExpandableRowState();
}

class _ExchangeTableExpandableRowState extends State<ExchangeTableExpandableRow>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    duration: exchangeRowExpandAnimationDuration,
    vsync: this,
  );
  late var animation = Tween(
    begin: 0.0,
    end: widget.layoutProperties.expandedRowHeight,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
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
        begin: widget.layoutProperties.expandedRowHeight,
        end: 0.0,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
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
          end: widget.layoutProperties.expandedRowHeight,
        ).animate(CurvedAnimation(
          parent: _controller,
          curve: Curves.easeInOut,
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
      curve: Curves.easeInOut,
    ));
  }

  double get expandedContentHeight =>
      widget.layoutProperties.expandedRowHeight * (expandedChildrenCount + 1);

  double nextExpandedContentHeight(int nextExpandedChildrenCount) =>
      widget.layoutProperties.expandedRowHeight * (nextExpandedChildrenCount + 1);

  @override
  Widget build(BuildContext context) {
    // final layoutProperties = context.read<ExchangeTableLayoutProperties>();

    return Column(
      children: [
        GestureDetector(
          onTap: _toggleExpanded,
          child: AnimatedContainer(
            duration: exchangeRowExpandAnimationDuration,
            height: isExpanded ? widget.layoutProperties.rowHeight : widget.height,
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
                          height: widget.layoutProperties.nestedRowHeight,
                          value: e,
                          index: i,
                          level: widget.level + 1,
                          onExpandChanged: (index, value, level) =>
                              _childExpandedChanged(index, value, level),
                          bottomBorder: true,
                          layoutProperties: widget.layoutProperties,
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

class ValuesRow extends StatelessWidget {
  const ValuesRow({
    super.key,
    required this.value,
    this.level = 0,
    this.bottomBorder = true,
  }) : assert(level >= 0);

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
        color: level > 0 ? Colors.black.withOpacity((0.2 * level).clamp(0, 1)) : null,
      ),
      child: Row(
        children: [
          Expanded(
            child: ValueItem(
              value: value,
              padding: valuePadding,
              alignment: ValueItemAlignment.right,
            ),
          ),
          Expanded(
            child: ValueItem(
              value: convertedValue,
              padding: valuePadding,
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
    this.alignment = ValueItemAlignment.center,
    this.padding = 10,
  });

  final double value;
  final ValueItemAlignment alignment;
  final double padding;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width / 2;
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
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: Text(
              value.toStringAsFixed(2),
            ),
          ),
        ),
      ),
    );
  }
}
