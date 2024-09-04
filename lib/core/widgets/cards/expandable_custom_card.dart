import 'package:flutter/material.dart';

/// Expantion tile controller extension
///
extension ExpantionTileControllerExtension on ExpansionTileController {
  /// Toggle status
  ///
  void toggle() {
    if (!isExpanded) return expand();
    collapse();
  }
}

class ExpandableCustomCard extends StatefulWidget {
  const ExpandableCustomCard({
    super.key,
    required this.title,
    this.subtitle,
    required this.children,
  });

  /// Expansion tile title
  final Widget Function(ExpansionTileController controller) title;

  /// Expansion sub title
  final Widget? subtitle;

  /// Expansion expanded children
  final List<Widget> children;

  @override
  State<ExpandableCustomCard> createState() => _ExpandableCustomCardState();
}

class _ExpandableCustomCardState extends State<ExpandableCustomCard> {
  // tile controller
  final ExpansionTileController controller = ExpansionTileController();

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      controller: controller,
      enabled: false,
      tilePadding: EdgeInsets.zero,
      trailing: const SizedBox.shrink(),
      subtitle: widget.subtitle,
      title: widget.title.call(controller),
      children: [
        Card(
          margin: const EdgeInsets.only(left: 130.0, top: 5.0),
          color: Colors.white,
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.children,
            ),
          ),
        )
      ],
    );
  }
}
