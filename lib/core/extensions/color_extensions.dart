import 'package:flutter/material.dart';

extension ColorExtensions on Color? {
  ColorFilter? get svgColor {
    if (this == null) return null;
    return ColorFilter.mode(this!, BlendMode.srcIn);
  }
}
