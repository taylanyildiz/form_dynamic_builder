import '/core/constants/constants.dart';
import 'package:flutter/material.dart';

class RadioButton extends StatelessWidget {
  const RadioButton({
    super.key,
    this.onChanged,
    required this.value,
    required this.title,
  });

  /// Tile of button
  final String title;

  /// Radio value
  ///
  final bool value;

  /// On changed value
  final void Function(bool value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChanged == null
          ? null
          : () {
              onChanged?.call(!value);
            },
      child: Card(
        color: value ? ColorConstants.bat25 : ColorConstants.gray50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(
            color: value ? ColorConstants.bat50 : ColorConstants.gray100,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 7.0),
          child: Row(
            children: [
              Card(
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(
                    color: value ? ColorConstants.bat50 : ColorConstants.gray300,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SizedBox(
                    width: 18.0,
                    height: 18.0,
                    child: Card(
                      color: value ? ColorConstants.bat400 : Colors.transparent,
                      shape: RoundedRectangleBorder(
                        side: BorderSide.none,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: value ? ColorConstants.bat400 : ColorConstants.gray500,
                    fontWeight: value ? FontWeight.bold : null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
