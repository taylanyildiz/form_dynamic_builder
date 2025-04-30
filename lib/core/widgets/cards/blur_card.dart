import 'dart:ui';
import 'package:flutter/material.dart';

class BlurCard extends StatelessWidget {
  BlurCard({
    super.key,
    required this.child,
    (double sigmaX, double sigmaY)? blur,
    Color? color,
    double? radius,
    BorderRadius? borderRadius,
  })  : blur = blur ?? (5.0, 5.0),
        color = color ?? Colors.white.withValues(alpha: .4),
        borderRadius = borderRadius ?? (radius != null ? BorderRadius.circular(radius) : BorderRadius.zero),
        assert(borderRadius == null || radius == null);

  /// Blur child
  final Widget child;

  /// Blur record
  /// default (5.0, 5.0)
  final (double sigmaX, double sigmaY) blur;

  /// Blur color
  /// default[Colors.white.withValues(alpha: .4)]
  final Color color;

  /// Border radius
  /// defalut [BorderRadius.zero]
  final BorderRadiusGeometry borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur.$1, sigmaY: blur.$2),
        child: Card(
          margin: EdgeInsets.zero,
          elevation: 0.0,
          color: color,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: borderRadius, side: BorderSide.none),
          child: child,
        ),
      ),
    );
  }
}
