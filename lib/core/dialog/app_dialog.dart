import 'dart:async';
import 'package:flutter/material.dart';
import '/core/utils/functions.dart';
import '/core/constants/constants.dart';

abstract final class AppDialog {
  /// Show adaptive dialog
  ///
  /// returns result as [T] type
  static Future<T?> openDialog<T>(
    Widget dialog, {
    Key? key,
    Color? barrierColor,
    bool barrierDismissible = true,
    bool useRootNavigator = false,
  }) {
    final anchor = finderOffSiz(key)?.$1;
    return showAdaptiveDialog(
      context: NavigatorConstants.context,
      useRootNavigator: useRootNavigator,
      useSafeArea: true,
      barrierColor: barrierColor,
      barrierDismissible: barrierDismissible,
      builder: (context) => dialog,
      anchorPoint: anchor,
    );
  }
}
