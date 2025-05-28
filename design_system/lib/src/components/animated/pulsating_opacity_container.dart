import 'package:flutter/material.dart';

import '../../tokens/dimensions/dimensions.dart';

class PulsatingOpacityContainer extends StatefulWidget {
  const PulsatingOpacityContainer({
    super.key,
    required this.color,
    this.duration = const Duration(seconds: 2),
    required this.child,
    this.padding = const EdgeInsets.all(Dimensions.spacingMd),
  });

  final Color color;
  final Duration duration;
  final Widget child;
  final EdgeInsets padding;

  @override
  State<PulsatingOpacityContainer> createState() =>
      _PulsatingOpacityContainerState();
}

class _PulsatingOpacityContainerState extends State<PulsatingOpacityContainer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final CurvedAnimation _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this)
      ..repeat(reverse: true);

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        FadeTransition(
          opacity: _animation,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.color.withValues(alpha: 255 * 0.6),
            ),
            padding: widget.padding,
            child: widget.child,
          ),
        ),
        widget.child,
      ],
    );
  }
}
