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
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.spacingMd,
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
                            onTapItem: (index) => print('item tapped $index'),
                            children: List.generate(
                              20,
                              (index) => PosterCard(
                                posterPath:
                                    'https://image.tmdb.org/t/p/w500/j8tqBXwH2PxBPzbtO19BTF9Ukbf.jpg',
                                rating: 7.123,
                                infoWidget: Column(
                                  children: [
                                    Text(
                                      'Warfaresadkldjsmf kjldfgriofjediofmsdlfkmd'
                                          .toUpperCase(),
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleSmall?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
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
