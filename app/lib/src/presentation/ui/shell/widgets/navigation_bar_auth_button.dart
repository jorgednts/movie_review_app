import 'package:core/core.dart';
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
    return Consumer<UserStorageChangeNotifier>(
      builder: (context, authChangeNotifier, child) {
        final user = authChangeNotifier.user;
        return OutlinedButton(
          onPressed: user == null ? onSignIn : onSignOut,
          child: Text(
            user == null
                ? AppIntl.of(context).shell_sign_in
                : AppIntl.of(context).shell_sign_out,
            style: Theme.of(
              context,
            ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }
}
