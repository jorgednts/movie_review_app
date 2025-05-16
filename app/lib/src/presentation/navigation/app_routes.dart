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
  BottomNavigationBarItem toBottomNavigationBarItem(BuildContext context) {
    final name = switch (this) {
      AppRoute.home => AppIntl.of(context).shell_home,
      AppRoute.search => AppIntl.of(context).shell_search,
      AppRoute.review => AppIntl.of(context).shell_reviews,
      AppRoute.settings => AppIntl.of(context).shell_settings,
      AppRoute.details => throw UnimplementedError(),
    };
    return BottomNavigationBarItem(icon: Icon(icon), label: name);
  }
}
