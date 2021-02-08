import 'package:flutter/material.dart';

import '../../ui/navbar/bottom_nav.dart';
import '../../ui/onboard/forgot_password_screen.dart';
import '../../ui/onboard/login_screen.dart';
import '../../ui/onboard/register_screen.dart';
import '../../ui/root_page.dart';

class Routes {
  static const rootPage = '/';
  static const homeRoute = '/home';
  static const registerRoute = '/register';
  static const loginRoute = '/login';
  static const forgotPassword = '/forgot-password';
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case rootPage:
        return MaterialPageRoute(builder: (_) => RootPage());
      case homeRoute:
        return MaterialPageRoute(builder: (_) => BottomNav());
      case loginRoute:
        return MaterialPageRoute(builder: (_) => Login());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => ForgotPassword());
      case registerRoute:
        return MaterialPageRoute(builder: (_) => RegisterScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
