import 'package:flutter/material.dart';
import '/core/extensions/extensions.dart';
import '/core/constants/constants.dart';
import '/core/models/models.dart';
import '/core/widgets/widgets.dart';

class TextDateTimeField extends StatefulWidget {
  const TextDateTimeField({
    super.key,
    this.labelText,
    this.hintText,
    this.initialDate,
    this.maxDate,
    this.minDate,
    this.onChanged,
    DateTimePickerMode? mode,
    FloatingLabelBehavior? floatingLabelBehavior,
  })  : mode = mode ?? DateTimePickerMode.dateAndTime,
        floatingLabelBehavior = floatingLabelBehavior ?? FloatingLabelBehavior.always;

  /// Label text
  final String? labelText;

  /// Hint text
  final String? hintText;

  /// Floatin label behavior
  /// defualt [FloatingLabelBehavior.always]
  final FloatingLabelBehavior floatingLabelBehavior;

  /// Initial date value
  final String? initialDate;

  /// Maximum date
  final DateTime? maxDate;

  /// Minumum date
  final DateTime? minDate;

  /// When changed [dateTime]
  final void Function(String? dateTime)? onChanged;

  /// Picker mode
  /// default [DateTimePickerMode.dateAndTime]
  final DateTimePickerMode mode;

  @override
  State<TextDateTimeField> createState() => _TextDateTimeFieldState();
}

class _TextDateTimeFieldState extends State<TextDateTimeField> {
  /// Field key
  final GlobalKey fieldKey = GlobalKey();

  ///
  final LayerLink _layerLink = LayerLink();

  //
  OverlayEntry? overlayEntry;
  bool overlayDisplaying = false;

  /// Field controller
  late final TextEditingController controller;
  String get text => controller.text;

  /// Initial date
  DateTime? initialDate;

  bool get _onlyDate => widget.mode == DateTimePickerMode.date;
  bool get _onlyTime => widget.mode == DateTimePickerMode.time;

  @override
  void initState() {
    initialDate = widget.initialDate?.toModeDate(widget.mode);
    controller = TextEditingController(text: _dateToText());
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TextDateTimeField oldWidget) {
    if (widget.initialDate != oldWidget.initialDate || widget.mode != oldWidget.mode) {
      initialDate = widget.initialDate?.toModeDate(widget.mode);
      controller.text = _dateToText();
    }
    super.didUpdateWidget(oldWidget);
  }

  /// Convert date to text
  /// display on field
  String _dateToText() => initialDate.locale(onlyDate: _onlyDate, onlyTime: _onlyTime) ?? "";

  /// Tap field
  /// to display picker
  void _onTapField() async {
    showOverlay();
  }

  /// Show picker overlay
  void showOverlay() {
    if (overlayDisplaying) return;
    overlayDisplaying = true;
    final overlay = Overlay.of(context);
    overlayEntry = OverlayEntry(builder: (context) {
      return LayoutBuilder(builder: (__, _) {
        return Stack(
          children: [
            GestureDetector(
              onTap: closeOverlay,
              behavior: HitTestBehavior.translucent,
              child: Container(color: Colors.transparent),
            ),
            CompositedTransformFollower(
              link: _layerLink,
              targetAnchor: Alignment.bottomLeft,
              showWhenUnlinked: false,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 200, minWidth: 200, maxWidth: 250),
                child: _buildPicker,
              ),
            ),
          ],
        );
      });
    });
    overlay.insert(overlayEntry!);
  }

  /// Close overlay
  void closeOverlay() {
    if (!overlayDisplaying) return;
    overlayDisplaying = false;
    overlayEntry?.remove();
    overlayEntry = null;
  }

  /// Clear field
  void _onClear() {
    controller.clear();
    widget.onChanged?.call(null);
  }

  void _onChanged(DateTime? dateTime) {
    final date = dateTime.toModeString(widget.mode);
    controller.text = date ?? "";
    widget.onChanged?.call(date);
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      key: fieldKey,
      child: TextCustomField(
        readOnly: true,
        onTap: _onTapField,
        controller: controller,
        labelText: widget.labelText,
        hintText: widget.hintText,
        suffixBuilder: _suffixIconBuilder,
      ),
    );
  }

  Widget? _suffixIconBuilder(String? input) {
    if (input?.isEmpty ?? true) return _buidSuffixIcon;
    return IconButton(
      iconSize: 18.0,
      visualDensity: VisualDensity.compact,
      onPressed: _onClear,
      icon: const Icon(Icons.clear),
    );
  }

  Widget get _buidSuffixIcon {
    return switch (widget.mode) {
      DateTimePickerMode.time => const Icon(Icons.access_time_outlined),
      _ => const Icon(Icons.insert_invitation_outlined),
    };
  }

  Widget get _buildPicker {
    Widget picker = switch (widget.mode) {
      DateTimePickerMode.date => DatePicker(
          maxDate: widget.maxDate,
          minDate: widget.minDate,
          initialDate: initialDate,
          onChanged: _onChanged,
        ),
      DateTimePickerMode.time => TimePicker(
          maxDate: widget.maxDate,
          minDate: widget.minDate,
          initialDate: initialDate,
          onChanged: _onChanged,
        ),
      DateTimePickerMode.dateAndTime => DateTimePicker(
          maxDate: widget.maxDate,
          minDate: widget.minDate,
          initialDate: initialDate,
          onChanged: _onChanged,
        ),
    };
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: ColorConstants.gray400),
      ),
      child: picker,
    );
  }
}
