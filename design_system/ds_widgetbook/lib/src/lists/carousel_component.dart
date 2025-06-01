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
                          child: LayoutBuilder(
                            builder: (_, constraints) {
                              double getDynamicItemExtent(double maxHeight) {
                                final posterImageHeight =
                                    PosterCard.posterImageProportion *
                                    maxHeight;
                                return posterImageHeight * (2 / 3);
                              }

                              const itemsPadding = Dimensions.spacingSm;
                              final viewportDimension = constraints.maxWidth;
                              final itemExtent =
                                  getDynamicItemExtent(constraints.maxHeight) +
                                  itemsPadding;
                              return CarouselSlider(
                                itemExtent: itemExtent,
                                viewportDimension: viewportDimension,
                                padding: itemsPadding,
                                controller: CarouselController(),
                                onTapItem: (index) => log('item tapped $index'),
                                children: List.generate(
                                  20,
                                  (index) => PosterCard(
                                    posterUrl:
                                        'https://image.tmdb.org/t/p/w500/j8tqBXwH2PxBPzbtO19BTF9Ukbf.jpg',
                                    infoWidget: LayoutBuilder(
                                      builder: (_, constraints) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Warfare',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium
                                                    ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall
                                                      ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                                Spacer(),
                                                Text(
                                                  '2023',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                        fontStyle:
                                                            FontStyle.italic,
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
