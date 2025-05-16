import 'dart:developer';

import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

class CarouselComponent extends WidgetbookComponent {
  CarouselComponent()
    : super(
        name: 'Carousel Slider',
        useCases: [
          WidgetbookUseCase(
            name: 'Carousel',
            builder: (context) {
              return Scaffold(
                appBar: AppBar(
                  centerTitle: false,
                  title: Text(
                    'Carousel Slider Component',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: Dimensions.spacingMd,
                          top: Dimensions.spacingMd,
                          bottom: Dimensions.spacingMd,
                        ),
                        child: Text(
                          'Popular Movies',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.spacingMd,
                        ),
                        child: SizedBox(
                          height: 350,
                          child: CarouselSlider(
                            useDynamicItemExtent: true,
                            controller: CarouselController(),
                            onTapItem: (index) => log('item tapped $index'),
                            children: List.generate(
                              20,
                              (index) => PosterCard(
                                posterUrl:
                                    'https://image.tmdb.org/t/p/w500/j8tqBXwH2PxBPzbtO19BTF9Ukbf.jpg',
                                infoWidget: TMDBInfoCard(
                                  title: 'Warfare Very Long Title',
                                  voteAverage: 7.1,
                                  releaseYear: '2023',
                                ),
                              ),
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
