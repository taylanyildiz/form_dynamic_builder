import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

/// Generator uuid [v7]
///
String get uuid => const Uuid().v7();

/// Find offet and size by [key]
///
/// __attention__
/// * key must be [GlobalKey]
(Offset, Size)? finderOffSiz(Key? key) {
  if (key == null || key is! GlobalKey) return null;
  final RenderBox? renderBox = key.currentContext?.findRenderObject() as RenderBox?;
  if (renderBox == null) return null;
  final offset = renderBox.globalToLocal(renderBox.size.center(Offset.zero));
  return (offset, renderBox.size);
}
