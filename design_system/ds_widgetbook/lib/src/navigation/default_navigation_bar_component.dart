import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:internationalization/internationalization.dart';
import 'package:widgetbook/widgetbook.dart';

class DefaultNavigationMenuComponent extends WidgetbookComponent {
  DefaultNavigationMenuComponent()
    : super(
        name: 'Default Navigation Menu',
        useCases: [
          WidgetbookUseCase(
            name: 'Default Navigation Menu',
            builder: (context) {
              int currDestination = 0;
              final destinations = [
                AppIntl.of(context).shell_home,
                AppIntl.of(context).shell_search,
                AppIntl.of(context).shell_reviews,
                AppIntl.of(context).shell_settings,
              ];
              return StatefulBuilder(
                builder: (context, setState) {
                  return DefaultNavigationBar(
                    leading: TextButton(
                      onPressed: () => setState(() => currDestination = 0),
                      style: ButtonStyle(
                        overlayColor: WidgetStateColor.transparent,
                      ),
                      child: Text(
                        AppIntl.of(context).app_name,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                    trailing: InkWell(
                      onTap: () {},
                      overlayColor: WidgetStateColor.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(
                            Dimensions.radiusMd,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          // vertical: Dimensions.spacingMd,
                          horizontal: Dimensions.spacingSm,
                        ),
                        child: Text(
                          'Sair',
                          style: Theme.of(
                            context,
                          ).textTheme.headlineSmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                      ),
                    ),
                    navigationMenu: DefaultNavigationMenu(
                      destinations: destinations,
                      currentIndex: currDestination,
                      onDestinationSelected: (index) {
                        setState(() => currDestination = index);
                      },
                    ),
                  );
                },
              );
            },
          ),
        ],
      );
}
