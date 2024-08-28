import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  ConfirmDialog({
    super.key,
    Widget? title,
    this.titleText,
    this.contentText,
    Widget? content,
    this.onConfrim,
    this.onCancel,
  })  : assert(
            title == null || titleText == null,
            'Cannot provide both a title and a titleText\n'
            'The titleText argument is just a shorthand for "title:  Text(titleText)".'),
        assert(
            content == null || contentText == null,
            'Cannot provide both a content and a contentText\n'
            'The contentText argument is just a shorthand for "content:  Text(contentText)".'),
        content = content ?? (contentText != null ? Text(contentText) : null),
        title = title ?? (titleText != null ? Text(titleText) : null);

  /// Dialog title
  final Widget? title;

  /// Dialog title text
  final String? titleText;

  /// Dialog content text
  final String? contentText;

  /// Dialog content
  final Widget? content;

  /// Confirm button click
  final void Function()? onConfrim;

  /// Cancel button click
  final void Function()? onCancel;

  Widget adaptiveAction({required BuildContext context, required VoidCallback onPressed, required String title}) {
    final ThemeData theme = Theme.of(context);
    switch (theme.platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return CupertinoDialogAction(
          onPressed: onPressed,
          child: Text(title),
        );
      default:
        return TextButton(
          onPressed: onPressed,
          // title: title,
          // color: Colors.black,
          // fontWeight: FontWeight.normal,
          // fontSize: 16.0,
          child: Text(title),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: title,
      content: content,
      actions: [
        adaptiveAction(
          context: context,
          onPressed: () {
            onCancel?.call();
            if (onCancel == null) Navigator.pop(context, false);
          },
          title: "No",
        ),
        adaptiveAction(
          context: context,
          onPressed: () {
            onConfrim?.call();
            if (onConfrim == null) Navigator.pop(context, true);
          },
          title: "Yes",
        ),
      ],
    );
  }
}
