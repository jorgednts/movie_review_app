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
              child: StyledText.t2(
                title,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                isBold: true,
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
                StyledText.b1(
                  voteAverage.toStringAsFixed(1),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  isBold: true,
                ),
                const Spacer(),
                StyledText.b2(
                  releaseYear,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  isItalic: true,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
