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

  /// `Ciné`
  String get app_name {
    return Intl.message('Ciné', name: 'app_name', desc: '', args: []);
  }

  /// `Faça login para adicionar itens à sua lista`
  String get msg_watchlist_auth_needed {
    return Intl.message(
      'Faça login para adicionar itens à sua lista',
      name: 'msg_watchlist_auth_needed',
      desc: '',
      args: [],
    );
  }

  /// `Operação não concluída`
  String get msg_operation_not_completed {
    return Intl.message(
      'Operação não concluída',
      name: 'msg_operation_not_completed',
      desc: '',
      args: [],
    );
  }

  /// `Operação concluída`
  String get msg_operation_completed {
    return Intl.message(
      'Operação concluída',
      name: 'msg_operation_completed',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Parece que algo deu errado, mas não se preocupe! Você pode tentar novamente mais tarde.`
  String get msg_generic_error {
    return Intl.message(
      'Oops! Parece que algo deu errado, mas não se preocupe! Você pode tentar novamente mais tarde.',
      name: 'msg_generic_error',
      desc: '',
      args: [],
    );
  }

  /// `Falha ao buscar mais itens :(`
  String get msg_load_error {
    return Intl.message(
      'Falha ao buscar mais itens :(',
      name: 'msg_load_error',
      desc: '',
      args: [],
    );
  }

  /// `Nada para ver aqui...`
  String get msg_empty_list {
    return Intl.message(
      'Nada para ver aqui...',
      name: 'msg_empty_list',
      desc: '',
      args: [],
    );
  }

  /// `nome`
  String get common_name {
    return Intl.message('nome', name: 'common_name', desc: '', args: []);
  }

  /// `campo não pode estar vazio`
  String get common_empty_field {
    return Intl.message(
      'campo não pode estar vazio',
      name: 'common_empty_field',
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

  /// `Editar`
  String get common_edit {
    return Intl.message('Editar', name: 'common_edit', desc: '', args: []);
  }

  /// `Salvar`
  String get common_save {
    return Intl.message('Salvar', name: 'common_save', desc: '', args: []);
  }

  /// `Cancelar`
  String get common_cancel {
    return Intl.message('Cancelar', name: 'common_cancel', desc: '', args: []);
  }

  /// `Confirmar`
  String get common_confirm {
    return Intl.message(
      'Confirmar',
      name: 'common_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Confirmar Operação`
  String get common_confirm_operation {
    return Intl.message(
      'Confirmar Operação',
      name: 'common_confirm_operation',
      desc: '',
      args: [],
    );
  }

  /// `Tentar Novamente`
  String get common_try_again {
    return Intl.message(
      'Tentar Novamente',
      name: 'common_try_again',
      desc: '',
      args: [],
    );
  }

  /// `Recarregar`
  String get common_reload {
    return Intl.message(
      'Recarregar',
      name: 'common_reload',
      desc: '',
      args: [],
    );
  }

  /// `Este e-mail já está em uso.`
  String get auth_email_already_in_use {
    return Intl.message(
      'Este e-mail já está em uso.',
      name: 'auth_email_already_in_use',
      desc: '',
      args: [],
    );
  }

  /// `Sua senha é muito fraca.`
  String get auth_weak_password {
    return Intl.message(
      'Sua senha é muito fraca.',
      name: 'auth_weak_password',
      desc: '',
      args: [],
    );
  }

  /// `Por favor, insira um e-mail válido.`
  String get auth_invalid_email {
    return Intl.message(
      'Por favor, insira um e-mail válido.',
      name: 'auth_invalid_email',
      desc: '',
      args: [],
    );
  }

  /// `Esta conta foi desativada.`
  String get auth_user_disabled {
    return Intl.message(
      'Esta conta foi desativada.',
      name: 'auth_user_disabled',
      desc: '',
      args: [],
    );
  }

  /// `Nenhuma conta encontrada com este e-mail.`
  String get auth_user_not_found {
    return Intl.message(
      'Nenhuma conta encontrada com este e-mail.',
      name: 'auth_user_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Senha incorreta. Tente novamente.`
  String get auth_wrong_password {
    return Intl.message(
      'Senha incorreta. Tente novamente.',
      name: 'auth_wrong_password',
      desc: '',
      args: [],
    );
  }

  /// `Muitas tentativas. Tente novamente mais tarde.`
  String get auth_too_many_requests {
    return Intl.message(
      'Muitas tentativas. Tente novamente mais tarde.',
      name: 'auth_too_many_requests',
      desc: '',
      args: [],
    );
  }

  /// `Sua sessão expirou. Faça login novamente.`
  String get auth_user_token_expired {
    return Intl.message(
      'Sua sessão expirou. Faça login novamente.',
      name: 'auth_user_token_expired',
      desc: '',
      args: [],
    );
  }

  /// `Erro de rede. Verifique sua conexão com a internet.`
  String get auth_network_error {
    return Intl.message(
      'Erro de rede. Verifique sua conexão com a internet.',
      name: 'auth_network_error',
      desc: '',
      args: [],
    );
  }

  /// `Operação não permitida.`
  String get auth_operation_not_allowed {
    return Intl.message(
      'Operação não permitida.',
      name: 'auth_operation_not_allowed',
      desc: '',
      args: [],
    );
  }

  /// `Um erro desconhecido ocorreu. Tente novamente.`
  String get auth_unknown_error {
    return Intl.message(
      'Um erro desconhecido ocorreu. Tente novamente.',
      name: 'auth_unknown_error',
      desc: '',
      args: [],
    );
  }

  /// `Falha na autenticação. Tente novamente.`
  String get auth_generic_error {
    return Intl.message(
      'Falha na autenticação. Tente novamente.',
      name: 'auth_generic_error',
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

  /// `Apagar Conta`
  String get shell_delete_user {
    return Intl.message(
      'Apagar Conta',
      name: 'shell_delete_user',
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

  /// `Sucesso!`
  String get shell_success {
    return Intl.message('Sucesso!', name: 'shell_success', desc: '', args: []);
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

  /// `Conta apagada com sucesso!`
  String get shell_delete_user_success_message {
    return Intl.message(
      'Conta apagada com sucesso!',
      name: 'shell_delete_user_success_message',
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

  /// `Similares`
  String get details_similar {
    return Intl.message(
      'Similares',
      name: 'details_similar',
      desc: '',
      args: [],
    );
  }

  /// `Elenco`
  String get details_cast {
    return Intl.message('Elenco', name: 'details_cast', desc: '', args: []);
  }

  /// `ver mais`
  String get details_see_more {
    return Intl.message(
      'ver mais',
      name: 'details_see_more',
      desc: '',
      args: [],
    );
  }

  /// `ver menos`
  String get details_see_less {
    return Intl.message(
      'ver menos',
      name: 'details_see_less',
      desc: '',
      args: [],
    );
  }

  /// `Esse título parece adorar um mistério... Nenhuma sinopse disponível — talvez seja pra você assistir sem spoilers!`
  String get details_no_overview {
    return Intl.message(
      'Esse título parece adorar um mistério... Nenhuma sinopse disponível — talvez seja pra você assistir sem spoilers!',
      name: 'details_no_overview',
      desc: '',
      args: [],
    );
  }

  /// `Deseja remover este item da sua lista?`
  String get details_remove_watchlist {
    return Intl.message(
      'Deseja remover este item da sua lista?',
      name: 'details_remove_watchlist',
      desc: '',
      args: [],
    );
  }

  /// `Deseja remover a resenha deste item?`
  String get details_remove_review {
    return Intl.message(
      'Deseja remover a resenha deste item?',
      name: 'details_remove_review',
      desc: '',
      args: [],
    );
  }

  /// `Minha Resenha`
  String get reviews_my_review {
    return Intl.message(
      'Minha Resenha',
      name: 'reviews_my_review',
      desc: '',
      args: [],
    );
  }

  /// `Minha Resenhas`
  String get reviews_my_reviews {
    return Intl.message(
      'Minha Resenhas',
      name: 'reviews_my_reviews',
      desc: '',
      args: [],
    );
  }

  /// `Minha Avaliação`
  String get reviews_my_rating {
    return Intl.message(
      'Minha Avaliação',
      name: 'reviews_my_rating',
      desc: '',
      args: [],
    );
  }

  /// `Adicionar Resenha...`
  String get reviews_add_review {
    return Intl.message(
      'Adicionar Resenha...',
      name: 'reviews_add_review',
      desc: '',
      args: [],
    );
  }

  /// `Enviar Resenha`
  String get reviews_submit_review {
    return Intl.message(
      'Enviar Resenha',
      name: 'reviews_submit_review',
      desc: '',
      args: [],
    );
  }

  /// `Ops! Nenhuma resenha encontrada. Adicione sua primeira resenha agora!`
  String get reviews_empty_state {
    return Intl.message(
      'Ops! Nenhuma resenha encontrada. Adicione sua primeira resenha agora!',
      name: 'reviews_empty_state',
      desc: '',
      args: [],
    );
  }

  /// `Suas resenhas estão guardadas aqui!\nFaça login para visualizar e gerenciar suas anotações.`
  String get reviews_login_required_message {
    return Intl.message(
      'Suas resenhas estão guardadas aqui!\nFaça login para visualizar e gerenciar suas anotações.',
      name: 'reviews_login_required_message',
      desc: '',
      args: [],
    );
  }

  /// `Minha Lista`
  String get watchlist_my_watchlist {
    return Intl.message(
      'Minha Lista',
      name: 'watchlist_my_watchlist',
      desc: '',
      args: [],
    );
  }

  /// `Ops! Nenhum item encontrado na sua lista. Adicione alguns agora!`
  String get watchlist_empty_state {
    return Intl.message(
      'Ops! Nenhum item encontrado na sua lista. Adicione alguns agora!',
      name: 'watchlist_empty_state',
      desc: '',
      args: [],
    );
  }

  /// `Sua watchlist personalizada está te esperando!\nEntre com sua conta para acessar seus filmes e séries salvos.`
  String get watchlist_login_required_message {
    return Intl.message(
      'Sua watchlist personalizada está te esperando!\nEntre com sua conta para acessar seus filmes e séries salvos.',
      name: 'watchlist_login_required_message',
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
