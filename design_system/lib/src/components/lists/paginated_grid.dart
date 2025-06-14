import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class PaginatedGrid extends StatefulWidget {
  final int itemCount;
  final Widget Function(int index) itemBuilder;
  final ScrollController scrollController;
  final Widget bottomLoadingWidget;
  final bool Function() showLoading;
  final void Function() onLoadMore;
  final bool Function() hasMoreItems;
  final bool Function() showRetry;
  final Widget retryWidget;

  const PaginatedGrid({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    required this.scrollController,
    required this.bottomLoadingWidget,
    required this.showLoading,
    required this.onLoadMore,
    required this.hasMoreItems,
    required this.showRetry,
    required this.retryWidget,
  });

  @override
  State<PaginatedGrid> createState() => _PaginatedGridState();
}

class _PaginatedGridState extends State<PaginatedGrid> {
  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    if (!widget.scrollController.hasClients || widget.showLoading()) return;

    final threshold = 100.0;
    final maxScroll = widget.scrollController.position.maxScrollExtent;
    final currentScroll = widget.scrollController.offset;

    if (currentScroll >= maxScroll - threshold) {
      widget.onLoadMore();
    }
  }

  double getMaxCrossAxisExtent(double maxWidth) {
    final result = maxWidth * (WindowUtils.isDesktop(context) ? 0.4 : 1);
    return result < 700 ? 700 : result;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder:
          (_, constraints) => Column(
            children: [
              Expanded(
                child: GridView.builder(
                  controller: widget.scrollController,
                  itemCount: widget.itemCount,
                  itemBuilder: (_, index) {
                    return widget.itemBuilder(index);
                  },
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: getMaxCrossAxisExtent(
                      constraints.maxWidth,
                    ),
                    mainAxisExtent: 250,
                    crossAxisSpacing: Dimensions.spacingMd,
                    mainAxisSpacing: Dimensions.spacingMd,
                  ),
                ),
              ),
              if (widget.showLoading()) widget.bottomLoadingWidget,
              if (widget.showRetry()) widget.retryWidget,
            ],
          ),
    );
  }
}
