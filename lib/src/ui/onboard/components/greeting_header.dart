import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

Widget buildGreetingHeader(
    String heading, String subheading, BuildContext context) {
  var theme = Theme.of(context);
  return Padding(
    padding: AppTheme.defaultPadding,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: theme.textTheme.headline4.copyWith(
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          subheading,
          style: theme.textTheme.caption.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}
