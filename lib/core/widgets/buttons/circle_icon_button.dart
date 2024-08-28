import 'package:flutter/material.dart';

/// Circle Icon button
///
/// All Contain veriables equivalent [Card] like
///
/// * [backgroundColor]
/// * [elevation]
/// * [shadowColor]
class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    super.key,
    required this.onTap,
    required this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.size,
    EdgeInsetsGeometry? padding,
    this.elevation,
    this.shadowColor,
  }) : padding = padding ?? const EdgeInsets.all(4.0);

  /// Icon of button
  final Widget icon;

  /// Tap icon
  final void Function()? onTap;

  /// Foreground color
  final Color? foregroundColor;

  /// Background color
  final Color? backgroundColor;

  /// Icon size
  /// circle depends [size] and [padding]
  final double? size;

  /// Circle contain padding
  /// will make changes contain size
  ///
  /// default [EdgeInsets.all(4.0)]
  final EdgeInsetsGeometry padding;

  /// Contain shadow elevation
  final double? elevation;

  /// Shadow color
  final Color? shadowColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: elevation,
        shadowColor: shadowColor,
        color: backgroundColor,
        shape: const CircleBorder(),
        child: Padding(
          padding: padding,
          child: IconTheme(
            data: theme.iconTheme.copyWith(
              color: foregroundColor,
              size: size,
            ),
            child: icon,
          ),
        ),
      ),
    );
  }
}
