import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import 'spinner.dart';

class CustomFlatButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final EdgeInsets padding;
  final Color textColor;
  final Color buttonColor;
  final bool loading;
  final FocusNode focusNode;

  const CustomFlatButton({
    Key key,
    @required this.onPressed,
    @required this.buttonText,
    this.padding = AppTheme.defaultPadding,
    this.textColor = Colors.white,
    this.buttonColor = Colors.green,
    this.loading = false,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var theme = Theme.of(context);
    return Padding(
      padding: padding,
      child: RawMaterialButton(
        key: key,
        focusNode: focusNode,
        onPressed: loading ? null : onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          padding: EdgeInsets.symmetric(vertical: 16),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: loading
                ? null
                : LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [AppTheme.kAccent, AppTheme.kSecondary],
                  ),
          ),
          child: loading
              ? Spinner()
              : Text(
                  buttonText,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }
}
