import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

class Spinner extends StatelessWidget {
  const Spinner({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Center(
        heightFactor: 0.6,
        child: CircularProgressIndicator(
          strokeWidth: 3,
          valueColor: AlwaysStoppedAnimation(AppTheme.kAccent.withOpacity(0.7)),
        ),
      );
}
