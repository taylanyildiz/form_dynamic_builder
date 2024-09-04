import 'package:flutter/material.dart';

class IconCustomButton extends StatelessWidget {
  const IconCustomButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.hoveredColor,
    this.backgroundColor,
    this.hoveredForegroundColor,
    this.color,
    this.padding,
    this.size,
  });

  /// Icon
  final Widget icon;

  /// Pressed icon
  final void Function()? onPressed;

  /// Hovered background color
  ///
  final Color? hoveredColor;

  /// Background color
  final Color? backgroundColor;

  /// Hovered foreground color
  final Color? hoveredForegroundColor;

  /// Icon color
  ///
  final Color? color;

  /// Padding icon
  ///
  final EdgeInsetsGeometry? padding;

  /// Icon size
  final double? size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconButtonTheme = theme.iconButtonTheme;
    return IconButtonTheme(
      data: IconButtonThemeData(
        style: iconButtonTheme.style?.copyWith(
          iconColor: _iconColor(iconButtonTheme.style?.iconColor),
          backgroundColor: _backgroundColor(iconButtonTheme.style?.backgroundColor),
        ),
      ),
      child: IconButton(
        iconSize: size,
        hoverColor: hoveredColor,
        padding: padding,
        onPressed: onPressed,
        icon: icon,
      ),
    );
  }

  WidgetStateProperty<Color>? _iconColor(WidgetStateProperty<Color?>? iconColor) {
    if (hoveredForegroundColor == null && color == null) return null;
    return WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.hovered) && hoveredForegroundColor != null) return hoveredForegroundColor!;
      return color ?? iconColor?.resolve(states) ?? Colors.black;
    });
  }

  _backgroundColor(WidgetStateProperty<Color?>? backgroundColorState) {
    if (backgroundColor == null && hoveredColor == null) return null;
    return WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.hovered) && hoveredColor != null) return hoveredColor!;
      return backgroundColor ?? backgroundColorState?.resolve(states) ?? Colors.transparent;
    });
  }
}
