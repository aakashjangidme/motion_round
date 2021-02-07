import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final String hint;
  final bool obsecureText;
  final IconData prefixIcon;
  final IconData suffixIcon;
  final VoidCallback onTapSuffix;
  final TextEditingController controller;
  final Function(String) onChanged;
  final AutovalidateMode autoValidateMode;
  final bool enabled;
  final FocusNode focusNode;
  final Function(String) validator;
  final EdgeInsets padding;
  final TextInputType keyBoardType;
  final TextInputAction textInputAction;
  final Function(String) onFieldSubmitted;
  final VoidCallback onTap;

  const CustomInputField({
    Key key,
    @required this.label,
    this.obsecureText = false,
    @required this.prefixIcon,
    this.controller,
    this.onChanged,
    this.autoValidateMode,
    this.enabled = true,
    this.focusNode,
    this.validator,
    this.padding = AppTheme.defaultPadding,
    this.hint,
    this.suffixIcon,
    this.onTapSuffix,
    this.keyBoardType,
    this.textInputAction,
    this.onFieldSubmitted,
    this.onTap,
  })  : assert(label != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: padding,
      child: TextFormField(
        key: key,
        onTap: onTap,
        controller: controller,
        obscureText: obsecureText,
        onChanged: onChanged,
        enabled: true,
        focusNode: focusNode,
        validator: validator,
        autovalidateMode: autoValidateMode,
        style: theme.textTheme.bodyText1,
        keyboardType: keyBoardType,
        textInputAction: textInputAction,
        onFieldSubmitted: onFieldSubmitted,
        decoration: InputDecoration(
          hintText: hint,
          labelText: label,
          prefixIcon: Icon(
            prefixIcon,
            color: theme.iconTheme.color.withOpacity(0.5),
          ),
          suffixIcon: InkWell(
            borderRadius: BorderRadius.circular(32),
            onTap: onTapSuffix,
            enableFeedback: true,
            child: Icon(
              suffixIcon,
                        color: theme.iconTheme.color.withOpacity(0.5),

            ),
          ),
        ),
      ),
    );
  }
}
