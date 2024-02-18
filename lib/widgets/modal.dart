// ignore_for_file: avoid-unnecessary-stateful-widgets, prefer-match-file-name, prefer-single-widget-per-file

import 'package:flutter/material.dart';

/// Designed to work with OverlayPortal.

class Portal extends StatefulWidget {
  const Portal({
    super.key,
    required this.visible,
    this.closeDuration = kThemeAnimationDuration,
    required this.overlayBuilder,
    this.child,
  });

  final bool visible;
  final Duration closeDuration;
  // ignore: prefer-correct-callback-field-name
  final WidgetBuilder overlayBuilder;
  final Widget? child;

  @override
  State<Portal> createState() => _PortalState();
}

class _PortalState extends State<Portal> {
  final _controller = OverlayPortalController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.visible) {
        _toggle(true, delayed: false);
      }
    });
  }

  @override
  void didUpdateWidget(covariant Portal oldWidget) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.visible && !_controller.isShowing) {
        _toggle(true, delayed: false);
      } else if (!widget.visible && _controller.isShowing) {
        _toggle(false);
      }
    });
    super.didUpdateWidget(oldWidget);
  }

  Future<void> _toggle(bool visible, {bool delayed = true}) async {
    if (!visible) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
    if (delayed) {
      await Future<void>.delayed(widget.closeDuration);
    }
    if (visible) {
      _controller.show();
    } else {
      _controller.hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    return OverlayPortal(
      controller: _controller,
      overlayChildBuilder: widget.overlayBuilder,
      child: widget.child,
    );
  }
}

class Modal extends StatelessWidget {
  const Modal({
    super.key,
    required this.visible,
    required this.onDismiss,
    required this.modal,
    required this.child,
  });

  final bool visible;
  final VoidCallback onDismiss;
  final Widget modal;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Portal(
      visible: visible,
      overlayBuilder: (context) {
        return ModalBarrier(
          visible: visible,
          onTap: onDismiss,
          child: TweenAnimationBuilder<double>(
            duration: kThemeAnimationDuration,
            tween: Tween(begin: 0, end: visible ? 1 : 0),
            curve: Curves.easeInOut,
            builder: (context, value, child) => Opacity(
              opacity: value,
              child: child,
            ),
            child: modal,
          ),
        );
      },
      child: child,
    );
  }
}

class ModalBarrier extends StatelessWidget {
  const ModalBarrier({
    super.key,
    required this.visible,
    required this.onTap,
    required this.child,
  });

  final bool visible;
  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: TweenAnimationBuilder<Color?>(
        duration: kThemeAnimationDuration,
        tween: ColorTween(
          begin: Colors.transparent,
          end: visible ? const Color(0x80000000) : Colors.transparent,
        ),
        builder: (context, value, child) => ColoredBox(
          color: value!,
          child: child,
        ),
        child: Center(
          child: GestureDetector(
            onTap: () {},
            child: child,
          ),
        ),
      ),
    );
  }
}
