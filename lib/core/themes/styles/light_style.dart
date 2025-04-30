import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/constants.dart';

class LightStyle extends TextTheme {
  /// Elevated button style
  static TextStyle get elevatedButton => GoogleFonts.inter(
        color: Colors.white,
        fontSize: 12.0,
        fontWeight: FontWeight.w400,
      );

  /// Text button style
  static TextStyle get textButtonStyle => GoogleFonts.inter(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        letterSpacing: .25,
        fontSize: 12.0,
      );

  /// Input field hint style
  static TextStyle get hintStyle => GoogleFonts.inter(
        fontSize: 12.0,
        color: ColorConstants.gray700.withValues(alpha: .7),
      );

  /// Input field error style
  static TextStyle get errorStyle => GoogleFonts.inter(
        color: ColorConstants.r500,
        fontWeight: FontWeight.w400,
        height: .4,
      );

  /// List tile title style
  static TextStyle get titleTextStyle => GoogleFonts.inter(
        color: ColorConstants.gray800,
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        letterSpacing: .25,
      );

  /// List sub-tile title style
  static TextStyle get subtitleTextStyle => GoogleFonts.inter(
        color: ColorConstants.gray600,
        fontSize: 13.0,
        fontWeight: FontWeight.w400,
      );

  @override
  TextStyle? get displayLarge => GoogleFonts.inter(
        fontSize: 57.0,
        letterSpacing: -.25,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      );

  @override
  TextStyle? get displayMedium => GoogleFonts.inter(
        fontSize: 45.0,
        letterSpacing: 0.0,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      );

  @override
  TextStyle? get displaySmall => GoogleFonts.inter(
        fontSize: 36.0,
        letterSpacing: 0.0,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      );

  @override
  TextStyle? get headlineLarge => GoogleFonts.inter(
        fontSize: 30.0,
        letterSpacing: -.25,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      );

  @override
  TextStyle? get headlineMedium => GoogleFonts.inter(
        fontSize: 30.0,
        letterSpacing: -.25,
        color: Colors.white,
        fontWeight: FontWeight.w100,
      );

  @override
  TextStyle? get headlineSmall => GoogleFonts.inter(
        fontSize: 20.0,
        letterSpacing: .1,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      );

  @override
  TextStyle? get labelLarge => GoogleFonts.inter(
        fontSize: 13.0,
        letterSpacing: .1,
        color: ColorConstants.gray800,
        fontWeight: FontWeight.w600,
      );

  @override
  TextStyle? get labelMedium => GoogleFonts.inter(
        fontSize: 13.0,
        letterSpacing: .5,
        color: ColorConstants.gray600,
        fontWeight: FontWeight.w500,
      );

  @override
  TextStyle? get labelSmall => GoogleFonts.inter(
        fontSize: 11.0,
        letterSpacing: .5,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      );

  @override
  TextStyle? get bodyLarge => GoogleFonts.inter(
        fontSize: 13.0,
        letterSpacing: .5,
        color: ColorConstants.gray600,
        fontWeight: FontWeight.w400,
      );

  @override
  TextStyle? get bodyMedium => GoogleFonts.inter(
        fontSize: 14.0,
        letterSpacing: .25,
        color: Colors.white,
        fontWeight: FontWeight.w400,
      );

  @override
  TextStyle? get bodySmall => GoogleFonts.inter(
        fontSize: 12.0,
        letterSpacing: .4,
        color: ColorConstants.gray600,
        fontWeight: FontWeight.w400,
      );

  @override
  TextStyle? get titleLarge => GoogleFonts.inter(
        color: Colors.black,
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        letterSpacing: .25,
      );

  @override
  TextStyle? get titleMedium => GoogleFonts.inter(
        color: ColorConstants.gray800,
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        letterSpacing: .25,
      );

  @override
  TextStyle? get titleSmall => GoogleFonts.inter(
        color: ColorConstants.gray400,
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
      );
}
