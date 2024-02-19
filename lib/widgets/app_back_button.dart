import 'dart:io';

import 'package:flutter/material.dart';

@Deprecated('Maybe delete later')
class AppBackButton extends StatelessWidget {
  const AppBackButton({
    super.key,
    this.automaticallyImplyLeading = true,
    this.onTap,
  });

  final bool automaticallyImplyLeading;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final canPop = ModalRoute.of(context)?.canPop ?? false;

    return GestureDetector(
      onTap: onTap ?? (canPop ? () => Navigator.pop(context) : null),
      child: Container(
        // padding: const EdgeInsets.all(16),
        child: Icon(
          Platform.isIOS ? Icons.arrow_back_ios_rounded : Icons.arrow_back_rounded,
          color: canPop ? null : Colors.transparent,
        ),
      ),
    );
  }
}
