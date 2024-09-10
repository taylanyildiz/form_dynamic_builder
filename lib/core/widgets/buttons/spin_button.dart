import 'dart:async';
import 'package:flutter/material.dart';

class SpinButton extends StatefulWidget {
  const SpinButton({
    super.key,
    BoxConstraints? constraints,
    required this.itemCount,
    required this.selectedIndex,
    required this.itemBuilder,
    ShapeBorder? shape,
    ShapeBorder? disabledShape,
    this.padding,
    this.onChanged,
  })  : assert(selectedIndex < itemCount && selectedIndex >= 0),
        constraints = constraints ?? const BoxConstraints(minHeight: 30.0, maxHeight: 30.0, minWidth: 40.0, maxWidth: 40.0),
        shape = onChanged != null
            ? (shape ??
                const RoundedRectangleBorder(
                  side: BorderSide(width: 1.0, color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(3.0)),
                ))
            : disabledShape ?? const RoundedRectangleBorder(side: BorderSide.none);

  /// Constraints of button
  ///
  /// default
  final BoxConstraints constraints;

  /// Item count
  /// to build [itemBuilder]
  final int itemCount;

  /// Selected item index
  final int selectedIndex;

  /// Item builder
  final Widget Function(BuildContext context, int index) itemBuilder;

  /// Shape border
  ///
  /// spin box button
  ///
  /// If [onChanged] null shape will be equal [disabledShape]
  final ShapeBorder shape;

  /// Padding shape inside
  final EdgeInsetsGeometry? padding;

  /// When change selected
  final void Function(int index)? onChanged;

  @override
  State<SpinButton> createState() => _SpinButtonState();
}

class _SpinButtonState extends State<SpinButton> {
  /// Page controller
  late final PageController pageController;

  Timer? timer;

  // Selected index
  late int selectedIndex;

  @override
  void initState() {
    selectedIndex = widget.selectedIndex;
    pageController = PageController(initialPage: widget.selectedIndex);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant SpinButton oldWidget) {
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      selectedIndex = widget.selectedIndex;
      WidgetsBinding.instance.scheduleFrameCallback((_) {
        pageController.jumpToPage(selectedIndex);
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  /// Tap
  void Function()? _onTap() {
    if (widget.onChanged == null) return null;
    return () {
      timer ??= Timer(const Duration(milliseconds: 100), () {
        int selected = selectedIndex == widget.itemCount - 1 ? 0 : ++selectedIndex;
        _jumpTopage(selected);
      });
    };
  }

  void _jumpTopage(int index) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 100),
      curve: Curves.linear,
    );
  }

  /// When changed page
  void _onPageChanged(int index) {
    widget.onChanged?.call(index);
    timer?.cancel();
    timer = null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Theme(
      data: theme.copyWith(
        textTheme: theme.textTheme.copyWith(
          bodyMedium: theme.textTheme.titleMedium?.copyWith(
            fontSize: 13.0,
            color: widget.onChanged == null ? Colors.grey : null,
          ),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        elevation: 0.0,
        child: InkWell(
          onTap: _onTap(),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          overlayColor: const WidgetStatePropertyAll(Colors.transparent),
          child: Card(
            shape: widget.shape,
            child: Padding(
              padding: const EdgeInsets.only(right: 2.0),
              child: Row(
                children: [
                  ConstrainedBox(
                    constraints: widget.constraints,
                    child: PageView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      onPageChanged: _onPageChanged,
                      scrollDirection: Axis.vertical,
                      controller: pageController,
                      itemCount: widget.itemCount,
                      itemBuilder: (context, index) => Center(
                        child: Container(
                          alignment: Alignment.center,
                          constraints: BoxConstraints(
                            minWidth: widget.constraints.maxWidth,
                          ),
                          child: widget.itemBuilder.call(context, index),
                        ),
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: widget.onChanged == null ? 0 : 1.0,
                    child: const Icon(Icons.keyboard_arrow_down),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
