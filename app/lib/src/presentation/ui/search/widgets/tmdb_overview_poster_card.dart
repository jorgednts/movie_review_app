import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class TMDBOverviewPosterCard extends StatelessWidget {
  final String title;
  final String posterUrl;
  final double voteAverage;
  final String releaseYear;
  final String overview;
  final int? overviewLines;
  final void Function()? onTap;
  final Widget? bottomTrailing;

  const TMDBOverviewPosterCard({
    super.key,
    required this.title,
    required this.posterUrl,
    required this.voteAverage,
    required this.releaseYear,
    required this.overview,
    required this.onTap,
    this.overviewLines = 6,
    this.bottomTrailing,
  });

  @override
  Widget build(BuildContext context) {
    return ExpandedPosterCard(
      posterUrl: posterUrl,
      placeholder: const _PosterAspectRatio.placeholder(),
      errorWidget: const _PosterAspectRatio.error(),
      onTap: onTap,
      infoWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: Dimensions.spacingMd,
        children: [
          StyledText.t2(
            title,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            isBold: true,
          ),
          Expanded(
            child: StyledText.b2(
              overview,
              maxLines: overviewLines,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            spacing: Dimensions.spacingXs,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
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
                  ],
                ),
              ),
              bottomTrailing ??
                  Expanded(
                    child: StyledText.b2(
                      releaseYear,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                      isItalic: true,
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
  const _PosterAspectRatio.error()
    : child = const DefaultErrorWidget(),
      isError = true;

  const _PosterAspectRatio.placeholder()
    : child = const DefaultPlaceholder(),
      isError = false;

  final Widget child;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2 / 3,
      child:
          isError
              ? Container(
                color: Theme.of(context).colorScheme.surface,
                child: child,
              )
              : ShimmerLoading(
                child: Container(
                  color: Theme.of(context).colorScheme.surface,
                  child: child,
                ),
              ),
    );
  }
}
