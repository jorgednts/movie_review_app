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

  /// `nome`
  String get common_name {
    return Intl.message('nome', name: 'common_name', desc: '', args: []);
  }

  /// `nome não pode estar vazio`
  String get common_empty_name {
    return Intl.message(
      'nome não pode estar vazio',
      name: 'common_empty_name',
      desc: '',
      args: [],
    );
  }

  /// `filmes`
  String get common_movies {
    return Intl.message('filmes', name: 'common_movies', desc: '', args: []);
  }

  /// `séries`
  String get common_tv_series {
    return Intl.message('séries', name: 'common_tv_series', desc: '', args: []);
  }

  /// `de`
  String get common_of {
    return Intl.message('de', name: 'common_of', desc: '', args: []);
  }

  /// `página`
  String get common_page {
    return Intl.message('página', name: 'common_page', desc: '', args: []);
  }

  /// `itens`
  String get common_items {
    return Intl.message('itens', name: 'common_items', desc: '', args: []);
  }

  /// `item`
  String get common_item {
    return Intl.message('item', name: 'common_item', desc: '', args: []);
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

  /// `Minha Lista`
  String get shell_watchlist {
    return Intl.message(
      'Minha Lista',
      name: 'shell_watchlist',
      desc: '',
      args: [],
    );
  }

  /// `Sair`
  String get shell_sign_out {
    return Intl.message('Sair', name: 'shell_sign_out', desc: '', args: []);
  }

  /// `Entrar`
  String get shell_sign_in {
    return Intl.message('Entrar', name: 'shell_sign_in', desc: '', args: []);
  }

  /// `Criar Usuário`
  String get shell_create_user {
    return Intl.message(
      'Criar Usuário',
      name: 'shell_create_user',
      desc: '',
      args: [],
    );
  }

  /// `Criação de Conta`
  String get shell_create_user_title {
    return Intl.message(
      'Criação de Conta',
      name: 'shell_create_user_title',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get shell_sign_in_title {
    return Intl.message(
      'Login',
      name: 'shell_sign_in_title',
      desc: '',
      args: [],
    );
  }

  /// `Novo por aqui? Crie uma conta!`
  String get shell_create_user_message {
    return Intl.message(
      'Novo por aqui? Crie uma conta!',
      name: 'shell_create_user_message',
      desc: '',
      args: [],
    );
  }

  /// `Entre com sua conta Ciné!`
  String get shell_sign_in_message {
    return Intl.message(
      'Entre com sua conta Ciné!',
      name: 'shell_sign_in_message',
      desc: '',
      args: [],
    );
  }

  /// `e-mail`
  String get shell_email {
    return Intl.message('e-mail', name: 'shell_email', desc: '', args: []);
  }

  /// `senha`
  String get shell_password {
    return Intl.message('senha', name: 'shell_password', desc: '', args: []);
  }

  /// `e-mail não pode estar vazio`
  String get shell_email_empty_error {
    return Intl.message(
      'e-mail não pode estar vazio',
      name: 'shell_email_empty_error',
      desc: '',
      args: [],
    );
  }

  /// `insira um e-mail válido`
  String get shell_email_invalid_error {
    return Intl.message(
      'insira um e-mail válido',
      name: 'shell_email_invalid_error',
      desc: '',
      args: [],
    );
  }

  /// `senha não pode estar vazia`
  String get shell_password_empty_error {
    return Intl.message(
      'senha não pode estar vazia',
      name: 'shell_password_empty_error',
      desc: '',
      args: [],
    );
  }

  /// `senha deve ter no mínimo 6 caracteres`
  String get shell_password_short_error {
    return Intl.message(
      'senha deve ter no mínimo 6 caracteres',
      name: 'shell_password_short_error',
      desc: '',
      args: [],
    );
  }

  /// `ou`
  String get shell_or {
    return Intl.message('ou', name: 'shell_or', desc: '', args: []);
  }

  /// `Bem-vindo(a) de volta!`
  String get shell_welcome_back {
    return Intl.message(
      'Bem-vindo(a) de volta!',
      name: 'shell_welcome_back',
      desc: '',
      args: [],
    );
  }

  /// `Bem-vindo(a) ao Ciné!`
  String get shell_welcome {
    return Intl.message(
      'Bem-vindo(a) ao Ciné!',
      name: 'shell_welcome',
      desc: '',
      args: [],
    );
  }

  /// `Ops :(`
  String get shell_oops {
    return Intl.message('Ops :(', name: 'shell_oops', desc: '', args: []);
  }

  /// `Login realizado com sucesso!`
  String get shell_sign_in_success_message {
    return Intl.message(
      'Login realizado com sucesso!',
      name: 'shell_sign_in_success_message',
      desc: '',
      args: [],
    );
  }

  /// `Conta criada com sucesso!`
  String get shell_sign_up_success_message {
    return Intl.message(
      'Conta criada com sucesso!',
      name: 'shell_sign_up_success_message',
      desc: '',
      args: [],
    );
  }

  /// `Logout realizado com sucesso!`
  String get shell_sign_out_success_message {
    return Intl.message(
      'Logout realizado com sucesso!',
      name: 'shell_sign_out_success_message',
      desc: '',
      args: [],
    );
  }

  /// `Algo deu errado, por favor tente novamente mais tarde.`
  String get shell_error_message {
    return Intl.message(
      'Algo deu errado, por favor tente novamente mais tarde.',
      name: 'shell_error_message',
      desc: '',
      args: [],
    );
  }

  /// `Carregando...`
  String get shell_loading_message {
    return Intl.message(
      'Carregando...',
      name: 'shell_loading_message',
      desc: '',
      args: [],
    );
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

  /// `Ops! Nenhum resultado encontrado.`
  String get search_empty_state {
    return Intl.message(
      'Ops! Nenhum resultado encontrado.',
      name: 'search_empty_state',
      desc: '',
      args: [],
    );
  }

  /// `Que tal buscar por um filme ou série? Digite algo e descubra!`
  String get search_init_state {
    return Intl.message(
      'Que tal buscar por um filme ou série? Digite algo e descubra!',
      name: 'search_init_state',
      desc: '',
      args: [],
    );
  }

  /// `Ops! Algo deu errado com a sua busca. Por favor, tente novamente mais tarde.`
  String get search_error_state {
    return Intl.message(
      'Ops! Algo deu errado com a sua busca. Por favor, tente novamente mais tarde.',
      name: 'search_error_state',
      desc: '',
      args: [],
    );
  }

  /// `Resultados`
  String get search_results {
    return Intl.message(
      'Resultados',
      name: 'search_results',
      desc: '',
      args: [],
    );
  }

  /// `carregando mais resultados...`
  String get search_loading_more {
    return Intl.message(
      'carregando mais resultados...',
      name: 'search_loading_more',
      desc: '',
      args: [],
    );
  }

  /// `Sinopse`
  String get details_overview {
    return Intl.message(
      'Sinopse',
      name: 'details_overview',
      desc: '',
      args: [],
    );
  }

  /// `Adicionar à Minha Lista`
  String get details_add_watchlist {
    return Intl.message(
      'Adicionar à Minha Lista',
      name: 'details_add_watchlist',
      desc: '',
      args: [],
    );
  }

  /// `Adicionar Resenha`
  String get details_edit_review {
    return Intl.message(
      'Adicionar Resenha',
      name: 'details_edit_review',
      desc: '',
      args: [],
    );
  }

  /// `Visitar Website`
  String get details_visit_website {
    return Intl.message(
      'Visitar Website',
      name: 'details_visit_website',
      desc: '',
      args: [],
    );
  }

  /// `Média de Avaliações`
  String get details_rating {
    return Intl.message(
      'Média de Avaliações',
      name: 'details_rating',
      desc: '',
      args: [],
    );
  }

  /// `Temporadas`
  String get details_seasons {
    return Intl.message(
      'Temporadas',
      name: 'details_seasons',
      desc: '',
      args: [],
    );
  }

  /// `Temporada`
  String get details_season {
    return Intl.message(
      'Temporada',
      name: 'details_season',
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
