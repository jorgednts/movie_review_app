import 'package:app/src/presentation/navigation/app_router.dart';
import 'package:app/src/presentation/navigation/app_routes.dart';
import 'package:app/src/presentation/ui/common/widgets/app_logo_widget.dart';
import 'package:app/src/presentation/ui/common/widgets/command_result_dialog.dart';
import 'package:app/src/presentation/ui/common/widgets/custom_loading_widget.dart';
import 'package:app/src/presentation/ui/shell/view_model/shell_view_model.dart';
import 'package:app/src/presentation/ui/shell/widgets/app_bar_auth_button.dart';
import 'package:app/src/presentation/ui/shell/widgets/auth_dialog.dart';
import 'package:app/src/presentation/ui/shell/widgets/custom_navigation_bar.dart';
import 'package:app/src/presentation/utils/window_utils.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:internationalization/internationalization.dart';
import 'package:provider/provider.dart';

class ShellView extends StatelessWidget {
  const ShellView({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void showCommandResultDialog(
    BuildContext context,
    bool isError,
    MessageType message,
  ) {
    showAdaptiveDialog(
      context: context,
      builder:
          (_) =>
              isError
                  ? CommandResultDialog.error(
                    titleMessage: getDialogTitleMessage(context, true, message),
                    subtitleMessage: getDialogSubtitleMessage(
                      context,
                      true,
                      message,
                    ),
                  )
                  : CommandResultDialog.success(
                    titleMessage: getDialogTitleMessage(
                      context,
                      isError,
                      message,
                    ),
                    subtitleMessage: getDialogSubtitleMessage(
                      context,
                      isError,
                      message,
                    ),
                  ),
    );
  }

  String? getDialogTitleMessage(
    BuildContext context,
    bool isError,
    MessageType resultMessageType,
  ) {
    if (isError) {
      return AppIntl.of(context).shell_oops;
    }
    switch (resultMessageType) {
      case MessageType.signIn:
        return AppIntl.of(context).shell_welcome_back;
      case MessageType.signOut:
        return null;
      case MessageType.createUser:
        return AppIntl.of(context).shell_welcome;
    }
  }

  String getDialogSubtitleMessage(
    BuildContext context,
    bool isError,
    MessageType resultMessageType,
  ) {
    if (isError) {
      return AppIntl.of(context).shell_error_message;
    }
    switch (resultMessageType) {
      case MessageType.signIn:
        return AppIntl.of(context).shell_sign_in_success_message;
      case MessageType.signOut:
        return AppIntl.of(context).shell_sign_out_success_message;
      case MessageType.createUser:
        return AppIntl.of(context).shell_sign_up_success_message;
    }
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
      appBar:
          WindowUtils.isDesktop(context)
              ? null
              : AppBar(
                title: AppLogoWidget(),
                actionsPadding: EdgeInsets.symmetric(
                  vertical: Dimensions.spacingXs,
                  horizontal: Dimensions.spacingMd,
                ),
                actions: [
                  AppBarAuthButton(
                    userValueNotifier: viewModel.user,
                    onSignIn: onSignIn,
                    onSignOut: viewModel.signOut.execute,
                    checkUserLoggedCommand: viewModel.checkUserLogged,
                  ),
                ],
              ),
      body: SafeArea(
        child: DefaultLoadingView(
          listenables: [
            viewModel.signIn,
            viewModel.createUser,
            viewModel.signOut,
          ],
          loadingWidget: Center(child: CustomLoadingWidget()),
          onError: () {
            showCommandResultDialog(context, true, viewModel.resultMessageType);
          },
          onSuccess: () {
            showCommandResultDialog(
              context,
              false,
              viewModel.resultMessageType,
            );
          },
          child: Column(
            children: [
              if (WindowUtils.isDesktop(context))
                CustomNavigationBar(
                  navigationShell: navigationShell,
                  userModelListenable: viewModel.user,
                  onSignIn: onSignIn,
                  onSignOut: viewModel.signOut.execute,
                  checkUserLoggedCommand: viewModel.checkUserLogged,
                ),
              Expanded(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 1500),
                  child: navigationShell,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar:
          WindowUtils.isDesktop(context)
              ? null
              : NavigationBar(
                labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
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
