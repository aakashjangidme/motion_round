import 'package:flutter/material.dart';

class XMargin extends StatelessWidget {
  final double margin;

  const XMargin(this.margin, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) => SizedBox(key: key, width: margin);
}

class YMargin extends StatelessWidget {
  final double margin;

  const YMargin(this.margin, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) => SizedBox(key: key, height: margin);
}
