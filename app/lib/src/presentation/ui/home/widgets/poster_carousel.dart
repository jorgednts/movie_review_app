import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:internationalization/internationalization.dart';

class PosterCarousel<T> extends StatelessWidget {
  const PosterCarousel({
    super.key,
    required this.title,
    this.carouselHeight = 350,
    required this.command,
    required this.cardBuilder,
    required this.onTapItem,
    this.titleStyle,
  });

  final String title;
  final double carouselHeight;
  final Command0<List<T>> command;
  final PosterCard Function(T item) cardBuilder;
  final void Function(T item)? onTapItem;
  final TextStyle? titleStyle;

  double getDynamicItemExtent(double maxHeight) {
    final posterImageHeight = PosterCard.posterImageProportion * maxHeight;
    return posterImageHeight * (2 / 3);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: Dimensions.spacingSm,
      children: [
        StyledText.h3(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          isBold: true,
        ),
        SizedBox(
          height: carouselHeight,
          child: ListenableBuilder(
            listenable: command,
            builder: (_, child) {
              return LayoutBuilder(
                builder: (_, constraints) {
                  const itemsPadding = Dimensions.spacingSm;
                  final viewportDimension = constraints.maxWidth;
                  final itemExtent =
                      getDynamicItemExtent(constraints.maxHeight) +
                      itemsPadding;
                  switch (command.state) {
                    case CommandState.init:
                    case CommandState.loading:
                      return LoadingCarousel(
                        itemExtent: itemExtent,
                        viewportDimension: viewportDimension,
                        padding: itemsPadding,
                      );
                    case CommandState.error:
                      return Center(
                        child: RetryButtonCard(
                          message: AppIntl.of(context).msg_generic_error,
                          messagePadding: const EdgeInsets.all(
                            Dimensions.spacingMd,
                          ),
                          buttonText: AppIntl.of(context).common_try_again,
                          onPressed: command.execute,
                        ),
                      );
                    case CommandState.completed:
                      final result = command.result as Ok<List<T>>;
                      if (result.value.isEmpty) {
                        return EmptyCarousel(
                          itemExtent: itemExtent,
                          viewportDimension: viewportDimension,
                          padding: itemsPadding,
                          message: AppIntl.of(context).msg_empty_list,
                        );
                      }
                      return CarouselSlider(
                        itemExtent: itemExtent,
                        viewportDimension: viewportDimension,
                        padding: itemsPadding,
                        controller: CarouselController(),
                        onTapItem:
                            onTapItem == null
                                ? null
                                : (index) => onTapItem!(result.value[index]),
                        children:
                            result.value.map<PosterCard>(cardBuilder).toList(),
                      );
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
