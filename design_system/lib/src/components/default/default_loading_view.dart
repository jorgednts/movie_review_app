import 'package:core/core.dart';
import 'package:flutter/material.dart';

class DefaultLoadingView extends StatelessWidget {
  const DefaultLoadingView({
    super.key,
    required this.child,
    this.loadingWidget = const CircularProgressIndicator(),
    required this.listenables,
    required this.onError,
    required this.onSuccess,
  });

  final Widget child;
  final Widget loadingWidget;
  final List<Command> listenables;
  final void Function() onError;
  final void Function() onSuccess;

  bool showError() {
    return listenables.any((command) => command.error);
  }

  bool showLoading() {
    return listenables.any((command) => command.running);
  }

  bool showSuccess() {
    return listenables.any((command) => command.completed);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        AnimatedBuilder(
          animation: Listenable.merge(listenables),
          builder: (context, _) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (showError()) {
                onError();
              }

              if (showSuccess()) {
                onSuccess();
              }
            });

            if (showLoading()) {
              return Center(
                child: Container(
                  color: Theme.of(
                    context,
                  ).colorScheme.surface.withValues(alpha: 255 * 0.2),
                  child: loadingWidget,
                ),
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
