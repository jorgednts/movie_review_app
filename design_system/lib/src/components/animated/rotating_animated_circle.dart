import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class RotatingAnimatedCircle extends StatefulWidget {
  final EdgeInsets padding;
  final double? radius;
  final Widget child;

  const RotatingAnimatedCircle({
    super.key,
    this.padding = const EdgeInsets.all(Dimensions.spacingMd),
    this.radius,
    required this.child,
  });

  @override
  State<RotatingAnimatedCircle> createState() => _RotatingAnimatedCircleState();
}

class _RotatingAnimatedCircleState extends State<RotatingAnimatedCircle>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.radius,
      height: widget.radius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      padding: widget.padding,
      child: RotationTransition(turns: _controller, child: widget.child),
    );
  }
}
