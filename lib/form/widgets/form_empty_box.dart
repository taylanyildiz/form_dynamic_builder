import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import '/core/widgets/widgets.dart';

class FormEmptyBox extends StatelessWidget {
  const FormEmptyBox({
    super.key,
    required this.hasPreview,
  });

  /// Has preivew
  final bool hasPreview;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderPadding: EdgeInsets.zero,
      color: Colors.white,
      strokeWidth: 5.0,
      borderType: BorderType.RRect,
      dashPattern: const [5, 5],
      radius: const Radius.circular(8.0),
      padding: const EdgeInsets.all(3.0),
      child: BlurCard(
        child: Card(
          margin: EdgeInsets.zero,
          elevation: 0.0,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero, side: BorderSide.none),
          color: hasPreview ? Colors.blue.withValues(alpha: .3) : Colors.white.withValues(alpha: .1),
          child: const Center(
            child: Text(
              "Drag a field from the right to this area",
            ),
          ),
        ),
      ),
    );
  }
}
