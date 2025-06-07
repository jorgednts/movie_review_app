import 'package:design_system/design_system.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CarouselSlider extends StatefulWidget {
  const CarouselSlider({
    super.key,
    required this.itemExtent,
    required this.children,
    required this.controller,
    this.onTapItem,
    this.minItemExtent = 120,
    required this.padding,
    required this.viewportDimension,
  });

  final List<Widget> children;
  final double itemExtent;
  final CarouselController controller;
  final void Function(int index)? onTapItem;
  final double minItemExtent;
  final double viewportDimension;
  final double padding;

  @override
  State<CarouselSlider> createState() => _CarouselSliderState();
}

class _CarouselSliderState extends State<CarouselSlider> {
  /// [currentIndex] is the index of the first visible item.
  /// [currentPage] is the current visible page in the viewport.
  /// [totalPages] is the total number of pages to navigate via arrow.
  /// [itemsPerPage] is the number of items per page.
  int currentPage = 0;
  int currentIndex = 0;
  late int totalPages, itemsPerPage;

  double getDynamicItemExtent(double maxHeight) {
    final posterImageHeight = PosterCard.posterImageProportion * maxHeight;
    return posterImageHeight * (2 / 3);
  }

  @override
  void initState() {
    super.initState();
    initValues();
  }

  @override
  void didUpdateWidget(covariant CarouselSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.viewportDimension != widget.viewportDimension) {
      initValues();
      setState(() {
        currentPage = 0;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          widget.controller.jumpTo(0);
        });
      });
    }
  }

  void initValues() {
    itemsPerPage = (widget.viewportDimension / widget.itemExtent).truncate();
    totalPages =
        (widget.children.length * widget.itemExtent / widget.viewportDimension)
            .ceil();
  }

  void onPressedArrow(int newPage) {
    if (newPage > totalPages - 1) {
      return;
    }
    final nextVisibleItem = getNextVisibleItem(newPage);
    setState(() {
      currentPage = newPage;
    });

    widget.controller.animateToItem(nextVisibleItem);
  }

  int getNextVisibleItem(int newPage) {
    if (newPage < totalPages - 1) {
      return newPage * itemsPerPage;
    }
    return widget.children.length - (widget.children.length % itemsPerPage);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            CarouselView(
              padding: EdgeInsets.only(right: widget.padding),
              enableSplash: widget.onTapItem != null,
              itemExtent: widget.itemExtent,
              controller: widget.controller,
              onTap: widget.onTapItem,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimensions.radiusMd),
              ),
              shrinkExtent: widget.minItemExtent,
              children: widget.children,
            ),
            if (kIsWeb) ...[
              if (currentPage > 0)
                _ArrowWidget.left(
                  onPressedArrow: () => onPressedArrow(currentPage - 1),
                ),
              if (currentPage < totalPages - 1)
                _ArrowWidget.right(
                  onPressedArrow: () => onPressedArrow(currentPage + 1),
                ),
            ],
          ],
        );
      },
    );
  }
}

class _ArrowWidget extends StatelessWidget {
  const _ArrowWidget.left({required this.onPressedArrow}) : isLeft = true;

  const _ArrowWidget.right({required this.onPressedArrow}) : isLeft = false;

  final void Function() onPressedArrow;
  final bool isLeft;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isLeft ? Alignment.centerLeft : Alignment.centerRight,
      child: IconButton(
        onPressed: onPressedArrow,
        icon: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(Dimensions.spacingSm),
          child: Icon(
            isLeft ? Icons.chevron_left_outlined : Icons.chevron_right_outlined,
            color: Theme.of(context).colorScheme.onSecondaryContainer,
          ),
        ),
      ),
    );
  }
}
