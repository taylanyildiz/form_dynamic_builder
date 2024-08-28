import 'package:flutter/material.dart';

class BarBackButton extends StatelessWidget {
  const BarBackButton({
    super.key,
    required this.onTap,
  });

  /// Tap button
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onPressed: onTap,
      padding: EdgeInsets.zero,
      icon: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.chevron_left,
            size: 40.0,
          ),
          Text(
            "Back",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
