import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/core/providers/providers.dart';

/// Display application version number

class TextVersion extends ConsumerWidget {
  const TextVersion({
    super.key,
    this.foregroundColor,
  });

  /// Foreground color
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final version = ref.watch(versionProvider);

    return Theme(
      data: theme.copyWith(
          textTheme: textTheme.copyWith(
        bodyMedium: textTheme.titleSmall?.copyWith(
          color: foregroundColor,
        ),
      )),
      child: Material(
        color: Colors.transparent,
        elevation: 0.0,
        child: Row(
          children: [
            const Text(
              "Version",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 3.0),
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 30),
              child: switch (version) {
                AsyncData(value: var value) => Text(value),
                AsyncError(error: var _) => const Text("—"),
                _ => const CupertinoActivityIndicator(radius: 7.0),
              },
            ),
          ],
        ),
      ),
    );
  }
}
