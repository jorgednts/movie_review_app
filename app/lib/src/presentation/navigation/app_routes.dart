import 'package:flutter/material.dart';
import 'package:internationalization/internationalization.dart';

enum AppRoute {
  home(path: '/', icon: Icons.home),
  search(path: '/search', icon: Icons.search),
  review(path: '/review', icon: Icons.reviews),
  settings(path: '/settings', icon: Icons.settings),
  details(path: '/details', icon: Icons.movie_creation_outlined);

  final String path;
  final IconData icon;

  const AppRoute({required this.path, required this.icon});
}

extension AppRouteExtension on AppRoute {
  String nameValue(BuildContext context) {
    switch (this) {
      case AppRoute.home:
        return AppIntl.of(context).shell_home;
      case AppRoute.search:
        return AppIntl.of(context).shell_search;
      case AppRoute.review:
        return AppIntl.of(context).shell_reviews;
      case AppRoute.settings:
        return AppIntl.of(context).shell_settings;
      default:
        throw UnimplementedError();
    }
  }

  BottomNavigationBarItem toBottomNavigationBarItem(BuildContext context) {
    return BottomNavigationBarItem(icon: Icon(icon), label: nameValue(context));
  }

  NavigationRailDestination toNavigationRailDestination(BuildContext context) {
    return NavigationRailDestination(
      icon: Icon(icon),
      label: Text(nameValue(context)),
    );
  }

  Widget toNavigationDestination(BuildContext context) {
    return NavigationDestination(icon: Icon(icon), label: nameValue(context));
  }
}
