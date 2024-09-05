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

  /// Tile expanded condtion
  ///
  static bool _expanded = false;

  /// Get tile controller is expanded value
  ///
  ///
  bool get expanded {
    try {
      return isExpanded;
    } catch (e) {
      return _expanded;
    }
  }

  /// Set [_expanded]
  ///
  set expanded(bool expanded) => _expanded = expanded;
}

/// ExpandableCustomCardDelegate Builder
///
/// gives [ExpansionTileController] to manage expantion-tile status
typedef ExpandableCustomCardDelegateBuilder = ExpandableCustomCardDelegate Function(ExpansionTileController controller);

/// ExpantionTile card delegate
///
///
class ExpandableCustomCardDelegate {
  /// Expansion title title
  ///
  final Widget title;

  /// Expansion tile subtitle
  ///
  final Widget? subTitle;

  /// Expansion title children
  /// when expanded
  final List<Widget> children;

  const ExpandableCustomCardDelegate({
    required this.title,
    this.subTitle,
    List<Widget>? children,
  }) : children = children ?? const <Widget>[];
}

class ExpandableCard extends StatefulWidget {
  /// Expantion Custom Tile Card
  ///
  ExpandableCard({
    super.key,
    this.controller,
    bool? initiallyExpanded,
    EdgeInsetsGeometry? tilePadding,
    this.childrenPadding,
    required Widget title,
    required List<Widget> children,
    this.onExpansionChanged,
  })  : initiallyExpanded = initiallyExpanded ?? false,
        builder = null,
        delegate = ExpandableCustomCardDelegate(title: title, children: children),
        tilePadding = tilePadding ?? EdgeInsets.zero;

  const ExpandableCard.builder({
    super.key,
    required this.builder,
    bool? initiallyExpanded,
    EdgeInsetsGeometry? tilePadding,
    this.childrenPadding,
    this.onExpansionChanged,
  })  : initiallyExpanded = initiallyExpanded ?? false,
        controller = null,
        delegate = null,
        tilePadding = tilePadding ?? EdgeInsets.zero;

  ///
  final ExpansionTileController? controller;

  /// Initial expanded
  ///
  /// default [false]
  final bool initiallyExpanded;

  /// Tile padding
  ///
  final EdgeInsetsGeometry tilePadding;

  /// Tile children padding
  final EdgeInsetsGeometry? childrenPadding;

  /// Expantion tile delegate
  ///
  final ExpandableCustomCardDelegate? delegate;

  /// Expantion tile delegate builder
  ///
  final ExpandableCustomCardDelegateBuilder? builder;

  /// When changed expansion status
  ///
  final void Function(bool status)? onExpansionChanged;

  @override
  State<ExpandableCard> createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard> {
  // tile controller
  late final ExpansionTileController controller;
  bool isExpanded = false;

  @override
  void initState() {
    isExpanded = widget.initiallyExpanded;
    controller = widget.controller ?? ExpansionTileController();
    controller.expanded = isExpanded;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ExpandableCard oldWidget) {
    if (oldWidget.initiallyExpanded != widget.initiallyExpanded) {
      isExpanded = widget.initiallyExpanded;
      controller.expanded = isExpanded;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      enabled: false,
      controller: controller,
      initiallyExpanded: widget.initiallyExpanded,
      onExpansionChanged: widget.onExpansionChanged,
      tilePadding: widget.tilePadding,
      childrenPadding: widget.childrenPadding,
      trailing: const SizedBox.shrink(),
      subtitle: (widget.delegate ?? widget.builder?.call(controller))!.subTitle,
      title: (widget.delegate ?? widget.builder?.call(controller))!.title,
      visualDensity: VisualDensity.compact,
      children: (widget.delegate ?? widget.builder?.call(controller))!.children,
    );
  }
}
