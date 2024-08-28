import 'package:flutter/material.dart';

abstract final class NavigatorConstants {
  /// Navigator key
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// App context
  /// gerated from [navigatorKey]
  static BuildContext get context => navigatorKey.currentContext!;
}
