import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  const Label({
    super.key,
    required this.label,
    required this.child,
    CrossAxisAlignment? crossAxisAlignment,
  }) : crossAxisAlignment = crossAxisAlignment ?? CrossAxisAlignment.center;

  final String label;
  final Widget child;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 120,
          ),
          child: Text(
            label,
            style: textTheme.labelLarge,
            textAlign: TextAlign.end,
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [child],
          ),
        ),
      ],
    );
  }
}
