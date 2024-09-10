import 'package:flutter/material.dart';
import '../../../core/widgets/widgets.dart';
import '/core/constants/constants.dart';

class FormDynamicExpandableCard extends StatefulWidget {
  const FormDynamicExpandableCard({
    super.key,
    this.initialExpanded = false,
    this.backgroundColor,
    required this.title,
    this.titleOnly = false,
    required this.collapsed,
    required this.expanded,
    this.onDelete,
    this.onEdit,
    this.onCopy,
    this.onChangeStatus,
    this.onChangeOrder,
  });

  /// Initial expanded
  ///
  /// default [false]
  final bool initialExpanded;

  /// Item background color
  ///
  final Color? backgroundColor;

  /// Header of panel
  final String title;

  /// Title only
  /// changed [title] style
  final bool titleOnly;

  /// Collapsed widget
  final Widget? collapsed;

  /// Expanded widget
  final Widget expanded;

  /// Delete button action
  final void Function()? onDelete;

  /// Edit button action
  final void Function()? onEdit;

  /// Copy button action
  final void Function()? onCopy;

  /// Change order
  /// 0 -> up
  /// 1 -> down
  final void Function(int order)? onChangeOrder;

  /// Expanded action
  final void Function(bool value)? onChangeStatus;

  @override
  State<FormDynamicExpandableCard> createState() => _FormDynamicExpandableCardState();
}

class _FormDynamicExpandableCardState extends State<FormDynamicExpandableCard> {
  /// Actions displaying veriable
  /// default [false]
  bool actions = false;

  /// Bor side
  BorderSide get _side => BorderSide(color: ColorConstants.gray400);

  /// Close button border
  Border get _borderCloseButton => Border(top: _side, left: _side, right: _side);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) => setState(() => actions = true),
      onExit: (event) => setState(() => actions = false),
      child: Card(
        color: widget.backgroundColor,
        child: ExpandableCard.builder(
          initiallyExpanded: widget.initialExpanded,
          onExpansionChanged: (value) {
            widget.onChangeStatus?.call(value);
          },
          tilePadding: const EdgeInsets.only(left: 10),
          childrenPadding: const EdgeInsets.all(4.0),
          builder: (controller) {
            final bool isExpanded = controller.expanded;
            return ExpandableCustomCardDelegate(
              title: Row(
                children: [
                  Expanded(child: _buildTitle),
                  _buildTrailing(controller),
                ],
              ),
              subTitle: isExpanded || widget.titleOnly ? null : Padding(padding: const EdgeInsets.only(top: 10.0, right: 0.0), child: widget.collapsed),
              children: [
                Card(
                  color: ColorConstants.gray100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.0),
                    side: _side,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: widget.expanded,
                      ),
                      _closeButton(controller),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget get _buildTitle {
    final textTheme = Theme.of(context).textTheme;
    return Text(
      widget.title,
      style: widget.titleOnly ? textTheme.titleLarge : textTheme.labelLarge,
    );
  }

  Widget _buildTrailing(ExpansionTileController controller) {
    List<Widget> children = [
      Popover.confirm(
        title: "Warning!",
        description: "Are you sure want to remove this field?",
        onTap: (result) {
          if (!result) return;
          widget.onDelete?.call();
        },
        builder: (open) => IconCustomButton(
          color: Colors.grey,
          hoveredColor: const Color.fromARGB(88, 244, 54, 54),
          hoveredForegroundColor: Colors.white,
          onPressed: open,
          icon: const Icon(Icons.close),
        ),
      ),
      IconCustomButton(
        hoveredColor: const Color.fromARGB(124, 244, 244, 54),
        hoveredForegroundColor: Colors.white,
        color: Colors.grey,
        onPressed: () {
          controller.toggle();
          widget.onEdit?.call();
        },
        icon: const Icon(Icons.edit),
      ),
      IconCustomButton(
        hoveredColor: const Color.fromARGB(114, 111, 244, 54),
        hoveredForegroundColor: Colors.white,
        color: Colors.grey,
        onPressed: () {
          widget.onCopy?.call();
        },
        icon: const Icon(Icons.copy),
      ),
      IconCustomButton(
        color: Colors.grey,
        hoveredForegroundColor: Colors.black,
        icon: const Icon(Icons.arrow_upward_rounded),
        onPressed: () {
          widget.onChangeOrder?.call(0);
        },
      ),
      IconCustomButton(
        color: Colors.grey,
        hoveredForegroundColor: Colors.black,
        icon: const Icon(Icons.arrow_downward_rounded),
        onPressed: () {
          widget.onChangeOrder?.call(1);
        },
      ),
    ];

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 100),
      opacity: actions ? 1.0 : 0.0,
      alwaysIncludeSemantics: true,
      child: IgnorePointer(
        ignoring: !actions,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
    );
  }

  Widget _closeButton(ExpansionTileController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(3.0)),
        border: _borderCloseButton,
      ),
      child: TextButton(
        onPressed: () => controller.toggle(),
        child: const Text("Close"),
      ),
    );
  }
}
