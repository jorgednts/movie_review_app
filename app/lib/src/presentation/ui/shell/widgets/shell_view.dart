import 'package:app/src/presentation/navigation/app_routes.dart';
import 'package:app/src/presentation/ui/common/widgets/command_result_dialog.dart';
import 'package:app/src/presentation/ui/common/widgets/custom_loading_widget.dart';
import 'package:app/src/presentation/ui/shell/dependency/shell_dependency.dart';
import 'package:app/src/presentation/ui/shell/view_model/shell_view_model.dart';
import 'package:app/src/presentation/ui/shell/widgets/auth_dialog.dart';
import 'package:app/src/presentation/ui/shell/widgets/custom_navigation_bar.dart';
import 'package:app/src/presentation/ui/shell/widgets/navigation_bar_auth_button.dart';
import 'package:core/core.dart';
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
    CustomModalNavigator.showCustomAdaptiveDialog(
      isError
          ? CommandResultDialog.error(authMessageType: message)
          : CommandResultDialog.success(authMessageType: message),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ShellViewModel>();

    void onSignIn() async {
      (await CustomModalNavigator.showCustomAdaptiveDialog<AuthDialogResult>(
        const SignInDialog(),
      )).fold(
        onOk: (result) {
          viewModel.handleAuthDialogResult(result);
        },
        onError: (error) {},
      );
    }

    return Scaffold(
      body: SafeArea(
        child: ListenableBuilder(
          listenable: viewModel.dialogEventNotifier,
          builder: (context, child) {
            final messageEventType =
                viewModel.dialogEventNotifier.consumeEvent();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (messageEventType != null) {
                final isError = switch (messageEventType) {
                  AuthMessageType.signIn => false,
                  AuthMessageType.signOut => false,
                  AuthMessageType.createUser => false,
                };
                showCommandResultDialog(context, isError, messageEventType);
              }
            });
            return DefaultLoadingView(
              listenables: [
                viewModel.signIn,
                viewModel.createUser,
                viewModel.signOut,
              ],
              showLoading: viewModel.showLoading,
              loadingWidget: const Center(child: CustomLoadingWidget()),
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
                      constraints: const BoxConstraints(maxWidth: 1500),
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
                    ShellDependency.customShellBranches
                        .map(
                          (item) =>
                              item.appRoute.toNavigationDestination(context),
                        )
                        .toList(),
              ),
    );
  }
}
