import 'dart:convert';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import '/core/widgets/widgets.dart';
import 'package:image_picker/image_picker.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({
    super.key,
    required this.image,
    required this.onChanged,
    required this.onDelete,
  });

  /// Image [base64] data
  final String? image;

  /// Changed image
  final void Function(String image) onChanged;

  /// Delete image
  final void Function() onDelete;

  double get size => 100.0;
  bool get hasImage => image?.isEmpty ?? true;

  void Function()? _onTap() {
    if (!hasImage) return null;
    return _onChangedImage;
  }

  void _onChangedImage() async {
    try {
      final result = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (result == null) return;
      final imageBytes = await result.readAsBytes();
      final imageBase64 = base64Encode(imageBytes);
      onChanged.call(imageBase64);
    } catch (e) {
      // TODO: Error Image
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child = Image.memory(
      base64Decode(image ?? ""),
      fit: BoxFit.cover,
      width: size,
      height: size,
      errorBuilder: (_, error, __) => _errorBuilder,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        return Stack(
          children: [
            child,
            if (image?.isNotEmpty ?? false) Positioned(bottom: 0.0, right: 0.0, left: 0.0, child: _buildActions),
          ],
        );
      },
    );
    return GestureDetector(
      onTap: _onTap(),
      child: SizedBox(
        width: size,
        height: size,
        child: DottedBorder(
          child: child,
        ),
      ),
    );
  }

  Widget get _errorBuilder {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (image?.isEmpty ?? true)
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.image),
                Text("Choose Image"),
              ],
            ),
        ],
      ),
    );
  }

  Widget get _buildActions {
    return BlurCard(
      color: Colors.white.withOpacity(.4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            visualDensity: VisualDensity.compact,
            color: Colors.orange,
            onPressed: _onChangedImage,
            icon: const Icon(Icons.edit),
          ),
          Popover.confirm(
              title: "Warning!",
              description: "Are you sure want to remove this image?",
              onChanged: (result) {
                if (!result) return;
                onDelete.call();
              },
              builder: (open) {
                return IconButton(
                  visualDensity: VisualDensity.compact,
                  color: Colors.red,
                  onPressed: open,
                  icon: const Icon(Icons.delete),
                );
              }),
        ],
      ),
    );
  }
}
