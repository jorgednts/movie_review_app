import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class FiveStarsRating extends StatelessWidget {
  final double rating;
  final int maxRating;

  const FiveStarsRating({super.key, required this.rating, this.maxRating = 10})
    : assert(rating >= 0.0 && rating <= 10.0);

  IconData getStarIcon(int index, double rating) {
    final double stars = rating / 2;

    if (index < stars.floor()) {
      return Icons.star;
    } else if (index < stars && (stars - index) >= 0.25) {
      return Icons.star_half;
    } else {
      return Icons.star_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: Dimensions.spacingXs,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(5, (index) {
          return Flexible(
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Icon(
                getStarIcon(index, rating),
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
          );
        }),
        RichText(
          text: TextSpan(
            text: rating.toStringAsFixed(1),
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                text: '/$maxRating',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          maxLines: 1,
        ),
      ],
    );
  }
}
