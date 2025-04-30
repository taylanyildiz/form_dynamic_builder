import 'dart:io';
import '/core/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum FieldButton {
  next,
  done,
  ;
}

extension FieldButtonExtensions on FieldButton {
  String get name {
    return switch (this) {
      FieldButton.done => "Done",
      FieldButton.next => "Next",
    };
  }
}

/// Form field validator builder
typedef ValidatorBuilder = String? Function(String? input);

class TextCustomField extends StatefulWidget {
  const TextCustomField({
    super.key,
    this.initialValue,
    this.controller,
    this.validator,
    this.onEditingComplete,
    this.onChange,
    this.onTap,
    this.hintText,
    this.labelText,
    this.labelStyle,
    this.suffixIcon,
    this.suffixBuilder,
    this.prefixIcon,
    this.secret = false,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.disabledBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.maxLines = 1,
    this.minLines,
    this.constraints,
    this.enabled = true,
    this.contentPadding,
    this.style,
    this.focusNode,
    this.autoFocus = false,
    this.inputType,
    this.inputAction,
    this.readOnly = false,
    this.mandantory = false,
    this.fillColor,
    this.textAlign = TextAlign.start,
    this.hintStyle,
    FloatingLabelBehavior? floatingLabelBehavior,
    this.canSuccess = false,
    this.validateMode,
    this.closeKeyboard = false,
    this.overlayButton = FieldButton.done,
    this.enabledError = true,
    this.onTapOutside,
  })  : assert(!secret || suffixIcon == null),
        assert(!mandantory || (labelText != null && mandantory)),
        floatingLabelBehavior = floatingLabelBehavior ?? FloatingLabelBehavior.auto;

  /// Initial value
  final String? initialValue;

  /// Text field controller
  final TextEditingController? controller;

  /// Text field validator
  final ValidatorBuilder? validator;

  /// Editing when complate
  final Function()? onEditingComplete;

  /// Input value when change
  final Function(String? input)? onChange;

  /// Tap field
  final void Function()? onTap;

  /// Hint text
  final String? hintText;

  /// Label text
  final String? labelText;

  /// Label style
  final TextStyle? labelStyle;

  /// Field suffix icon
  final Widget? suffixIcon;

  /// Suffix icon builder
  ///
  /// gives input value
  final Widget? Function(String? input)? suffixBuilder;

  /// Field prefix icon
  final Widget? prefixIcon;

  /// Secret field
  /// Don't set true if use the [suffixIcon]
  /// default false
  final bool secret;

  /// Input border
  final InputBorder? border;

  /// Enabled border
  final InputBorder? enabledBorder;

  /// Focused border
  final InputBorder? focusedBorder;

  /// Disabled border
  final InputBorder? disabledBorder;

  /// Error border
  final InputBorder? errorBorder;

  /// Focused error border
  final InputBorder? focusedErrorBorder;

  /// Field max lines
  final int maxLines;

  /// Field min lines
  final int? minLines;

  /// Field decoration constrants
  final BoxConstraints? constraints;

  /// Enabled condition
  final bool enabled;

  /// Padding content
  final EdgeInsetsGeometry? contentPadding;

  /// Input decoration style
  final TextStyle? style;

  /// Focus node
  final FocusNode? focusNode;

  /// Auto focus
  /// default [false]
  final bool autoFocus;

  /// Text input type
  final TextInputType? inputType;

  /// Text Input action
  final TextInputAction? inputAction;

  /// Read only field
  final bool readOnly;

  /// Is field required
  final bool mandantory;

  /// Filled color
  final Color? fillColor;

  /// Text align
  final TextAlign textAlign;

  /// hint text style
  final TextStyle? hintStyle;

  /// Floating field label aligment
  /// default [FloatingLabelBehavior.auto]
  ///
  /// if [FloatingLabelBehavior.never] and labelText not null or empty
  /// label display top of field
  final FloatingLabelBehavior floatingLabelBehavior;

  /// If validator success
  /// display done icon end of field
  ///
  /// default [false]
  final bool canSuccess;

  /// Auto validate mode
  final AutovalidateMode? validateMode;

  /// Close keyboard when editing completed
  /// defaul false
  final bool closeKeyboard;

  /// overlay Button Text
  final FieldButton overlayButton;

  /// Enabled error
  /// default [true]
  final bool enabledError;

  /// Tap outside
  final void Function(PointerDownEvent)? onTapOutside;

  @override
  State<TextCustomField> createState() => _TextCustomFieldState();
}

class _TextCustomFieldState extends State<TextCustomField> {
  /// Field validation mode
  AutovalidateMode? validateMode;

  /// Focus node
  /// to check keyboard is opened
  late FocusNode focusNode;

  /// Enabled error
  bool enabledError = true;

  @override
  void initState() {
    enabledError = widget.enabledError;
    validateMode = widget.validateMode;
    obscureText = widget.secret;
    focusNode = widget.focusNode ?? FocusNode();
    focusNode.addListener(() {
      if (widget.readOnly) return closeOverlay();
      if (focusNode.hasFocus) return showOverlay();
      closeOverlay();
      if (mounted) setState(() {});
    });
    if ((widget.controller?.text.isNotEmpty ?? false)) {
      if (enabledError) {
        validateMode ??= AutovalidateMode.always;
      }
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TextCustomField oldWidget) {
    if (oldWidget.enabledError != widget.enabledError) {
      enabledError = widget.enabledError;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    closeOverlay();
    super.dispose();
  }

  /// Close button on top keybard overlay
  final LayerLink layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  /// Show overlay button
  void showOverlay() {
    if (!mounted) return;
    _overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
        left: 0.0,
        right: 0.0,
        bottom: MediaQuery.of(context).viewInsets.bottom - 35.0,
        child: Card(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          color: ColorConstants.gray25,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  switch (widget.overlayButton) {
                    case FieldButton.next:
                      focusNode.nextFocus();

                    case FieldButton.done:
                      focusNode.unfocus();
                      widget.onEditingComplete?.call();
                  }
                },
                child: Text(widget.overlayButton.name),
              ),
            ],
          ),
        ),
      );
    });
    Overlay.of(context).insert(_overlayEntry!);
  }

  /// Close overlay button
  void closeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry?.dispose();
    _overlayEntry = null;
  }

  bool obscureText = false;
  void onVisibility() => setState(() => obscureText = !obscureText);

  bool? validate;
  void setValidate(bool validate) => WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (!validate) validateMode = AutovalidateMode.onUserInteraction;
        if (mounted) setState(() => this.validate = validate);
      });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final decTheme = theme.inputDecorationTheme;
    final labelSty = widget.labelStyle ?? decTheme.labelStyle ?? theme.textTheme.bodyMedium;
    final floatingStyle = theme.inputDecorationTheme.floatingLabelStyle;

    Widget labelWidget = RichText(
      maxLines: 1,
      text: TextSpan(
        text: widget.labelText,
        style: enabledError
            ? labelSty?.copyWith(
                color: (validate ?? true) ? null : Colors.red,
              )
            : labelSty,
        children: [
          if (widget.mandantory)
            TextSpan(
              text: " *",
              style: labelSty?.copyWith(color: Colors.red),
            ),
        ],
      ),
    );
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null && widget.floatingLabelBehavior == FloatingLabelBehavior.never) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: labelWidget,
          )
        ],
        TextFormField(
          onTapOutside: widget.onTapOutside,
          initialValue: widget.initialValue,
          selectionControls: kIsWeb
              ? null
              : CustomSelectionControls(
                  theme.textSelectionTheme.selectionHandleColor ?? Colors.blue.withValues(alpha: .3),
                ),
          autovalidateMode: validateMode,
          onTap: widget.onTap,
          readOnly: widget.readOnly,
          controller: widget.controller,
          onChanged: widget.onChange,
          onEditingComplete: () {
            if (widget.closeKeyboard) {
              FocusManager.instance.primaryFocus?.unfocus();
            }
            widget.onEditingComplete?.call();
          },
          obscureText: obscureText,
          validator: (value) {
            if (widget.validator == null) return null;
            final validate = widget.validator?.call(value);
            if (mounted) setValidate(validate == null);
            return validate;
          },
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          enabled: widget.enabled,
          style: widget.style,
          autofocus: widget.autoFocus,
          focusNode: focusNode,
          keyboardType: widget.inputType,
          textInputAction: widget.inputAction,
          textAlign: widget.textAlign,
          decoration: InputDecoration(
            filled: true,
            alignLabelWithHint: true,
            label: (widget.labelText != null && widget.floatingLabelBehavior != FloatingLabelBehavior.never) ? labelWidget : null,
            floatingLabelBehavior: widget.floatingLabelBehavior,
            hintStyle: widget.hintStyle,
            fillColor: widget.fillColor,
            hintText: widget.hintText,
            suffixIcon: _suffixIcon,
            prefixIcon: widget.prefixIcon,
            border: widget.border,
            enabledBorder: widget.enabledBorder,
            focusedBorder: widget.focusedBorder,
            errorBorder: !enabledError ? (widget.focusedBorder ?? decTheme.focusedBorder) : widget.errorBorder,
            disabledBorder: widget.disabledBorder,
            focusedErrorBorder: !enabledError ? (widget.focusedBorder ?? decTheme.focusedBorder) : widget.focusedErrorBorder,
            contentPadding: widget.contentPadding ?? (widget.maxLines == 1 ? const EdgeInsets.only(left: 10.0) : null),
            constraints: widget.constraints ?? decTheme.constraints,
            labelStyle: enabledError
                ? labelSty?.copyWith(
                    color: (validate ?? true) ? null : Colors.red,
                  )
                : labelSty,
            floatingLabelStyle: enabledError
                ? floatingStyle?.copyWith(
                    color: (validate ?? true) ? null : Colors.red,
                  )
                : floatingStyle,
            errorStyle: !enabledError ? const TextStyle(fontSize: 0.0) : null,
          ),
        )
      ],
    );
  }

  Widget? get _suffixIcon {
    if (widget.secret) return _visibilityButton;
    if (widget.suffixIcon != null || widget.suffixBuilder != null) {
      if (widget.suffixIcon != null) return widget.suffixIcon;
      if (widget.controller != null) {
        return ValueListenableBuilder(
          valueListenable: widget.controller!,
          builder: (_, value, __) => widget.suffixBuilder!.call(value.text) ?? const SizedBox(),
        );
      }
    }
    if (!(validate ?? true)) return Icon(Icons.info, color: ColorConstants.r400);
    if ((validate ?? false)) return Icon(Icons.done, color: ColorConstants.g400);
    return null;
  }

  Widget? get _visibilityButton {
    return IconButton(
      onPressed: onVisibility,
      icon: Icon(!obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined),
    );
  }
}

/// Shadow Input Border
class InputBorderShadow extends InputBorder {
  InputBorderShadow({
    required this.child,
    required this.boxShadow,
  }) : super(borderSide: child.borderSide);

  /// Input border
  final InputBorder child;

  /// Shadow
  final BoxShadow boxShadow;

  @override
  bool get isOutline => child.isOutline;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => child.getInnerPath(rect, textDirection: textDirection);

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) => child.getOuterPath(rect, textDirection: textDirection);

  @override
  EdgeInsetsGeometry get dimensions => child.dimensions;

  @override
  InputBorder copyWith({BorderSide? borderSide, InputBorder? child, BoxShadow? boxShadow, bool? isOutline}) {
    return InputBorderShadow(
      child: (child ?? this.child).copyWith(borderSide: borderSide),
      boxShadow: boxShadow ?? this.boxShadow,
    );
  }

  @override
  ShapeBorder scale(double t) {
    final scalledChild = child.scale(t);

    return InputBorderShadow(
      child: scalledChild is InputBorder ? scalledChild : child,
      boxShadow: BoxShadow.lerp(null, boxShadow, t)!,
    );
  }

  @override
  void paint(Canvas canvas, Rect rect, {double? gapStart, double gapExtent = 0.0, double gapPercentage = 0.0, TextDirection? textDirection}) {
    final clipPath = Path()
      ..addRect(const Rect.fromLTWH(-5000, -5000, 10000, 10000))
      ..addPath(getInnerPath(rect), Offset.zero)
      ..fillType = PathFillType.evenOdd;
    canvas.clipPath(clipPath);

    final Paint paint = boxShadow.toPaint();
    final Rect bounds = rect.shift(boxShadow.offset).inflate(
          boxShadow.spreadRadius,
        );

    canvas.drawPath(getOuterPath(bounds), paint);

    child.paint(
      canvas,
      rect,
      gapStart: gapStart,
      gapExtent: gapExtent,
      gapPercentage: gapPercentage,
      textDirection: textDirection,
    );
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is InputBorderShadow && other.borderSide == borderSide && other.child == child && other.boxShadow == boxShadow;
  }

  @override
  int get hashCode => borderSide.hashCode ^ child.hashCode ^ boxShadow.hashCode;

  @override
  String toString() {
    return '${objectRuntimeType(this, 'InputBorderShadow')}($borderSide, $boxShadow, $child)';
  }
}

class CustomSelectionControls extends MaterialTextSelectionControls {
  CustomSelectionControls(this.handleColor) : controls = Platform.isIOS ? cupertinoDesktopTextSelectionControls : materialTextSelectionControls;

  final Color handleColor;
  final TextSelectionControls controls;

  /// Wrap the given handle builder with the needed theme data for
  /// each platform to modify the color.
  Widget _wrapWithThemeData(Widget Function(BuildContext) builder) => Platform.isIOS
      // ios handle uses the CupertinoTheme primary color, so override that.
      ? CupertinoTheme(data: CupertinoThemeData(primaryColor: handleColor), child: Builder(builder: builder))
      // material handle uses the selection handle color, so override that.
      : TextSelectionTheme(data: TextSelectionThemeData(selectionHandleColor: handleColor), child: Builder(builder: builder));
  @override
  Widget buildHandle(BuildContext context, TextSelectionHandleType type, double textHeight, [VoidCallback? onTap]) {
    return _wrapWithThemeData((context) => controls.buildHandle(context, type, textHeight));
  }
}
