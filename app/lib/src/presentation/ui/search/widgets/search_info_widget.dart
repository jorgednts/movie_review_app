import 'package:flutter/material.dart';
import 'package:internationalization/internationalization.dart';

class SearchInfoWidget extends StatelessWidget {
  final int currentItems;
  final int totalItems;

  const SearchInfoWidget({
    super.key,
    required this.currentItems,
    required this.totalItems,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          AppIntl.of(context).search_results,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Spacer(),
        Text(
          '$currentItems ${AppIntl.of(context).common_of} $totalItems ${AppIntl.of(context).common_items}',
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ],
    );
  }
}
