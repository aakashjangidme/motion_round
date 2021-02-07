import 'package:flutter/material.dart';

import '../home/home.dart';
import '../settings/settings.dart';
import 'components/custom_bottom_navbar.dart';

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  final List<Widget> _body = [
    Home(),
    Settings(),
  ];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    return Scaffold(
      body: _body[_selectedIndex],
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onChanged: (i) => setState(() => _selectedIndex = i),
        icons: [
          Icons.home,
          Icons.settings,
        ],
      ),
    );
  }
}
