import 'package:app/src/presentation/navigation/app_router.dart';
import 'package:app/src/presentation/navigation/app_routes.dart';
import 'package:app/src/presentation/ui/common/widgets/command_result_dialog.dart';
import 'package:app/src/presentation/ui/common/widgets/custom_loading_widget.dart';
import 'package:app/src/presentation/ui/shell/view_model/shell_view_model.dart';
import 'package:app/src/presentation/ui/shell/widgets/auth_dialog.dart';
import 'package:app/src/presentation/ui/shell/widgets/custom_navigation_bar.dart';
import 'package:app/src/presentation/ui/shell/widgets/navigation_bar_auth_button.dart';
import 'package:app/src/presentation/utils/window_utils.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ShellView extends StatelessWidget {
  const ShellView({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void showCommandResultDialog(
    BuildContext context,
    bool isError,
    AuthMessageType message,
  ) {
    showAdaptiveDialog(
      context: context,
      builder:
          (_) =>
              isError
                  ? CommandResultDialog.error(authMessageType: message)
                  : CommandResultDialog.success(authMessageType: message),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ShellViewModel>();

    void onSignIn() async {
      viewModel.handleAuthDialogResult(
        await showAdaptiveDialog<AuthDialogResult>(
          context: context,
          builder: (dialogContext) => SignInDialog(),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: ListenableBuilder(
          listenable: viewModel.dialogEventNotifier,
          builder: (context, child) {
            final dialogMessageType =
                viewModel.dialogEventNotifier.consumeEvent();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (dialogMessageType != null) {
                final isError = switch (dialogMessageType) {
                  AuthMessageType.signIn => false,
                  AuthMessageType.signOut => false,
                  AuthMessageType.createUser => false,
                };
                showCommandResultDialog(context, isError, dialogMessageType);
              }
            });
            return DefaultLoadingView(
              listenables: [
                viewModel.signIn,
                viewModel.createUser,
                viewModel.signOut,
              ],
              showLoading: viewModel.showLoading,
              loadingWidget: Center(child: CustomLoadingWidget()),
              child: Column(
                spacing: Dimensions.spacingMd,
                children: [
                  CustomNavigationBar(
                    navigationShell: navigationShell,
                    authButton: NavigationBarAuthButton(
                      onSignIn: onSignIn,
                      onSignOut: viewModel.signOut.execute,
                    ),
                  ),
                  Expanded(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 1500),
                      child: navigationShell,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar:
          WindowUtils.isDesktop(context)
              ? null
              : NavigationBar(
                labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                selectedIndex: navigationShell.currentIndex,
                onDestinationSelected: navigationShell.goBranch,
                destinations:
                    AppRouter.customShellBranches
                        .map(
                          (item) =>
                              item.appRoute.toNavigationDestination(context),
                        )
                        .toList(),
              ),
    );
  }
}
