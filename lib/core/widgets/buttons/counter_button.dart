import 'package:flutter/material.dart';
import 'primary_button.dart';

class CounterButton extends StatefulWidget {
  const CounterButton({
    super.key,
    required this.count,
    this.condition,
    required this.onChanged,
  });

  /// Count
  final int count;

  /// Condtion count
  final bool Function(int count)? condition;

  /// Chaned count
  final void Function(int count) onChanged;

  @override
  State<CounterButton> createState() => _CounterButtonState();
}

class _CounterButtonState extends State<CounterButton> {
  ///
  int count = 0;

  @override
  void initState() {
    count = widget.count;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CounterButton oldWidget) {
    if (oldWidget.count != widget.count) {
      count = widget.count;
    }
    super.didUpdateWidget(oldWidget);
  }

  void onIncrement() {
    final result = count + 1;
    final condition = widget.condition?.call(result) ?? true;
    if (!condition) return;
    setState(() => count++);
    widget.onChanged.call(count);
  }

  void onDecrease() {
    final result = count - 1;
    final condition = widget.condition?.call(result) ?? true;
    if (!condition) return;
    setState(() => count--);
    widget.onChanged.call(count);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PrimaryButton(
          padding: EdgeInsets.zero,
          minimumSize: const Size(35.0, 35.0),
          onPressed: onDecrease,
          child: const Icon(Icons.remove),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 30.0, minWidth: 30.0),
          child: Text(
            "$count",
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
        ),
        PrimaryButton(
          padding: EdgeInsets.zero,
          minimumSize: const Size(35.0, 35.0),
          onPressed: onIncrement,
          child: const Icon(Icons.add),
        )
      ],
    );
  }
}
