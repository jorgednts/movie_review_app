import 'package:app/src/presentation/navigation/app_router.dart';
import 'package:app/src/presentation/navigation/app_routes.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:internationalization/internationalization.dart';

class ShellView extends StatelessWidget {
  const ShellView({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppIntl.of(context).app_name,
          style: Theme.of(
            context,
          ).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.spacingMd),
          child: navigationShell,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        currentIndex: navigationShell.currentIndex,

        onTap: (index) => navigationShell.goBranch(index),
        items:
            AppRouter.customShellBranches
                .map((item) => item.appRoute.toBottomNavigationBarItem(context))
                .toList(),
      ),
    );
  }
}
