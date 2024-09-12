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
            version.when(
              data: (data) => Text(data),
              error: (error, stackTrace) => Text(error.toString()),
              loading: () => const SizedBox(
                height: 10,
                width: 10,
                child: CupertinoActivityIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
