import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class TMDBOverviewPosterCard extends StatelessWidget {
  final String title;
  final String posterUrl;
  final double voteAverage;
  final String releaseYear;
  final String overview;

  const TMDBOverviewPosterCard({
    super.key,
    required this.title,
    required this.posterUrl,
    required this.voteAverage,
    required this.releaseYear,
    required this.overview,
  });

  @override
  Widget build(BuildContext context) {
    return ExpandedPosterCard(
      posterUrl: posterUrl,
      placeholder: _PosterAspectRatio.placeholder(),
      errorWidget: _PosterAspectRatio.error(),
      infoWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: Dimensions.spacingMd,
        children: [
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              overview,
              maxLines: 6,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Row(
            spacing: Dimensions.spacingXs,
            mainAxisSize: MainAxisSize.min,
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
              Expanded(
                child: Text(
                  releaseYear,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PosterAspectRatio extends StatelessWidget {
  const _PosterAspectRatio.error() : child = const DefaultErrorWidget();

  const _PosterAspectRatio.placeholder() : child = const DefaultPlaceholder();

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2 / 3,
      child: Container(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        child: child,
      ),
    );
  }
}
