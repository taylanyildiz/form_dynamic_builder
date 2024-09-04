import 'dart:async';
import 'package:flutter/material.dart';
import '/core/widgets/widgets.dart';
import '/core/utils/functions.dart';

class PopOverConfirmDelegate {
  /// Title
  final String title;

  /// Description
  final String description;

  /// Changed action
  final Function(bool result) onTap;

  const PopOverConfirmDelegate(
    this.title,
    this.description,
    this.onTap,
  );
}

class Popover extends StatefulWidget {
  const Popover({
    super.key,
    required this.builder,
    required this.pop,
    this.duration,
    this.onChanged,
  }) : confirmDelegate = null;

  Popover.confirm({
    super.key,
    required this.builder,
    required String title,
    required String description,
    required Function(bool result) onTap,
    this.onChanged,
    this.duration,
  })  : pop = null,
        confirmDelegate = PopOverConfirmDelegate(title, description, onTap);

  /// Child builder popover
  ///
  /// use [open] to display pop over
  final Widget Function(void Function() open) builder;

  /// Popover itself
  final Widget? pop;

  /// Confirm delegate popover
  final PopOverConfirmDelegate? confirmDelegate;

  /// popover duration
  final Duration? duration;

  /// Changed popover overlay
  /// displaying status
  final void Function(bool status)? onChanged;

  @override
  State<Popover> createState() => _PopoverState();
}

class _PopoverState extends State<Popover> {
  /// Popover delegate
  PopOverConfirmDelegate? confirmDelegate;

  /// Key help to display
  final GlobalKey _key = GlobalKey();

  /// Popover duration
  Timer? timer;
  Duration? duration;

  /// Overlay entry
  OverlayEntry? entry;
  bool isOpen = false;

  @override
  void initState() {
    duration = widget.duration;
    confirmDelegate = widget.confirmDelegate;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant Popover oldWidget) {
    if (oldWidget.duration != widget.duration) duration = widget.duration;
    super.didUpdateWidget(oldWidget);
  }

  void _open() {
    open();
    if (duration != null) Future.delayed(duration!).then((_) => close());
  }

  void open() {
    if (isOpen) return;
    final overlay = Overlay.of(context);
    entry = OverlayEntry(builder: _buildPopOver);
    overlay.insert(entry!);
    isOpen = true;
    widget.onChanged?.call(true);
  }

  void close([bool confirm = false]) {
    if (!isOpen) return;
    entry?.remove();
    entry = null;
    isOpen = false;
    confirmDelegate?.onTap.call(confirm);
    widget.onChanged?.call(false);
  }

  @override
  Widget build(BuildContext context) {
    final child = widget.builder.call(_open);
    return KeyedSubtree(
      key: _key,
      child: IgnorePointer(
        ignoring: false,
        child: child,
      ),
    );
  }

  Widget _buildPopOver(BuildContext context) {
    final offsetSize = finderOffSiz(_key);
    return LayoutBuilder(builder: (__, _) {
      return Stack(
        children: [
          GestureDetector(
            onTap: close,
            behavior: HitTestBehavior.translucent,
            child: const SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Card(color: Colors.transparent, elevation: 10.0, shadowColor: Colors.black54),
            ),
          ),
          Positioned(
            left: -offsetSize!.$1.dx,
            top: -offsetSize.$1.dy + offsetSize.$2.height,
            child: confirmDelegate != null ? _confirmPop : widget.pop!,
          ),
        ],
      );
    });
  }

  Widget get _confirmPop {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  confirmDelegate!.title,
                  style: textTheme.labelLarge,
                ),
                const SizedBox(height: 5.0),
                Text(
                  confirmDelegate!.description,
                  style: textTheme.labelMedium,
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                PrimaryButton(
                  minimumSize: Size.zero,
                  borderSide: BorderSide.none,
                  padding: const EdgeInsets.all(10.0),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  onPressed: close,
                  title: "No",
                ),
                const SizedBox(width: 10.0),
                PrimaryButton(
                  minimumSize: Size.zero,
                  padding: const EdgeInsets.all(10.0),
                  foregroundColor: Colors.white,
                  borderSide: BorderSide.none,
                  backgroundColor: Colors.green,
                  onPressed: () => close(true),
                  title: "Yes",
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
