import 'package:app/src/presentation/ui/shell/widgets/user_listenable_widget.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:internationalization/internationalization.dart';
import 'package:provider/provider.dart';

class NavigationBarAuthButton extends StatelessWidget {
  const NavigationBarAuthButton({
    super.key,
    required this.onSignIn,
    required this.onSignOut,
  });

  final void Function() onSignIn;
  final void Function() onSignOut;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: Dimensions.spacingMd,
      children: [
        Consumer<ThemeNotifier>(
          builder: (_, themeNotifier, child) {
            final themeMode = themeNotifier.themeMode;
            return IconButton.filledTonal(
              onPressed: themeNotifier.toggleTheme,
              icon: Icon(
                themeMode == ThemeMode.dark
                    ? Icons.sunny
                    : Icons.nights_stay,
              ),
            );
          },
        ),
        UserListenableWidget(
          child: Consumer<UserStorageChangeNotifier>(
            builder: (context, authChangeNotifier, child) {
              final user = authChangeNotifier.user;
              return IconButton.outlined(
                onPressed: user == null ? onSignIn : onSignOut,
                icon: Row(
                  spacing: Dimensions.spacingXs,
                  children: [
                    Icon(user == null ? Icons.login : Icons.logout),
                    Text(
                      user == null
                          ? AppIntl.of(context).shell_sign_in
                          : AppIntl.of(context).shell_sign_out,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
