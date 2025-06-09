import 'package:flutter/material.dart';
import 'package:internationalization/internationalization.dart';

enum AppRoute {
  home(path: '/home', icon: Icons.home),
  search(path: '/search', icon: Icons.search),
  reviews(path: '/reviews', icon: Icons.reviews),
  settings(path: '/settings', icon: Icons.settings),
  watchlist(path: '/watchlist', icon: Icons.bookmark),
  details(path: '/details', icon: Icons.movie_creation_outlined),
  login(path: '/login', icon: Icons.login);

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
      case AppRoute.reviews:
        return AppIntl.of(context).shell_reviews;
      case AppRoute.watchlist:
        return AppIntl.of(context).shell_watchlist;
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
