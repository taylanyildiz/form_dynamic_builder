import 'package:flutter/material.dart';
import '../models/models.dart';

List<FormDynamicFieldHolder> get formDynamicFieldHolders => [
      FormDynamicFieldHolder(
        icon: const Icon(Icons.title),
        title: "Header",
        type: FormDynamicFieldType.header,
      ),
      FormDynamicFieldHolder(
        icon: const Icon(Icons.article_outlined),
        title: "Text Field",
        type: FormDynamicFieldType.text,
      ),
      FormDynamicFieldHolder(
        icon: const Icon(Icons.check_circle_outline),
        title: "Checkbox",
        type: FormDynamicFieldType.checkbox,
      ),
      FormDynamicFieldHolder(
        icon: const Icon(Icons.date_range),
        title: "DateTime",
        type: FormDynamicFieldType.dateTime,
      ),
      FormDynamicFieldHolder(
        icon: const Icon(Icons.list),
        title: "Select",
        type: FormDynamicFieldType.select,
      ),
      FormDynamicFieldHolder(
        icon: const Icon(Icons.image),
        title: "Image",
        type: FormDynamicFieldType.image,
      ),
    ];
