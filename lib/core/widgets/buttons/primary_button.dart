import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class PrimaryButtonController {
  // Loading start
  void Function()? _onLoading;

  // Loading done
  Future<void> Function()? _onDone;

  void _listener(void Function()? onLoading, Future<void> Function()? onDone) {
    _onDone = onDone;
    _onLoading = onLoading;
  }

  /// Done loading
  ///
  Future<void> done() => _onDone!.call();

  /// Start loading
  ///
  void loading() => _onLoading!.call();
}

class PrimaryButton extends StatefulWidget {
  PrimaryButton({
    super.key,
    this.controller,
    required this.onPressed,
    this.child,
    this.title,
    this.icon,
    this.titleStyle,
    this.backgroundColor,
    this.foregroundColor,
    this.height,
    this.width,
    double? radius,
    BorderRadius? borderRadius,
    this.borderSide,
    this.padding,
    this.minimumSize,
  })  : assert((title == null || child == null) && (title != null || child != null)),
        assert(radius == null || borderRadius == null),
        borderRadius = borderRadius ?? (radius != null ? BorderRadius.circular(radius) : null);

  /// Priamry controller
  final PrimaryButtonController? controller;

  /// Called when the button is tapped.
  final void Function()? onPressed;

  /// Child of button
  /// High priority than [title]
  final Widget? child;

  /// Title of button
  final String? title;

  /// Icon of button
  final Widget? icon;

  /// Title style
  final TextStyle? titleStyle;

  /// Background color
  final Color? backgroundColor;

  /// Foreground color
  final Color? foregroundColor;

  /// Height fixed
  final double? height;

  /// Width fixed
  final double? width;

  /// Border radius
  /// default [12.0]
  final BorderRadius? borderRadius;

  /// Border side
  final BorderSide? borderSide;

  /// Padding
  final EdgeInsetsGeometry? padding;

  /// Minimum size
  final Size? minimumSize;
  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  CrossFadeState crossFadeState = CrossFadeState.showFirst;
  bool get loading => crossFadeState == CrossFadeState.showSecond;

  @override
  void initState() {
    widget.controller?._listener(_onLoading, _onDone);
    super.initState();
  }

  void _onLoading() async {
    if (!mounted) return;
    setState(() => crossFadeState = CrossFadeState.showSecond);
  }

  Future<void> _onDone() async {
    if (!mounted) return;
    setState(() => crossFadeState = CrossFadeState.showFirst);
    await Future.delayed(const Duration(milliseconds: 400));
  }

  void Function()? _onPressed() {
    if (loading) return null;
    return widget.onPressed;
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).elevatedButtonTheme.style;
    return ElevatedButtonTheme(
      data: ElevatedButtonThemeData(
        style: style?.copyWith(
          backgroundColor: widget.backgroundColor != null
              ? WidgetStateProperty.resolveWith((states) {
                  if (!states.contains(WidgetState.disabled)) {
                    return widget.backgroundColor;
                  }
                  return ColorConstants.gray300;
                })
              : null,
          foregroundColor: _foregroundColor,
          fixedSize: WidgetStatePropertyAll(Size(
            widget.width ?? double.infinity,
            widget.height ?? double.infinity,
          )),
          minimumSize: widget.minimumSize != null ? WidgetStatePropertyAll(widget.minimumSize!) : null,
          padding: WidgetStatePropertyAll(widget.padding),
          shape: widget.borderRadius != null || widget.borderSide != null
              ? WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: widget.borderRadius ?? BorderRadius.zero,
                    side: widget.borderSide ?? BorderSide.none,
                  ),
                )
              : null,
          textStyle: widget.titleStyle != null ? WidgetStatePropertyAll(widget.titleStyle) : null,
        ),
      ),
      child: ElevatedButton(
        onPressed: _onPressed(),
        child: buttonChild(style),
      ),
    );
  }

  Widget buttonChild(ButtonStyle? style) {
    Widget? children = widget.child;
    children ??= Text(widget.title!, style: widget.titleStyle);
    if (widget.icon != null) {
      children = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          children,
          const SizedBox(width: 4.0),
          _buildIconLoading,
        ],
      );
    }
    return children;
  }

  Widget get _buildIconLoading {
    return AnimatedCrossFade(
      alignment: Alignment.center,
      firstChild: widget.icon!,
      secondChild: const SizedBox(
        width: 20.0,
        height: 20.0,
        child: Padding(
          padding: EdgeInsets.all(2.0),
          child: CircularProgressIndicator.adaptive(
            backgroundColor: Colors.white,
          ),
        ),
      ),
      crossFadeState: crossFadeState,
      duration: const Duration(milliseconds: 400),
    );
  }

  WidgetStateProperty<Color?>? get _foregroundColor {
    Color? color = widget.foregroundColor ?? widget.titleStyle?.color;
    if (color != null) return WidgetStatePropertyAll(color);
    return null;
  }
}
