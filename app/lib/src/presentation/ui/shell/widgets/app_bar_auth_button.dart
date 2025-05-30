import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppBarAuthButton extends StatelessWidget {
  const AppBarAuthButton({
    super.key,
    required this.onSignIn,
    required this.onSignOut,
  });

  final void Function() onSignIn;
  final void Function() onSignOut;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserStorageChangeNotifier>(
      builder:
          (context, authChangeNotifier, child) => LayoutBuilder(
            builder: (_, constraints) {
              final user = authChangeNotifier.user;
              return InkWell(
                onTap: user == null ? onSignIn : onSignOut,
                overlayColor: WidgetStateColor.transparent,
                child: Container(
                  height: constraints.maxHeight * 0.6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  padding: EdgeInsets.all(6),
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Icon(
                      user == null ? Icons.login : Icons.logout,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ),
              );
            },
          ),
    );
  }
}
