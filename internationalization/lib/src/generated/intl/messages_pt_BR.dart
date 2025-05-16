// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pt_BR locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'pt_BR';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "app_name": MessageLookupByLibrary.simpleMessage("Movie Review App"),
    "home_popular_movies_title": MessageLookupByLibrary.simpleMessage(
      "Filmes Populares",
    ),
    "home_popular_tv_series_title": MessageLookupByLibrary.simpleMessage(
      "Séries de TV Populares",
    ),
    "home_top_rated_movies_title": MessageLookupByLibrary.simpleMessage(
      "Filmes Melhores Avaliados",
    ),
    "home_top_rated_tv_series_title": MessageLookupByLibrary.simpleMessage(
      "Séries de TV Melhores Avaliadas",
    ),
    "shell_home": MessageLookupByLibrary.simpleMessage("Home"),
    "shell_reviews": MessageLookupByLibrary.simpleMessage("Resenhas"),
    "shell_search": MessageLookupByLibrary.simpleMessage("Buscar"),
    "shell_settings": MessageLookupByLibrary.simpleMessage("Config."),
  };
}
