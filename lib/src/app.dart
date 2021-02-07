import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'core/constants/constants.dart';
import 'core/providers/auth_provider.dart';
import 'core/router/router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_notifier.dart';

class App extends StatelessWidget {
  final List<SingleChildWidget> providers = [
    ChangeNotifierProvider<AuthProvider>(
        create: (_) => AuthProvider(), lazy: false),
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (_, _themeNotifier, __) => MultiProvider(
        providers: providers,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: Routes.generateRoute,
          initialRoute: Routes.rootPage,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode:
              _themeNotifier.darkMode ? ThemeMode.dark : ThemeMode.system,
          navigatorKey: Constants.navigatorKey,
        ),
      ),
    );
  }
}
