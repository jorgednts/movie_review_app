import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class DefaultCollapsableAppBarView extends StatelessWidget {
  const DefaultCollapsableAppBarView({
    super.key,
    required this.expandedHeight,
    this.leading,
    this.titlePadding = const EdgeInsets.only(left: kToolbarHeight),
    required this.title,
    required this.appBarBackground,
    this.appBarBackgroundGradient,
    this.stretchModes = const [
      StretchMode.zoomBackground,
      StretchMode.blurBackground,
      StretchMode.fadeTitle,
    ],
    required this.body,
    required this.appBarSurfaceWidget,
  });

  final double expandedHeight;
  final Widget? leading;
  final EdgeInsets titlePadding;
  final String title;
  final Widget appBarBackground;
  final Gradient? appBarBackgroundGradient;
  final List<StretchMode> stretchModes;
  final Widget body;
  final Widget? appBarSurfaceWidget;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: expandedHeight,
          surfaceTintColor: Theme.of(context).colorScheme.surface,
          leading:
              leading ??
              BackButton(
                style: ButtonStyle(
                  shape: WidgetStatePropertyAll<OutlinedBorder>(CircleBorder()),
                  backgroundColor: WidgetStatePropertyAll<Color>(
                    Theme.of(
                      context,
                    ).colorScheme.surface.withValues(alpha: 0.5),
                  ),
                ),
              ),
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: Container(
            padding: EdgeInsets.symmetric(
              vertical: Dimensions.spacingXs,
              horizontal: Dimensions.spacingMd,
            ),
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.surface.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(Dimensions.radiusLg),
            ),
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              children: [
                Positioned.fill(child: appBarBackground),
                Positioned.fill(
                  bottom: -1,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient:
                          appBarBackgroundGradient ??
                          LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            stops: const [0.0, 0.5, 1.0],
                            colors: [
                              Theme.of(context).scaffoldBackgroundColor,
                              Theme.of(
                                context,
                              ).scaffoldBackgroundColor.withValues(alpha: 0.3),
                              Colors.transparent,
                            ],
                          ),
                    ),
                  ),
                ),
                Positioned.fill(
                  bottom: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(Dimensions.spacingMd),
                    child: appBarSurfaceWidget,
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: ColoredBox(
            color: Theme.of(context).colorScheme.surface,
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.spacingMd),
              child: body,
            ),
          ),
        ),
      ],
    );
  }
}
