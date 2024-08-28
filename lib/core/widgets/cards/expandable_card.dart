import 'package:flutter/material.dart';
import 'package:form_generator/core/widgets/popover.dart';
import '/core/constants/constants.dart';

class ExpandableCard extends StatefulWidget {
  const ExpandableCard({
    super.key,
    this.initialExpanded = false,
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
  final bool initialExpanded;

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
  State<ExpandableCard> createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard> {
  /// Expantion controller
  late ExpansionTileController controller;
  bool isExpanded = false;

  /// Actions displaying veriable
  /// default [false]
  bool actions = false;

  @override
  void initState() {
    isExpanded = widget.initialExpanded;
    controller = ExpansionTileController();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ExpandableCard oldWidget) {
    if (oldWidget.initialExpanded != widget.initialExpanded) {
      isExpanded = widget.initialExpanded;
    }
    super.didUpdateWidget(oldWidget);
  }

  /// Bor side
  BorderSide get _side => BorderSide(color: ColorConstants.gray400);

  /// Close button border
  Border get _borderCloseButton => Border(top: _side, left: _side, right: _side);

  /// Toggle expanded
  void toogle() {
    bool isExpanded = controller.isExpanded;
    if (isExpanded) controller.collapse();
    if (!isExpanded) controller.expand();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) => setState(() => actions = true),
      onExit: (event) => setState(() => actions = false),
      child: Card(
        child: ExpansionTile(
          enabled: false,
          controller: controller,
          initiallyExpanded: widget.initialExpanded,
          onExpansionChanged: (value) {
            setState(() => isExpanded = value);
            widget.onChangeStatus?.call(value);
          },
          title: Row(
            children: [
              Expanded(child: _buildTitle),
              _buildTrailing,
            ],
          ),
          tilePadding: const EdgeInsets.only(left: 10),
          subtitle: isExpanded || widget.titleOnly ? null : Padding(padding: const EdgeInsets.only(top: 10.0, right: 0.0), child: widget.collapsed),
          trailing: const SizedBox.shrink(),
          visualDensity: VisualDensity.compact,
          childrenPadding: const EdgeInsets.all(4.0),
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
                  _closeButton,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _buildTitle {
    final textTheme = Theme.of(context).textTheme;
    return Text(
      widget.title,
      style: widget.titleOnly ? textTheme.headlineMedium : textTheme.labelLarge,
    );
  }

  Widget get _buildTrailing {
    List<Widget> children = [
      Popover.confirm(
        title: "Warning!",
        description: "Are you sure want to remove this field?",
        onChanged: (result) {
          if (!result) return;
          widget.onDelete?.call();
        },
        builder: (open) => IconButton(
          hoverColor: const Color.fromARGB(88, 244, 54, 54),
          onPressed: open,
          icon: const Icon(Icons.close),
        ),
      ),
      IconButton(
        hoverColor: const Color.fromARGB(124, 244, 244, 54),
        onPressed: () {
          toogle();
          widget.onEdit?.call();
        },
        icon: const Icon(Icons.edit),
      ),
      IconButton(
        hoverColor: const Color.fromARGB(114, 111, 244, 54),
        onPressed: () {
          widget.onCopy?.call();
        },
        icon: const Icon(Icons.copy),
      ),
      _buildIconButton(
        const Icon(Icons.arrow_upward_rounded),
        () => widget.onChangeOrder?.call(0),
      ),
      _buildIconButton(
        const Icon(Icons.arrow_downward_rounded),
        () => widget.onChangeOrder?.call(1),
      ),
    ];

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 100),
      opacity: actions ? 1.0 : 0.0,
      alwaysIncludeSemantics: true,
      child: IgnorePointer(
        ignoring: !actions,
        child: IconButtonTheme(
          data: IconButtonThemeData(
            style: Theme.of(context).iconButtonTheme.style?.copyWith(iconColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.hovered)) return Colors.white;
              return Colors.grey;
            })),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: children,
          ),
        ),
      ),
    );
  }

  Widget get _closeButton {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(3.0)),
        border: _borderCloseButton,
      ),
      child: TextButton(
        onPressed: toogle,
        child: const Text("Close"),
      ),
    );
  }

  Widget _buildIconButton(Widget icon, void Function() onTap) {
    return IconButtonTheme(
      data: IconButtonThemeData(
        style: Theme.of(context).iconButtonTheme.style?.copyWith(iconColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.hovered)) return Colors.black;
          return Colors.grey;
        })),
      ),
      child: IconButton(
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onPressed: onTap,
        icon: icon,
      ),
    );
  }
}
