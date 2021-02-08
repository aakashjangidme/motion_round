import 'package:flutter/material.dart';
import 'package:machine_round_task/src/ui/widgets/animations/delayed_animation.dart';
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
              _buildHeaderText(theme),
              const YMargin(32),
              _buildQrImage(theme, prov),
              const YMargin(32),
              _buildName(prov, theme),
              const YMargin(8),
              _buildEmail(prov, theme),
            ],
          ),
        ],
      ),
    );
  }

  DelayedAnimation _buildEmail(AuthProvider prov, ThemeData theme) {
    return DelayedAnimation(
      animationDuration: 500,
      offsetX: 0.0,
      offsetY: 0.35,
      delayedAnimation: 1000,
      child: Text(
        prov.userDetails?.email ?? '',
        style: theme.textTheme.caption.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  DelayedAnimation _buildName(AuthProvider prov, ThemeData theme) {
    return DelayedAnimation(
      animationDuration: 400,
      offsetX: 0.0,
      offsetY: 0.35,
      delayedAnimation: 800,
      child: Text(
        prov.userDetails?.name ?? '',
        style: theme.textTheme.bodyText1.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  DelayedAnimation _buildHeaderText(ThemeData theme) {
    return DelayedAnimation(
      animationDuration: 700,
      offsetX: 0.0,
      offsetY: 0.35,
      delayedAnimation: 300,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          'SCAN QR.',
          style: theme.textTheme.bodyText1.copyWith(
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  DelayedAnimation _buildQrImage(ThemeData theme, AuthProvider prov) {
    return DelayedAnimation(
      key: Key('QrImage'),
      animationDuration: 500,
      offsetX: 0.0,
      offsetY: 0.35,
      delayedAnimation: 500,
      child: Align(
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
    );
  }
}
