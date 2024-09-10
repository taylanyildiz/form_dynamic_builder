import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import '../models/models.dart';

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

/// Generates a 5-digit random number as a unique key.
///
/// This function creates a random integer between 10000 and 99999 (inclusive),
/// ensuring the result is always 5 digits long. The generated number is then
/// converted to a string and returned.
///
/// Returns:
///   A string representing a 5-digit random number.
///
/// Example:
/// ```dart
/// String key = generateRandomKey();
/// print(key); // Example output: 37428
/// ```
String generateRandomKey() {
  final random = Random();
  int randomNumber = random.nextInt(90000) + 10000;
  return randomNumber.toString();
}

/// Generate field unique name
///
/// by [fieldType] with random [5] digit key
String generateFieldName(int? fieldType) {
  final fieldTypeName = FormDynamicFieldType.values.firstWhere((e) => e.index == fieldType, orElse: () => FormDynamicFieldType.text).title;
  // return "$fieldTypeName-$random";
  return "$fieldTypeName-${generateRandomKey()}";
}
