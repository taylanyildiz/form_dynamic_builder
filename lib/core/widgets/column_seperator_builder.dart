import 'package:flutter/material.dart';

class ColumnSeparatorBuilder extends Column {
  ColumnSeparatorBuilder({
    super.key,
    super.crossAxisAlignment,
    super.mainAxisAlignment,
    super.mainAxisSize,
    super.textBaseline,
    super.textDirection,
    super.verticalDirection,
    required this.itemCount,
    required this.itemBuilder,
    Widget Function(int index)? separatorBuilder,
  }) : separatorBuilder = separatorBuilder ?? ((_) => const SizedBox());

  /// Item count
  final int itemCount;

  /// Separator builder
  ///
  /// separator between [children]
  final Widget Function(int index) separatorBuilder;

  /// Item builder
  final Widget Function(int index) itemBuilder;

  int get length => itemCount + (itemCount - 1);

  Widget? seperator(int index) {
    final widget = separatorBuilder.call(index);
    if (widget is Visibility && !widget.visible) return null;
    if (widget is SizedBox && widget.height == 0.0) return null;
    return widget;
  }

  @override
  List<Widget> get children {
    List<Widget> list = List.empty(growable: true);
    for (int index = 0; index < length; index++) {
      if (index % 2 == 1) {
        final widget = seperator(index);
        if (widget != null) list.add(widget);
        continue;
      }
      list.add(itemBuilder.call(index ~/ 2));
    }
    return list;
  }
}
