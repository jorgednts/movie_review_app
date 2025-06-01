import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:internationalization/internationalization.dart';

enum SearchState { error, empty, init }

class SearchStateStackedIconCard extends StatelessWidget {
  final SearchState state;

  const SearchStateStackedIconCard.error({super.key})
    : state = SearchState.error;

  const SearchStateStackedIconCard.empty({super.key})
    : state = SearchState.empty;

  const SearchStateStackedIconCard.init({super.key}) : state = SearchState.init;

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case SearchState.error:
        return StackedIconCard(
          message: AppIntl.of(context).search_error_state,
          icon: Icons.feedback_outlined,
          messageCardColor: Theme.of(context).colorScheme.errorContainer,
          iconCardColor: Theme.of(context).colorScheme.error,
          iconColor: Theme.of(context).colorScheme.onError,
          messageStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onErrorContainer,
          ),
        );
      case SearchState.empty:
        return StackedIconCard(
          message: AppIntl.of(context).search_empty_state,
          constraints: BoxConstraints(maxWidth: 250),
          icon: Icons.search_off,
        );
      case SearchState.init:
        return StackedIconCard(message: AppIntl.of(context).search_init_state);
    }
  }
}
