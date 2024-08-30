import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/form/models/models.dart';
import '/form/providers/providers.dart';
import '/form/widgets/widgets.dart';

class FormSavedPage extends ConsumerWidget {
  const FormSavedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final formDynamic = ref.read(formNotifierProvider);
    final fields = formDynamic.fields;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(10.0),
              itemCount: fields.length,
              separatorBuilder: (context, index) => const SizedBox(height: 3.0),
              itemBuilder: (context, index) {
                final field = fields[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(field.labelText ?? "-", style: textTheme.labelLarge),
                    FormDynamicTextField(
                      withLabel: false,
                      field: field,
                    ),
                  ],
                );
              },
            ),
          ),
          TextButton(
            onPressed: () {
              ref.read(formPageProvider).jumpToPage(FormPages.editing.index);
            },
            child: const Text("Edit"),
          )
        ],
      ),
    );
  }
}
