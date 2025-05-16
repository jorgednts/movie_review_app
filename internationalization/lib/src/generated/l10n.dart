// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class AppIntl {
  AppIntl();

  static AppIntl? _current;

  static AppIntl get current {
    assert(
      _current != null,
      'No instance of AppIntl was loaded. Try to initialize the AppIntl delegate before accessing AppIntl.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<AppIntl> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = AppIntl();
      AppIntl._current = instance;

      return instance;
    });
  }

  static AppIntl of(BuildContext context) {
    final instance = AppIntl.maybeOf(context);
    assert(
      instance != null,
      'No instance of AppIntl present in the widget tree. Did you add AppIntl.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static AppIntl? maybeOf(BuildContext context) {
    return Localizations.of<AppIntl>(context, AppIntl);
  }

  /// `Movie Review App`
  String get app_name {
    return Intl.message(
      'Movie Review App',
      name: 'app_name',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get shell_home {
    return Intl.message('Home', name: 'shell_home', desc: '', args: []);
  }

  /// `Buscar`
  String get shell_search {
    return Intl.message('Buscar', name: 'shell_search', desc: '', args: []);
  }

  /// `Resenhas`
  String get shell_reviews {
    return Intl.message('Resenhas', name: 'shell_reviews', desc: '', args: []);
  }

  /// `Config.`
  String get shell_settings {
    return Intl.message('Config.', name: 'shell_settings', desc: '', args: []);
  }

  /// `Filmes Populares`
  String get home_popular_movies_title {
    return Intl.message(
      'Filmes Populares',
      name: 'home_popular_movies_title',
      desc: '',
      args: [],
    );
  }

  /// `Séries de TV Populares`
  String get home_popular_tv_series_title {
    return Intl.message(
      'Séries de TV Populares',
      name: 'home_popular_tv_series_title',
      desc: '',
      args: [],
    );
  }

  /// `Filmes Melhores Avaliados`
  String get home_top_rated_movies_title {
    return Intl.message(
      'Filmes Melhores Avaliados',
      name: 'home_top_rated_movies_title',
      desc: '',
      args: [],
    );
  }

  /// `Séries de TV Melhores Avaliadas`
  String get home_top_rated_tv_series_title {
    return Intl.message(
      'Séries de TV Melhores Avaliadas',
      name: 'home_top_rated_tv_series_title',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppIntl> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'pt', countryCode: 'BR'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppIntl> load(Locale locale) => AppIntl.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
