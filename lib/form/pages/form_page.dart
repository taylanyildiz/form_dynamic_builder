import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class FormPage extends StatelessWidget {
  const FormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BackgroundDecoration(),
        child: CustomScrollView(
          slivers: [
            const FormAppBar(),
            SliverFillRemaining(
              fillOverscroll: true,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 150.0),
                child: Row(
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
