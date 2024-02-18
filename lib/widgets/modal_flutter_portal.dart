// ignore_for_file: prefer-match-file-name, prefer-single-widget-per-file

import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';

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
    return ModalBarrier(
      visible: visible,
      onTap: onDismiss,
      child: PortalTarget(
        visible: visible,
        closeDuration: kThemeAnimationDuration,
        portalFollower: TweenAnimationBuilder<double>(
          duration: kThemeAnimationDuration,
          curve: Curves.easeInOut,
          tween: Tween(begin: 0, end: visible ? 1 : 0),
          builder: (context, progress, child) {
            return Opacity(
              opacity: progress,
              child: child,
            );
          },
          child: Material(
            child: Center(child: modal),
          ),
        ),
        child: child,
      ),
    );
  }
}

class ModalBarrier extends StatelessWidget {
  const ModalBarrier({
    super.key,
    required this.onTap,
    required this.visible,
    required this.child,
  });

  final bool visible;
  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PortalTarget(
      visible: visible,
      closeDuration: kThemeAnimationDuration,
      portalFollower: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: AnimatedContainer(
          duration: kThemeAnimationDuration,
          color: visible ? Colors.black54 : Colors.transparent,
        ),
      ),
      child: child,
    );
  }
}
