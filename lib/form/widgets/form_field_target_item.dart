import 'package:flutter/material.dart';
import 'form_field_ghost.dart';

class FormFieldTargetItem extends StatelessWidget {
  const FormFieldTargetItem({
    super.key,
    this.hasPreview = false,
    this.isFirst = false,
    this.isLast = false,
    required this.child,
  });

  /// Has preview
  final bool hasPreview;

  /// Item is first
  /// radius top
  final bool isFirst;

  /// Item is last
  /// radius bottom
  final bool isLast;

  /// Child item
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: hasPreview ? 2 : 1,
      separatorBuilder: (context, _) => const SizedBox(height: 3.0),
      itemBuilder: (context, index) {
        if (hasPreview && index == 0) return const FormFieldGhost();
        return ClipRRect(
          borderRadius: BorderRadius.vertical(
            top: isFirst ? const Radius.circular(3.0) : Radius.zero,
            bottom: isLast ? const Radius.circular(3.0) : Radius.zero,
          ),
          child: child,
        );
      },
    );
  }
}
