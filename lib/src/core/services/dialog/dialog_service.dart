import 'package:flutter/material.dart';

import '../../../ui/widgets/custom_alert_dialog.dart';
import '../../constants/constants.dart';

class DialogService {
  Future<bool> showAlertDialog({
    String title,
    String content,
    Key key,
    bool showCancelBUtton,
    String okButtonText,
  }) async {
    return showDialog(
      context: Constants.navigatorKey.currentContext,
      child: CustomAlertDialog(
        key: key,
        title: title,
        content: content,
        showCancelButton: showCancelBUtton,
        okButtonText: okButtonText,
      ),
    );
  }
}
