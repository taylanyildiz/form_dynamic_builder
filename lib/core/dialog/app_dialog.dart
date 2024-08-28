import 'dart:async';
import 'package:flutter/material.dart';
import '/core/utils/functions.dart';
import '/core/constants/constants.dart';
import 'widgets/widgets.dart';

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
      builder: (context) => Transform.translate(offset: anchor!, child: dialog),
      anchorPoint: anchor,
    );
  }

  /// Confirmation dialog
  /// returns boolean value
  ///
  /// - if confirm action click [true] otherwise [false]
  static Future<bool> confirm({Key? key, required String titleText, String? contentText}) async {
    final result = await openDialog(
        key: key,
        ConfirmDialog(
          titleText: titleText,
          contentText: contentText,
        ));
    return result ?? false;
  }
}
