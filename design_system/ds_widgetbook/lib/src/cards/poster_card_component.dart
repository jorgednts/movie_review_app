import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

class PosterCardComponent extends WidgetbookComponent {
  PosterCardComponent()
    : super(
        name: 'Poster Card',
        useCases: [
          WidgetbookUseCase(
            name: 'Poster',
            builder: (context) {
              return Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    spacing: Dimensions.spacingMd,
                    children: [
                      SizedBox(
                        height: 300,
                        width: 150,
                        child: PosterCard(
                          posterUrl:
                              'https://image.tmdb.org/t/p/w500/j8tqBXwH2PxBPzbtO19BTF9Ukbf.jpg',
                          infoWidget: LayoutBuilder(
                            builder: (_, constraints) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Warfare',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    spacing: Dimensions.spacingXs,
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.tertiary,
                                        size: Dimensions.iconSizeXs,
                                      ),
                                      Text(
                                        '7.8',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodySmall?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        '2023',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium?.copyWith(
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      );
}
