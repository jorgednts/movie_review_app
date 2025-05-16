import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class PosterCarousel<T> extends StatelessWidget {
  const PosterCarousel({
    super.key,
    required this.title,
    required this.items,
    this.carouselHeight = 350,
    required this.command,
    required this.cardBuilder,
  });

  final String title;
  final List<T> items;
  final double carouselHeight;
  final Command command;
  final PosterCard Function(T item) cardBuilder;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: Dimensions.spacingSm,
      children: [
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(
            context,
          ).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: carouselHeight,
          child: ListenableBuilder(
            listenable: command,
            builder: (_, child) {
              if (command.running) {
                return Center(child: CircularProgressIndicator());
              }
              return CarouselSlider(
                useDynamicItemExtent: true,
                controller: CarouselController(),
                children: items.map<PosterCard>(cardBuilder).toList(),
              );
            },
          ),
        ),
      ],
    );
  }
}
