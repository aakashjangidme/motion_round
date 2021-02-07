import 'package:flutter/material.dart';

import '../widgets/margins.dart';

class SettingsItem {
  final String title;
  final String subtitle;
  final Widget trailing;
  SettingsItem({
    this.title,
    this.subtitle,
    this.trailing = const Icon(Icons.arrow_forward_ios),
  });
}

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    Key key,
    @required this.settingName,
    @required this.items,
    this.onTap,
  }) : super(key: key);
  final String settingName;
  final VoidCallback onTap;

  final List<SettingsItem> items;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$settingName',
            style: theme.textTheme.bodyText1.copyWith(fontSize: 13),
          ),
          YMargin(8),
          ...items
              .asMap()
              .entries
              .map(
                (k) => InkWell(
                  onTap: onTap,
                  child: SettingTileCard(
                    key: ValueKey(k.key),
                    title: k.value.title,
                    subtitle: k.value.subtitle,
                    trailing: k.value.trailing,
                  ),
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}

class SettingTileCard extends StatelessWidget {
  const SettingTileCard({
    @required Key key,
    @required this.title,
    @required this.subtitle,
    @required this.trailing,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Card(
      key: key,
      color: theme.canvasColor,
      margin: EdgeInsets.zero,
      elevation: 2,
      child: ListTile(
        key: key,
        title: title == null
            ? null
            : Text(
                title,
                style: theme.textTheme.bodyText1.copyWith(
                  fontSize: 16,
                ),
              ),
        subtitle: subtitle == null
            ? null
            : Text(
                subtitle,
                style: theme.textTheme.caption.copyWith(
                  fontSize: 13,
                ),
              ),
        trailing: trailing,
      ),
    );
  }
}
