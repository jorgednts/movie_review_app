import 'package:core/core.dart';
import 'package:flutter/material.dart';

class AppBarAuthButton extends StatelessWidget {
  const AppBarAuthButton({
    super.key,
    required this.userValueNotifier,
    required this.onSignIn,
    required this.onSignOut,
    required this.checkUserLoggedCommand,
  });

  final ValueNotifier<UserModel?> userValueNotifier;
  final void Function() onSignIn;
  final void Function() onSignOut;
  final Command0<void> checkUserLoggedCommand;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ListenableBuilder(
          listenable: checkUserLoggedCommand,
          builder: (_, __) {
            if (checkUserLoggedCommand.running) {
              return SizedBox();
            }
            return InkWell(
              onTap: userValueNotifier.value == null ? onSignIn : onSignOut,
              overlayColor: WidgetStateColor.transparent,
              child: Container(
                height: constraints.maxHeight * 0.6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                padding: EdgeInsets.all(6),
                child: ValueListenableBuilder(
                  valueListenable: userValueNotifier,
                  builder: (context, user, child) {
                    return FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Icon(
                        user == null ? Icons.login : Icons.logout,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
