import '/core/constants/constants.dart';
import 'package:flutter/material.dart';

class IconCardButton extends StatelessWidget {
  IconCardButton({
    super.key,
    required this.icon,
    Color? backgroundColor,
    required this.onTap,
  }) : backgroundColor = backgroundColor ?? ColorConstants.videntium600;

  /// Card icon
  final Widget icon;

  /// Color of card
  final Color backgroundColor;

  /// Tap button
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Theme(
      data: theme.copyWith(
        iconTheme: theme.iconTheme.copyWith(
          color: Colors.white,
        ),
        textTheme: textTheme.copyWith(
          bodyMedium: theme.elevatedButtonTheme.style?.textStyle?.resolve({}),
        ),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          margin: EdgeInsets.zero,
          color: backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: icon,
          ),
        ),
      ),
    );
  }
}
