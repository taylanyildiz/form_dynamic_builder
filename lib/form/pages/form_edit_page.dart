import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class FormEditPage extends StatelessWidget {
  const FormEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Row(
        textDirection: TextDirection.rtl,
        children: [
          IntrinsicWidth(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3.0),
              child: const Column(
                children: [
                  Expanded(child: FormFieldHolders()),
                  SizedBox(height: 10.0),
                  FormActions(),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          const Expanded(child: FormTarget())
        ],
      ),
    );
  }
}
