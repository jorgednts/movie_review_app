import 'package:app/src/presentation/utils/tmdb_paginated_list_notifier.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:internationalization/internationalization.dart';

class SearchInfoWidget<T> extends StatelessWidget {
  const SearchInfoWidget({super.key, required this.itemsListenable});

  final TMDBPaginatedListNotifier<T> itemsListenable;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: itemsListenable,
      builder: (_, child) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            StyledText.h1(AppIntl.of(context).search_results),
            const Spacer(),
            StyledText.l2(
              '${itemsListenable.items.length} ${AppIntl.of(context).common_of} ${itemsListenable.totalItems} ${AppIntl.of(context).common_items}',
            ),
          ],
        );
      },
    );
  }
}
