import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/form/providers/providers.dart';
import '/core/widgets/widgets.dart';

class FormActions extends ConsumerWidget {
  const FormActions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(formNotifierProvider);
    final formNotifier = ref.read(formNotifierProvider.notifier);
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            child: PrimaryButton(
              title: "Clear",
              borderSide: BorderSide.none,
              minimumSize: const Size.fromHeight(40.0),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(6.0)),
              onPressed: formNotifier.onClear(),
            ),
          ),
          PrimaryButton(
            onPressed: formNotifier.onDisplay(),
            minimumSize: const Size(40, 40),
            borderSide: BorderSide.none,
            padding: EdgeInsets.zero,
            foregroundColor: Colors.white,
            backgroundColor: Colors.black,
            title: "[{...}]",
          ),
          Expanded(
            child: PrimaryButton(
              onPressed: formNotifier.onSave(),
              title: "Save",
              minimumSize: const Size.fromHeight(40.0),
              borderSide: BorderSide.none,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(6.0),
              borderRadius: const BorderRadius.horizontal(right: Radius.circular(6.0)),
              backgroundColor: Colors.blue,
            ),
          )
        ],
      ),
    );
  }
}
