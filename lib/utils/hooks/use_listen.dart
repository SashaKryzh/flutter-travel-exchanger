import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void useListen(Listenable listenable, VoidCallback listener) {
  use(_ListenHook(listenable, listener));
}

class _ListenHook extends Hook<void> {
  const _ListenHook(this.listenable, this.listener);

  final Listenable? listenable;
  // ignore: prefer-correct-callback-field-name
  final VoidCallback listener;

  @override
  _ListenStateHook createState() => _ListenStateHook();
}

class _ListenStateHook extends HookState<void, _ListenHook> {
  @override
  void initHook() {
    super.initHook();
    hook.listenable?.addListener(_listener);
  }

  @override
  void didUpdateHook(_ListenHook oldHook) {
    super.didUpdateHook(oldHook);
    if (hook.listenable != oldHook.listenable) {
      oldHook.listenable?.removeListener(_listener);
      hook.listenable?.addListener(_listener);
    }
  }

  @override
  void dispose() {
    hook.listenable?.removeListener(_listener);
  }

  void _listener() {
    hook.listener();
  }

  @override
  void build(BuildContext context) => {};

  @override
  String get debugLabel => 'useListen';

  @override
  Object get debugValue => [hook.listenable, hook.listener];
}
