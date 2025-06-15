import 'package:app/src/presentation/ui/shell/widgets/user_listenable_widget.dart';
import 'package:app/src/presentation/utils/custom_theme_notifier.dart';
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
    required this.onDeleteUser,
  });

  final void Function() onSignIn;
  final void Function() onSignOut;
  final void Function() onDeleteUser;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: Dimensions.spacingMd,
      children: [
        Consumer<CustomThemeNotifier>(
          builder: (_, themeNotifier, child) {
            final themeMode = themeNotifier.themeMode;
            return IconButton.outlined(
              onPressed: themeNotifier.toggleTheme,
              color: Theme.of(context).colorScheme.onSecondaryContainer,
              icon: Icon(
                themeMode == ThemeMode.dark
                    ? Icons.wb_sunny_outlined
                    : Icons.nights_stay_outlined,
              ),
            );
          },
        ),
        UserListenableWidget(
          child: Consumer<UserStorageChangeNotifier>(
            builder: (context, authChangeNotifier, child) {
              final user = authChangeNotifier.user;
              final username =
                  authChangeNotifier.userStorageModel?.name.toUpperCase() ?? '';
              return user == null
                  ? IconButton(
                    onPressed: onSignIn,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                    icon: const Icon(Icons.person_outline),
                  )
                  : IconButton.filledTonal(
                    onPressed:
                        () => showMenu(
                          context: context,
                          position: RelativeRect.fromLTRB(
                            MediaQuery.of(context).size.width,
                            kToolbarHeight + Dimensions.spacingLg,
                            0,
                            0,
                          ),
                          color: Theme.of(context).colorScheme.surface,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(Dimensions.radiusLg),
                            ),
                          ),
                          elevation: 4,
                          items: [
                            PopupMenuItem(
                              onTap: onSignOut,
                              child: ListTile(
                                title: Text(AppIntl.of(context).shell_sign_out),
                                leading: const Icon(Icons.logout),
                              ),
                            ),
                            PopupMenuItem(
                              onTap: onDeleteUser,
                              child: ListTile(
                                title: StyledText.b2(
                                  AppIntl.of(context).shell_delete_user,
                                  fontColor:
                                      Theme.of(context).colorScheme.error,
                                ),
                                leading: Icon(
                                  Icons.person_remove,
                                  color: Theme.of(context).colorScheme.error,
                                ),
                              ),
                            ),
                          ],
                        ),
                    icon:
                        username.isEmpty
                            ? const Icon(Icons.person_outline)
                            : StyledText.b3(
                              username.substring(0, 1),
                              isBold: true,
                              fontColor:
                                  Theme.of(
                                    context,
                                  ).colorScheme.onSecondaryContainer,
                            ),
                  );
            },
          ),
        ),
      ],
    );
  }
}
