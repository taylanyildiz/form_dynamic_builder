import 'package:flutter/material.dart';

class BackgroundDecoration extends BoxDecoration {
  @override
  DecorationImage? get image => const DecorationImage(
        image: AssetImage("assets/images/background.jpg"),
        fit: BoxFit.cover,
      );
}
