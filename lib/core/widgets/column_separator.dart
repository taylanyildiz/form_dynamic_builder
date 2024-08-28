import 'package:flutter/material.dart';

class ColumnSeparator extends Column {
  ColumnSeparator({
    super.key,
    super.children,
    super.crossAxisAlignment,
    super.mainAxisAlignment,
    super.mainAxisSize,
    super.textBaseline,
    super.textDirection,
    super.verticalDirection,
    Widget Function(int index)? separatorBuilder,
  }) : separatorBuilder = separatorBuilder ?? ((_) => const SizedBox());

  /// Separator builder
  ///
  /// separator between [children]
  final Widget Function(int index) separatorBuilder;

  Widget? seperator(int index) {
    final widget = separatorBuilder.call(index);
    if (widget is Visibility && !widget.visible) return null;
    if (widget is SizedBox && widget.height == 0.0) return null;
    return widget;
  }

  List<Widget> get _children => super.children.where((e) {
        if (e is Visibility && !e.visible) return false;
        if (e is SizedBox && e.height == 0.0) return false;
        return true;
      }).toList();

  int get childrenLength => _children.length;
  int get lengthTotal => childrenLength + (childrenLength - 1);

  @override
  List<Widget> get children {
    List<Widget> list = List.empty(growable: true);
    for (int index = 0; index < lengthTotal; index++) {
      if (index % 2 == 1) {
        final widget = seperator(index);
        if (widget != null) list.add(widget);
        continue;
      }
      list.add(_children[index ~/ 2]);
    }
    return list;
  }
}
