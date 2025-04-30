import 'package:flutter/material.dart';
import '/core/widgets/widgets.dart';

class FormAppBar extends StatelessWidget {
  const FormAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SliverAppBar(
      toolbarHeight: 240,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        background: BlurCard(
          color: Colors.transparent,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black, Colors.transparent],
              ),
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 150.0) + const EdgeInsets.only(top: 15.0),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Form Builder",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    TextVersion()
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                'Drag and Drop',
                style: textTheme.headlineMedium,
              ),
              const SizedBox(height: 5.0),
              RichText(
                text: TextSpan(
                  style: textTheme.headlineMedium,
                  children: const [
                    TextSpan(
                      text: "Full-featured ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: "Form Editing",
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
