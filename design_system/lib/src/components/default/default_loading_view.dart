import 'package:core/core.dart';
import 'package:flutter/material.dart';

class DefaultLoadingView extends StatelessWidget {
  const DefaultLoadingView({
    super.key,
    required this.child,
    this.loadingWidget = const CircularProgressIndicator(),
    required this.listenables,
    required this.showLoading,
  });

  final Widget child;
  final Widget loadingWidget;
  final List<Command> listenables;
  final bool Function() showLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        AnimatedBuilder(
          animation: Listenable.merge(listenables),
          builder: (context, _) {
            if (showLoading()) {
              return Container(
                color: Theme.of(
                  context,
                ).scaffoldBackgroundColor.withValues(alpha: 0.5),
                alignment: Alignment.center,
                child: loadingWidget,
              );
            } else {
              return Padding(padding: EdgeInsets.zero);
            }
          },
        ),
      ],
    );
  }
}
