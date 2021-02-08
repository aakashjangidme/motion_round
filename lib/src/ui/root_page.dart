import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/providers/auth_provider.dart';
import '../core/services/auth/auth_service.dart';
import 'navbar/bottom_nav.dart';
import 'onboard/login_screen.dart';
import 'widgets/margins.dart';
import 'widgets/spinner.dart';

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<AuthProvider>(context);

    var status = prov.status;

    print('[authStatus ] $status');

    switch (status) {
      case Status.Uninitialized:
        return const Splash();
        break;
      case Status.Authenticated:
        return BottomNav();
        break;

      case Status.Unauthenticated:
        return Login();
        break;

      default:
        return const Splash();
    }
  }
}

class Splash extends StatelessWidget {
  const Splash({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spinner(),
            const YMargin(32),
            const Text('Initializing...'),
          ],
        ),
      ),
    );
  }
}
