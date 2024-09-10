import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '/core/widgets/widgets.dart';
import '/core/models/models.dart';

class FormDynamicFieldWrapImages extends StatefulWidget {
  const FormDynamicFieldWrapImages({
    super.key,
    required this.options,
    required this.onChanged,
  });

  /// Options
  final List<FormDynamicFieldOption> options;

  /// Changed options
  final void Function(List<FormDynamicFieldOption> options) onChanged;

  @override
  State<FormDynamicFieldWrapImages> createState() => _FormDynamicFieldWrapImagesState();
}

class _FormDynamicFieldWrapImagesState extends State<FormDynamicFieldWrapImages> {
  /// Option items
  late List<FormDynamicFieldOption> options;

  /// Has cursor image
  final ValueNotifier<List<bool>> cursorsNotifier = ValueNotifier([]);

  @override
  void initState() {
    options = List<FormDynamicFieldOption>.from(widget.options);
    cursorsNotifier.value = List.generate(options.length, (index) => false);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FormDynamicFieldWrapImages oldWidget) {
    if (!listEquals(widget.options, oldWidget.options)) {
      options = List.from(widget.options);
      cursorsNotifier.value = List.generate(options.length, (index) => false);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      spacing: 4.0,
      runSpacing: 4.0,
      children: List.generate(options.length + 1, (index) {
        if (widget.options.length == index) {
          return Center(
            child: PrimaryButton(
              minimumSize: Size.zero,
              padding: const EdgeInsets.all(10.0),
              onPressed: () {
                options.add(FormDynamicFieldOption());
                widget.onChanged.call(options);
              },
              icon: const Icon(Icons.add),
              title: "Add Image",
            ),
          );
        }

        final option = options[index];
        return MouseRegion(
          onHover: (event) {
            final values = List<bool>.from(cursorsNotifier.value);
            values[index] = true;
            cursorsNotifier.value = values;
          },
          onExit: (event) {
            final values = List<bool>.from(cursorsNotifier.value);
            values[index] = false;
            cursorsNotifier.value = values;
          },
          child: IntrinsicWidth(
            child: Column(
              children: [
                ImageCard(
                  image: option.value,
                  onDelete: () {
                    final removed = options.removeAt(index);
                    options.insert(index, FormDynamicFieldOption(id: removed.id));
                    widget.onChanged.call(options);
                  },
                  onChanged: (image) {
                    options[index] = options[index].copyWith(value: image);
                    widget.onChanged.call(options);
                  },
                ),
                ValueListenableBuilder(
                  valueListenable: cursorsNotifier,
                  builder: (context, value, child) {
                    return IgnorePointer(
                      ignoring: !(value[index] && options.length > 1),
                      child: Opacity(
                        opacity: (value[index] && options.length > 1) ? 1.0 : 0.0,
                        child: Popover.confirm(
                          title: "Warning!",
                          description: "Are you sure want to remove this image?",
                          onTap: (result) {
                            if (!result) return;
                            options.removeAt(index);
                            widget.onChanged.call(options);
                          },
                          builder: (open) {
                            return PrimaryButton(
                              foregroundColor: Colors.red,
                              borderSide: BorderSide.none,
                              icon: const Icon(Icons.delete),
                              title: "Delete",
                              minimumSize: const Size.fromHeight(30.0),
                              onPressed: open,
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
