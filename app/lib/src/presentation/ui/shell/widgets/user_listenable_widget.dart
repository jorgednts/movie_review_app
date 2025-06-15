import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/shell_view_model.dart';

class UserListenableWidget extends StatelessWidget {
  const UserListenableWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ShellViewModel>();
    return ListenableBuilder(
      listenable: Listenable.merge([
        viewModel.signIn,
        viewModel.signOut,
        viewModel.createUser,
      ]),
      builder: (_, _) {
        if (viewModel.signIn.running ||
            viewModel.signOut.running ||
            viewModel.createUser.running) {
          return const SizedBox();
        }
        return child;
      },
    );
  }
}
