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
                        height: 280,
                        width: 150,
                        child: PosterCard(
                          posterPath:
                              'https://image.tmdb.org/t/p/w500/j8tqBXwH2PxBPzbtO19BTF9Ukbf.jpg',
                          rating: 7.123,
                          infoWidget: Column(
                            children: [
                              Text(
                                'Warfare'.toUpperCase(),
                                style: Theme.of(context).textTheme.titleSmall
                                    ?.copyWith(fontWeight: FontWeight.w400),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 280,
                        width: 150,
                        child: PosterCard(
                          posterPath:
                              'https://image.tmdb.org/t/p/w500/j8XwH2PxBPzbtO19BTF9Ukbf.jpg',
                          rating: 7.123,
                          infoWidget: PosterCard(
                            posterPath:
                                'https://image.tmdb.org/t/p/w500/j8tqBXwH2PxBPzbtO19BTF9Ukbf.jpg',
                            rating: 7.123,
                            infoWidget: Column(
                              children: [
                                Text(
                                  'Untitled'.toUpperCase(),
                                  style: Theme.of(context).textTheme.titleSmall
                                      ?.copyWith(fontWeight: FontWeight.w400),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
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
