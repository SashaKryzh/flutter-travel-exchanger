import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DebugPage extends ConsumerWidget {
  const DebugPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug'),
      ),
      body: ListView(
        children: [
          ElevatedButton(
            onPressed: () => HapticFeedback.lightImpact(),
            child: const Text('Light Impact'),
          ),
          ElevatedButton(
            onPressed: () => HapticFeedback.mediumImpact(),
            child: const Text('Medium Impact'),
          ),
          ElevatedButton(
            onPressed: () => HapticFeedback.heavyImpact(),
            child: const Text('Heavy Impact'),
          ),
          ElevatedButton(
            onPressed: () => HapticFeedback.selectionClick(),
            child: const Text('Selection Click'),
          ),
          ElevatedButton(
            onPressed: () => HapticFeedback.vibrate(),
            child: const Text('Vibrate'),
          ),
        ],
      ),
    );
  }
}
