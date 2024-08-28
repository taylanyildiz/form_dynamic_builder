import 'package:flutter/material.dart';
import '../styles/dark_style.dart';

abstract class DarkTheme {
  /// Dark theme data
  static ThemeData get theme => ThemeData(
        textTheme: DarkStyle(),
      );
}
