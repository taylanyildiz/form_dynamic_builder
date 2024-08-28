import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../constants/constants.dart';
import '../styles/light_style.dart';

/// Application Light Theme
///
/// text light theme [LightStyle]
abstract class LightTheme {
  /// Light theme data
  static ThemeData get theme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        textTheme: LightStyle(),
        primaryTextTheme: LightStyle(),
        primaryColor: ColorConstants.tc400,
        dividerColor: ColorConstants.gray100,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.white,
        textSelectionTheme: _textSelectionTheme,
        inputDecorationTheme: _inputDecorationTheme,
        elevatedButtonTheme: _elevatedButtonTheme,
        textButtonTheme: _textButtonTheme,
        listTileTheme: _listTileTheme,
        dividerTheme: _dividerTheme,
        bottomSheetTheme: _bottomSheetTheme,
        iconTheme: _iconTheme,
        appBarTheme: _appBarTheme,
        progressIndicatorTheme: _progressIndicatorTheme,
        cardTheme: _cardTheme,
        drawerTheme: _drawerTheme,
        cupertinoOverrideTheme: _cupertinoOverrideTheme,
        dialogTheme: _dialogTheme,
        checkboxTheme: _checkboxTheme,
        radioTheme: _radioTheme,
        floatingActionButtonTheme: _floatingActionButtonTheme,
        switchTheme: _switchTheme,
        bottomNavigationBarTheme: _bottomNavigationBarTheme,
        iconButtonTheme: _iconButtonTheme,
        indicatorColor: Colors.red,
        scrollbarTheme: _scrollbarTheme,
        dropdownMenuTheme: _dropdownMenuTheme,
      );

  /// Input Field decoration theme
  static InputDecorationTheme get _inputDecorationTheme => InputDecorationTheme(
        filled: true,
        constraints: const BoxConstraints(maxHeight: 30.0),
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: ColorConstants.gray500),
          borderRadius: BorderRadius.circular(4.0),
        ),
        labelStyle: TextStyle(color: ColorConstants.gray600),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorConstants.gray500),
          borderRadius: BorderRadius.circular(4.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorConstants.gray500),
          borderRadius: BorderRadius.circular(4.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorConstants.r400),
          borderRadius: BorderRadius.circular(4.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorConstants.r400),
          borderRadius: BorderRadius.circular(4.0),
        ),
        hintStyle: LightStyle.hintStyle,
        errorStyle: LightStyle.errorStyle,
        iconColor: ColorConstants.gray500,
        suffixIconColor: ColorConstants.gray500,
        prefixIconColor: ColorConstants.gray500,
      );

  /// Elevated primary button theme
  static ElevatedButtonThemeData get _elevatedButtonTheme => ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
              side: BorderSide(color: ColorConstants.gray400),
            ),
          ),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return ColorConstants.gray300;
            }
            return Colors.white;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            return ColorConstants.g400;
          }),
          textStyle: WidgetStatePropertyAll(LightStyle.elevatedButton),
          iconSize: const WidgetStatePropertyAll(20.0),
          minimumSize: const WidgetStatePropertyAll(Size.fromHeight(64.0)),
          elevation: const WidgetStatePropertyAll(0.0),
        ),
      );

  /// Text button theme
  static TextButtonThemeData get _textButtonTheme => TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            return ColorConstants.gray400;
          }),
          visualDensity: VisualDensity.compact,
          overlayColor: const WidgetStatePropertyAll(Colors.transparent),
          textStyle: WidgetStatePropertyAll(LightStyle.textButtonStyle),
        ),
      );

  /// List tile theme
  static ListTileThemeData get _listTileTheme => ListTileThemeData(
        textColor: ColorConstants.gray800,
        selectedColor: ColorConstants.tc700,
        selectedTileColor: ColorConstants.tc25,
        iconColor: ColorConstants.gray600,
        titleTextStyle: LightStyle.titleTextStyle,
        subtitleTextStyle: LightStyle.subtitleTextStyle,
        dense: true,
      );

  /// Divider theme
  static DividerThemeData get _dividerTheme => DividerThemeData(
        color: ColorConstants.gray100,
      );

  /// Bottom sheet theme
  static BottomSheetThemeData get _bottomSheetTheme => const BottomSheetThemeData(
        elevation: 0.0,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        ),
      );

  /// Icon theme
  static IconThemeData get _iconTheme => IconThemeData(
        color: ColorConstants.gray800,
        size: 20.0,
      );

  /// App bar theme
  static AppBarTheme get _appBarTheme => AppBarTheme(
        titleSpacing: 0.0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        scrolledUnderElevation: 0.0,
        elevation: 0.0,
        iconTheme: IconThemeData(
          size: 25.0,
          color: ColorConstants.tc700,
        ),
        actionsIconTheme: const IconThemeData(),
        shape: const UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),
      );

  /// Process indicator theme
  static ProgressIndicatorThemeData get _progressIndicatorTheme => ProgressIndicatorThemeData(
        color: ColorConstants.gray400,
        circularTrackColor: ColorConstants.gray500,
        linearTrackColor: ColorConstants.tc600,
      );

  /// Card theme
  static CardTheme get _cardTheme => const CardTheme(
        elevation: 0.0,
        margin: EdgeInsets.zero,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: BorderSide.none,
        ),
      );

  /// Drawer theme
  static DrawerThemeData get _drawerTheme => DrawerThemeData(
        backgroundColor: Colors.white,
        elevation: 0.0,
        scrimColor: Colors.black.withOpacity(.5),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(left: Radius.circular(4.0)),
        ),
        endShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(left: Radius.circular(4.0)),
        ),
      );

  /// Text form field selection theme
  static TextSelectionThemeData get _textSelectionTheme => TextSelectionThemeData(
        cursorColor: ColorConstants.gray600,
        selectionColor: ColorConstants.tc50,
        selectionHandleColor: ColorConstants.tc400,
      );

  /// Cupertino theme
  static CupertinoThemeData get _cupertinoOverrideTheme => CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: ColorConstants.tc400,
        textTheme: const CupertinoTextThemeData(
          dateTimePickerTextStyle: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      );

  /// Dialog theme
  static DialogTheme get _dialogTheme => DialogTheme(
        backgroundColor: Colors.white,
        elevation: 0.0,
        titleTextStyle: TextStyle(
          color: ColorConstants.gray800,
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
        ),
        contentTextStyle: TextStyle(
          color: ColorConstants.gray500,
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
        ),
      );

  /// Check box theme
  static CheckboxThemeData get _checkboxTheme => CheckboxThemeData(
        checkColor: const WidgetStatePropertyAll(Colors.white),
        visualDensity: VisualDensity.compact,
        fillColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return ColorConstants.bat400;
          }
          return ColorConstants.gray25;
        }),
        side: BorderSide(color: ColorConstants.gray300),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
      );

  /// Radio theme data
  static RadioThemeData get _radioTheme => RadioThemeData(
        fillColor: WidgetStatePropertyAll(ColorConstants.tc600),
      );

  /// Floating action button
  static FloatingActionButtonThemeData get _floatingActionButtonTheme => FloatingActionButtonThemeData(
        backgroundColor: ColorConstants.tc700,
        foregroundColor: Colors.white,
      );

  /// Switch theme
  static SwitchThemeData get _switchTheme => SwitchThemeData(
        overlayColor: WidgetStatePropertyAll(ColorConstants.tc400),
        thumbColor: const WidgetStatePropertyAll(Colors.white),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return ColorConstants.tc600;
          }
          return const Color(0xff1D1B20).withOpacity(.12);
        }),
        trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
      );

  /// Bottom navigation bar theme
  static BottomNavigationBarThemeData get _bottomNavigationBarTheme => const BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      );

  /// Icon button theme
  static IconButtonThemeData get _iconButtonTheme => IconButtonThemeData(
        style: ButtonStyle(
          visualDensity: VisualDensity.compact,
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.hovered)) {
              return Colors.white;
            }
            if (states.contains(WidgetState.disabled)) {
              return ColorConstants.gray300;
            }
            return ColorConstants.tc700;
          }),
        ),
      );

  /// Scroll bar theme.
  static ScrollbarThemeData get _scrollbarTheme => ScrollbarThemeData(
        thumbColor: WidgetStatePropertyAll(ColorConstants.tc600),
        trackColor: WidgetStatePropertyAll(ColorConstants.gray100),
        // trackVisibility: const WidgetStatePropertyAll(true),
        // thumbVisibility: const WidgetStatePropertyAll(true),
        radius: const Radius.circular(10.0),
        minThumbLength: 10.0,
        mainAxisMargin: 10.0,
        thickness: const WidgetStatePropertyAll(8.0),
        trackBorderColor: const WidgetStatePropertyAll(Colors.transparent),
      );

  /// Dropdown theme
  static DropdownMenuThemeData get _dropdownMenuTheme => DropdownMenuThemeData(
        inputDecorationTheme: _inputDecorationTheme,
      );
}
