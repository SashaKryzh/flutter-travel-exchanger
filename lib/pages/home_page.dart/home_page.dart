import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
        child: const _ExchangeTableRows(),
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

class _ExchangeTableRows extends ConsumerWidget {
  const _ExchangeTableRows();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final values = ref.watch(exchangeValuesProvider);

    return Stack(
      children: [
        Positioned.fill(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  color: Colors.grey,
                ),
              ),
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
          ),
        ),
        Column(
          children: values
              .map(
                (e) => Expanded(
                  child: ValuesRow(value: e),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class ValuesRow extends StatelessWidget {
  const ValuesRow({
    super.key,
    required this.value,
  });

  final double value;

  @override
  Widget build(BuildContext context) {
    final convertedValue = value * 9.2;

    return Row(
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
