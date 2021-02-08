import 'dart:async';

import 'package:flutter/material.dart';

class DelayedAnimation extends StatefulWidget {
  final Widget child;

  /// starts the animation after this duration.
  /// (milliseconds)
  final int delayedAnimation;
  final double offsetX;
  final double offsetY;

  // Total duration of the animation
  final int animationDuration;

  const DelayedAnimation({
    Key key,
    this.delayedAnimation,
    this.offsetX = 0.0,
    @required this.offsetY,
    this.animationDuration,
    @required this.child,
  }) : super(key: key);
  @override
  _DelayedAnimationState createState() => _DelayedAnimationState();
}

class _DelayedAnimationState extends State<DelayedAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _animationOffset;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: widget.animationDuration));

    final curve =
        CurvedAnimation(curve: Curves.decelerate, parent: _controller);

    _animationOffset = Tween<Offset>(
            begin: Offset(widget.offsetX, widget.offsetY), end: Offset.zero)
        ?.animate(curve);

    if (widget.delayedAnimation == null) {
      _controller?.forward();
    } else {
      _timer = Timer(Duration(milliseconds: widget.delayedAnimation), () {
        _controller?.forward();
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      child: SlideTransition(position: _animationOffset, child: widget.child),
      opacity: _controller,
    );
  }
}
