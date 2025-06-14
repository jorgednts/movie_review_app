import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class LoadingGrid extends StatelessWidget {
  const LoadingGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return PaginatedGrid(
      itemCount: 5,
      hasMoreItems: () => false,
      scrollController: ScrollController(),
      bottomLoadingWidget: const SizedBox(),
      showLoading: () => false,
      onLoadMore: () => false,
      itemBuilder: (index) {
        return ShimmerLoading(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(Dimensions.radiusMd),
              ),
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
        );
      },
      showRetry: () => false,
      retryWidget: const SizedBox(),
    );
  }
}
