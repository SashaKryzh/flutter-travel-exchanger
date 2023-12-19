import 'package:flutter/widgets.dart';

extension WidgetX on Widget {
  @widgetFactory
  Widget textStyle(TextStyle? style, {TextAlign? align}) {
    return DefaultTextStyle.merge(
      style: style,
      textAlign: align,
      child: this,
    );
  }

  @widgetFactory
  Widget textAlignX(TextAlign align) => textStyle(null, align: align);

  @widgetFactory
  Widget padding({
    double? all,
    double? x,
    double? y,
    double? t,
    double? r,
    double? b,
    double? l,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        top: all ?? y ?? t ?? 0,
        right: all ?? x ?? r ?? 0,
        bottom: all ?? y ?? b ?? 0,
        left: all ?? x ?? l ?? 0,
      ),
      child: this,
    );
  }

  @widgetFactory
  Widget onTap(VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: this,
    );
  }

  @widgetFactory
  Widget sliver() => SliverToBoxAdapter(child: this);
}
