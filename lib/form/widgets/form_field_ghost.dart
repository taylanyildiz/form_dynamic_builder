import 'package:flutter/material.dart';

class FormFieldGhost extends SizedBox {
  const FormFieldGhost({super.key, super.height});

  @override
  double? get width => double.infinity;

  @override
  double? get height => super.height ?? 30.0;

  @override
  Widget? get child => Card(
        margin: EdgeInsets.zero,
        elevation: 0.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0), side: BorderSide.none),
        color: Colors.blue.withOpacity(.5),
      );
}
