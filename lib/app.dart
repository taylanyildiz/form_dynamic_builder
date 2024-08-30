import 'package:flutter/material.dart';
import '/core/constants/constants.dart';
import '/core/themes/themes.dart';
import 'form/pages/form_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('en'),
      navigatorKey: NavigatorConstants.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Form Generator App',
      theme: LightTheme.theme,
      darkTheme: DarkTheme.theme,
      themeMode: ThemeMode.light,
      home: const FormPage(),
    );
  }
}
