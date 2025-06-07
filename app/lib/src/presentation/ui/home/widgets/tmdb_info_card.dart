import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class TMDBInfoCard extends StatelessWidget {
  const TMDBInfoCard({
    super.key,
    required this.title,
    required this.voteAverage,
    required this.releaseYear,
  });

  final String title;
  final double voteAverage;
  final String releaseYear;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              spacing: Dimensions.spacingXs,
              children: [
                Icon(
                  Icons.star,
                  color: Theme.of(context).colorScheme.tertiary,
                  size: Dimensions.iconSizeXs,
                ),
                Text(
                  voteAverage.toStringAsFixed(1),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Text(
                  releaseYear,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
