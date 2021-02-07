import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key key,
    int selectedIndex = 0,
    @required this.icons,
    @required this.onChanged,
  })  : _selectedIndex = selectedIndex,
        super(key: key);

  final int _selectedIndex;
  final List<IconData> icons;
  final Function(int) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        key: key,
        children: [
          ...icons
              .asMap()
              .entries
              .map(
                (k) => Flexible(
                  child: GestureDetector(
                    key: ValueKey(k.key),
                    onTap: () {
                      onChanged(k.key);
                    },
                    child: NavBarItem(
                      key: ValueKey(k.key),
                      icon: k.value,
                      isActive: _selectedIndex == k.key,
                      itemsLength: icons.length,
                    ),
                  ),
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}

class NavBarItem extends StatelessWidget {
  const NavBarItem({
    Key key,
    @required this.icon,
    @required this.isActive,
    @required this.itemsLength,
  }) : super(key: key);
  final IconData icon;
  final bool isActive;
  final int itemsLength;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      key: key,
      height: 60,
      width: size.width / itemsLength,
      decoration: isActive
          ? BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 2,
                  color: theme.accentColor,
                ),
              ),
              gradient: LinearGradient(
                colors: [
                  AppTheme.kAccent.withOpacity(0.3),
                  AppTheme.kAccent.withOpacity(0.015)
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            )
          : BoxDecoration(),
      child: Icon(
        icon,
        color:
            isActive ? theme.accentColor : theme.accentColor.withOpacity(0.5),
      ),
    );
  }
}
