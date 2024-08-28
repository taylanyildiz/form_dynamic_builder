import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
                  child: Text(
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
    return Container(
      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      child: IconButton(
        onPressed: () {
          Clipboard.setData(ClipboardData(text: data));
        },
        icon: const Icon(Icons.copy),
      ),
    );
  }
}
