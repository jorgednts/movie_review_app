import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:internationalization/internationalization.dart';

class LoadingMoreWidget extends StatefulWidget {
  const LoadingMoreWidget({super.key});

  @override
  State<LoadingMoreWidget> createState() => _LoadingMoreWidgetState();
}

class _LoadingMoreWidgetState extends State<LoadingMoreWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final CurvedAnimation _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Card(
        color: Theme.of(context).colorScheme.tertiaryContainer,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.spacingSm,
            vertical: Dimensions.spacingSm,
          ),
          child: Text(
            AppIntl.of(context).search_loading_more,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Theme.of(context).colorScheme.onTertiaryContainer,
            ),
          ),
        ),
      ),
    );
  }
}
