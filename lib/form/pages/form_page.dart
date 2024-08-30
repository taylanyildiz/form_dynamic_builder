import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers.dart';
import '/form/pages/pages.dart';
import '../widgets/widgets.dart';

class FormPage extends ConsumerWidget {
  const FormPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(3.0),
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: ref.read(formPageProvider),
                    children: const [
                      FormEditPage(),
                      FormSavedPage(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
