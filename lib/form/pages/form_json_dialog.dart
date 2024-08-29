import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_generator/core/widgets/widgets.dart';
import '../providers/providers.dart';

class FormJsonDialog extends ConsumerWidget {
  const FormJsonDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jsonString = ref.read(formJsonProvider);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      insetPadding: const EdgeInsets.all(4.0),
      child: Container(
        width: 600,
        height: 600,
        padding: const EdgeInsets.all(6.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
            side: const BorderSide(width: 1.0),
          ),
          child: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(10.0),
                  child: SelectableText(
                    jsonString,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
              Positioned(
                top: 10.0,
                right: 10.0,
                child: _buildCopyButton(jsonString),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCopyButton(String data) {
    return Popover(
      duration: const Duration(seconds: 1),
      pop: Card(
        margin: const EdgeInsets.only(top: 6.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
        elevation: 5.0,
        shadowColor: Colors.black54,
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Copied",
            style: TextStyle(color: Colors.black, fontSize: 12.0),
          ),
        ),
      ),
      builder: (open) => Container(
        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        child: IconButton(
          onPressed: () async {
            await Clipboard.setData(ClipboardData(text: data));
            open();
          },
          icon: const Icon(Icons.copy),
        ),
      ),
    );
  }
}
