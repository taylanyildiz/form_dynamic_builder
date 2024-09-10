import 'package:flutter/material.dart';
import '/core/constants/constants.dart';
import 'package:toastification/toastification.dart';

abstract final class AppSnackbar {
  /// Show snackbar
  ///
  static void show({
    Widget? icon,
    Widget? title,
    Widget? description,
  }) {
    toastification.show(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
      context: NavigatorConstants.context,
      type: ToastificationType.warning,
      style: ToastificationStyle.minimal,
      title: title,
      description: (() {
        if (description == null) return null;
        return Theme(
          data: ThemeData(
            textTheme: const TextTheme(
              bodyMedium: TextStyle(fontSize: 11),
            ),
          ),
          child: Material(
            color: Colors.transparent,
            elevation: 0.0,
            child: description,
          ),
        );
      }()),
      alignment: Alignment.topRight,
      autoCloseDuration: const Duration(seconds: 4),
      icon: const Icon(Icons.warning),
      boxShadow: highModeShadow,
      showProgressBar: true,
      closeButtonShowType: CloseButtonShowType.onHover,
      dragToClose: true,
    );
  }

  /// Warning snackbar
  ///
  static void warning(String title, String subtitle) {
    show(
      title: Text(title),
      description: Text(subtitle),
      icon: const Icon(Icons.warning),
    );
  }
}
