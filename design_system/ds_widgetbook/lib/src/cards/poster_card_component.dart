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
                          infoWidget: TMDBInfoCard(
                            title: 'Warfare',
                            voteAverage: 7.1,
                            releaseYear: '2023',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 280,
                        width: 150,
                        child: PosterCard(
                          posterUrl:
                              'https://image.tmdb.org/t/p/w500/j8XwH2PxBPzbtO19BTF9Ukbf.jpg',
                          infoWidget: TMDBInfoCard(
                            title: 'Warfare',
                            voteAverage: 7.1,
                            releaseYear: '2023',
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
