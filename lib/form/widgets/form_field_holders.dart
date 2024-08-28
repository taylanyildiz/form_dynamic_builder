import 'package:flutter/material.dart';
import '/core/models/models.dart';
import '/core/data/data.dart';
import '/core/widgets/widgets.dart';

class FormFieldHolders extends StatefulWidget {
  const FormFieldHolders({super.key});

  @override
  State<FormFieldHolders> createState() => _FormFieldHoldersState();
}

class _FormFieldHoldersState extends State<FormFieldHolders> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Card(
        child: SingleChildScrollView(
          child: ColumnSeparatorBuilder(
            separatorBuilder: (index) => const Divider(
              color: Color.fromARGB(96, 124, 121, 121),
              height: 1.0,
              endIndent: 0.0,
              indent: 0.0,
              thickness: 1.0,
            ),
            itemCount: formDynamicFieldHolders.length,
            itemBuilder: (index) {
              final holder = formDynamicFieldHolders[index];

              return Draggable(
                feedback: _buildChild(holder),
                data: defaultFormDynamicField(holder.type),
                child: _buildChild(holder),
                onDragEnd: (details) {
                  setState(() {});
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildChild(FormDynamicFieldHolder holder) {
    return MouseRegion(
      cursor: SystemMouseCursors.move,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 50.0, maxWidth: 200.0, minWidth: 200),
        child: Card(
          elevation: 0.0,
          color: Colors.white,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero, side: BorderSide.none),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Row(
              children: [
                IconTheme(
                  data: const IconThemeData(size: 15.0, color: Colors.black),
                  child: holder.icon,
                ),
                const SizedBox(width: 5.0),
                Expanded(
                  child: Text(
                    holder.title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
