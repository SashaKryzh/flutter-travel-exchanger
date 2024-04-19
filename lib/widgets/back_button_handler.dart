import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:travel_exchanger/pages/home_page.dart/exchange_table/exchange_table_providers.dart';
import 'package:travel_exchanger/widgets/toast.dart';

class BackButtonHandler extends HookConsumerWidget {
  static const _allowBackDuration = Duration(seconds: 2);

  const BackButtonHandler({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fToast = useMemoized(() {
      final fToast = FToast();
      fToast.init(context);
      return fToast;
    });

    final lastPressedTime = useRef<DateTime?>(null);

    Future<bool> onBackButtonPressed() async {
      if (ref.read(exchangeTableExpandedRowsProvider).rows.isNotEmpty) {
        ref.read(exchangeTableExpandedRowsProvider.notifier).collapse();
        return true;
      }

      final lastPressed = lastPressedTime.value;
      if (lastPressed != null &&
          lastPressed.difference(DateTime.now()).abs() <= _allowBackDuration) {
        return false;
      }
      lastPressedTime.value = DateTime.now();

      fToast.showToast(
        positionedToastBuilder: topCenterToastBuilder,
        toastDuration: _allowBackDuration,
        child: const ToastContainer(
          child: Text('Press back again to exit'),
        ),
      );
      return true;
    }

    return BackButtonListener(
      onBackButtonPressed: onBackButtonPressed,
      child: child,
    );
  }
}
