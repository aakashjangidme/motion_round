import 'package:flutter/cupertino.dart';

enum ModelStatus { idle, busy }

class Constants {
  Constants._();
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static const appName = 'Overflow';
}
