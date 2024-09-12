import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Display application version number
class TextVersion extends StatefulWidget {
  const TextVersion({
    super.key,
    this.foregroundColor,
  });

  /// Foreground color
  final Color? foregroundColor;

  @override
  State<TextVersion> createState() => _TextVersionState();
}

class _TextVersionState extends State<TextVersion> {
  String version = "-";

  @override
  void initState() {
    WidgetsBinding.instance.scheduleFrameCallback(scheduleFrameCallback);
    super.initState();
  }

  void scheduleFrameCallback(_) async {
    final info = await PackageInfo.fromPlatform();
    if (!mounted) return;
    setState(() => version = info.version);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Text(
      "Version $version",
      style: textTheme.titleSmall?.copyWith(
        color: widget.foregroundColor,
      ),
    );
  }
}
