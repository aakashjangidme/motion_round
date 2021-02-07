import 'package:flutter/material.dart';

/// Cancel returns false
/// - ok return true  i.e wanna exit!
class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    Key key,
    this.cancelButtonText = 'CANCEL',
    this.okButtonText = 'OK',
    this.showCancelButton = false,
    this.title,
    this.content,
  }) : super(key: key);

  final String cancelButtonText;
  final String okButtonText;
  final bool showCancelButton;
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return AlertDialog(
      title: title != null
          ? Text(
              title,
              style: theme.textTheme.bodyText1.copyWith(fontSize: 18),
            )
          : null,
      content: content != null
          ? Text(
              content,
              style: theme.textTheme.bodyText2.copyWith(fontSize: 16),
            )
          : null,
      actions: [
        ButtonBar(
          children: [
            if (showCancelButton)
              FlatButton(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  cancelButtonText,
                ),
              ),
            FlatButton(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(
                okButtonText ?? 'OK',
              ),
            ),
          ],
        )
      ],
    );
  }
}
