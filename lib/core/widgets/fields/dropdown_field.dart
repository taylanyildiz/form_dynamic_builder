import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../utils/functions.dart';

/// Dropdown field builder
///
/// to display item
typedef DropDownFieldBuilder<T> = Widget Function(BuildContext context, T item, bool selected);

/// Dropdown field selected builder
///
typedef DropDownFieldSelectedBuilder<T> = Widget Function(BuildContext context, T selected);

/// Dropdown field compare
///
///
typedef DropDownCompareBuilder<T> = dynamic Function(T item);

/// Dropdown field is there to help select item or items
///
/// if you want to select multi item, make true  [multiSelectable]
///
/// ```dart
///   DropdownField<T>(
///     multiSelectable: true,
///     ...
///   )
/// ```
class DropdownField<T> extends StatefulWidget {
  /// Constructor of [DropdownField]
  ///
  const DropdownField({
    super.key,
    this.labelText,
    this.hintText,
    this.mandantory = false,
    this.multiSelectable = false,
    BoxConstraints? constraints,
    Decoration? decoration,
    Decoration? dropdownDecoration,
    EdgeInsetsGeometry? insetPadding,
    this.selectedBuilder,
    required this.items,
    required this.value,
    required this.itemBuilder,
    this.compareBy,
    this.onChanged,
  })  : decoration = decoration ??
            const BoxDecoration(
              color: Color.fromARGB(255, 225, 223, 223),
              borderRadius: BorderRadius.all(Radius.circular(6.0)),
            ),
        dropdownDecoration = dropdownDecoration ??
            const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(3.0)),
            ),
        insetPadding = insetPadding ?? const EdgeInsets.all(6.0),
        constraints = constraints ?? const BoxConstraints(maxHeight: 400.0);

  /// Label text
  ///
  final String? labelText;

  /// Hint text
  ///
  final String? hintText;

  /// Is required
  ///
  final bool mandantory;

  /// Multi selectable
  ///
  /// default [ƒalse]
  final bool multiSelectable;

  /// Dropdown list constraints
  ///
  final BoxConstraints constraints;

  /// Dropdown field decoration
  ///
  ///
  final Decoration decoration;

  /// Dropdown list decoration
  ///
  final Decoration dropdownDecoration;

  /// Inset padding
  ///
  final EdgeInsetsGeometry? insetPadding;

  /// Selected item builder
  ///
  /// gives selected items
  ///
  /// if [multiSelectable] false gives empty or just have one item list
  ///
  final DropDownFieldSelectedBuilder<T>? selectedBuilder;

  /// List items
  final List<T> items;

  /// Selected value or values
  ///
  /// if [multiSelectable] true [value] must be [List] type of [T]
  ///
  /// otherwise only [T]
  final dynamic value;

  /// Item builder
  final DropDownFieldBuilder<T> itemBuilder;

  /// Compare each item in dropdown fields
  ///
  /// to display item in text-field
  final DropDownCompareBuilder<T>? compareBy;

  /// When Changed selected[s]
  ///
  /// if [multiSelectable] is true [item] is list
  ///
  /// otherwise only [item]
  final void Function(List<T> items)? onChanged;

  @override
  State<DropdownField<T>> createState() => _DropdownFieldState<T>();
}

class _DropdownFieldState<T> extends State<DropdownField<T>> {
  /// Dropdown list controller
  late final ScrollController scrollController;

  /// Overlay to display dropdown
  OverlayEntry? overlayEntry;
  bool open = false;

  /// Key of field
  final GlobalKey fieldKey = GlobalKey();
  (Offset, Size)? get fieldOffSiz => finderOffSiz(fieldKey);

  // Layer link
  final LayerLink link = LayerLink();

  /// Is multi selectable
  bool multiSelectable = false;

  /// Items notifier
  final ValueNotifier<List<T>> itemsNotifier = ValueNotifier<List<T>>(List.empty(growable: true));

  /// Selected items notifier
  final ValueNotifier<List<T>> selectedItemsNotifier = ValueNotifier<List<T>>(List.empty(growable: true));

  /// Text field controller
  final TextEditingController fieldController = TextEditingController();

  @override
  void initState() {
    scrollController = ScrollController();
    multiSelectable = widget.multiSelectable;
    itemsNotifier.value = widget.items;
    _setSelecteds();

    super.initState();
  }

  @override
  void didUpdateWidget(covariant DropdownField<T> oldWidget) {
    if (widget.multiSelectable != oldWidget.multiSelectable) {
      multiSelectable = widget.multiSelectable;
    }
    if (!listEquals(widget.items, oldWidget.items)) {
      itemsNotifier.value = widget.items;
    }

    if ((multiSelectable && listEquals(widget.value, oldWidget.value)) || (!multiSelectable && oldWidget.value != widget.value)) {
      _setSelecteds();
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    open = false;
    overlayEntry?.remove();
    overlayEntry = null;
    scrollController.dispose();
    super.dispose();
  }

  void _setSelecteds() {
    WidgetsBinding.instance.scheduleFrameCallback((_) {
      if (widget.value == null) {
        selectedItemsNotifier.value = [];
        return;
      }

      if (multiSelectable) {
        selectedItemsNotifier.value = widget.value;
      } else {
        if (widget.value != null) {
          List<T> selecteds = [widget.value];
          selectedItemsNotifier.value = selecteds;
        }
      }
    });
  }

  /// Tap field
  ///
  /// to open dropdown
  void onTapField() {
    //
    onOpenDropwdown();
  }

  /// Open dropdown
  ///
  void onOpenDropwdown() {
    if (open) return; // Already dropdown is opened
    overlayEntry = OverlayEntry(builder: (context) {
      return Stack(
        children: [
          GestureDetector(
            onTap: onCloseDropwdown,
            child: Container(color: Colors.transparent),
          ),
          CompositedTransformFollower(
            link: link,
            showWhenUnlinked: false,
            followerAnchor: Alignment.topLeft,
            targetAnchor: Alignment.bottomLeft,
            child: _buildDropdown(context),
          ),
        ],
      );
    });
    final overlay = Overlay.of(context);
    overlay.insert(overlayEntry!);
    open = true;
  }

  void onCloseDropwdown() {
    if (!open) return; // Already dropdown is closed
    overlayEntry?.remove();
    overlayEntry = null;
    open = false;
  }

  void onTapItem(T item) {
    if (!multiSelectable) {
      _onSingleSelect(item);
      onCloseDropwdown();
    } else {
      _onMultiSelect(item);
    }
    scrollController.jumpTo(scrollController.position.maxScrollExtent / (itemsNotifier.value.length - 1) * itemsNotifier.value.indexOf(item) + 1);
    widget.onChanged?.call(selectedItemsNotifier.value);
  }

  void _onSingleSelect(T item) {
    selectedItemsNotifier.value = [item];
    fieldController.text = widget.compareBy?.call(item) ?? item.toString();
  }

  void _onMultiSelect(T item) {
    final List<T> selecteds = [...selectedItemsNotifier.value];
    if (selecteds.contains(item)) {
      selecteds.remove(item);
    } else {
      selecteds.add(item);
    }
    selectedItemsNotifier.value = selecteds;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final inputTheme = theme.inputDecorationTheme;
    return CompositedTransformTarget(
      link: link,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.labelText != null) ...[
            Text(
              widget.labelText ?? "",
              style: inputTheme.labelStyle,
            ),
            const SizedBox(height: 3.0),
          ],
          GestureDetector(
            onTap: onTapField,
            key: fieldKey,
            child: Container(
              alignment: Alignment.center,
              constraints: const BoxConstraints(maxHeight: 30.0),
              padding: widget.insetPadding,
              decoration: (widget.decoration as BoxDecoration?)?.copyWith(
                color: inputTheme.fillColor,
                border: Border.all(
                  width: inputTheme.border?.borderSide.width ?? 1,
                  color: inputTheme.border?.borderSide.color ?? Colors.white,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildPrefix),
                  const Icon(Icons.keyboard_arrow_down),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget get _buildPrefix {
    final theme = Theme.of(context);
    return ValueListenableBuilder(
      valueListenable: selectedItemsNotifier,
      builder: (context, value, _) {
        return Theme(
          data: theme.copyWith(
            textTheme: theme.textTheme.copyWith(
              bodyMedium: theme.textTheme.labelMedium,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            elevation: 0.0,
            child: Wrap(
              runSpacing: 5,
              spacing: 5.0,
              children: List.generate(value.length, (index) {
                final item = value[index];
                return widget.selectedBuilder?.call(context, item) ??
                    Text(
                      widget.compareBy?.call(item) ?? item.toString(),
                    );
              }),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDropdown(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final maxHeight = (size.height - fieldOffSiz!.$1.dy).abs() - fieldOffSiz!.$2.height;
    BoxConstraints constraints = widget.constraints;
    if (maxHeight < constraints.maxHeight || maxHeight < constraints.minHeight) constraints = const BoxConstraints(maxHeight: 400);
    Widget dropdownField(List<T> items) => Material(
          color: Colors.transparent,
          elevation: 0.0,
          child: Container(
            constraints: widget.constraints,
            width: fieldOffSiz?.$2.width,
            decoration: widget.dropdownDecoration,
            child: ListView.separated(
              controller: scrollController,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: items.length,
              separatorBuilder: (context, index) => const SizedBox.shrink(),
              itemBuilder: (context, index) {
                return ValueListenableBuilder(
                  valueListenable: selectedItemsNotifier,
                  builder: (context, selectedItems, child) {
                    return GestureDetector(
                      onTap: () => onTapItem(items[index]),
                      child: widget.itemBuilder.call(
                        context,
                        items[index],
                        selectedItems.contains(items[index]),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        );

    return ValueListenableBuilder(
      valueListenable: itemsNotifier,
      builder: (context, value, child) {
        return dropdownField(value);
      },
    );
  }
}
