import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../core/providers/auth_provider.dart';
import '../widgets/margins.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<AuthProvider>(context);

    var theme = Theme.of(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              const YMargin(32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'SCAN QR.',
                  style: theme.textTheme.bodyText1.copyWith(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const YMargin(32),
              Align(
                alignment: Alignment.center,
                child: QrImage(
                  foregroundColor: theme.accentColor,
                  data: prov.userDetails?.contact ?? 'null',
                  version: QrVersions.auto,
                  size: 200.0,
                  errorStateBuilder: (__, _) => Container(
                    child: Center(
                      child: Text(
                        'Uh oh! Something went wrong...',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              const YMargin(32),
              Text(
                prov.userDetails?.name,
                style: theme.textTheme.bodyText1.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const YMargin(8),
              Text(
                prov.userDetails?.email,
                style: theme.textTheme.caption.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
