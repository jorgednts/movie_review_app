import 'package:design_system/design_system.dart';
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
        StyledText.h1(AppIntl.of(context).search_results),
        const Spacer(),
        StyledText.l2(
          '$currentItems ${AppIntl.of(context).common_of} $totalItems ${AppIntl.of(context).common_items}',
        ),
      ],
    );
  }
}
