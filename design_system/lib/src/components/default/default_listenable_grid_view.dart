import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class DefaultListenableGridView<T, M> extends StatelessWidget {
  const DefaultListenableGridView({
    super.key,
    required this.fetchList,
    this.initStateWidget,
    this.loadingStateWidget,
    required this.errorStateWidget,
    required this.emptyStateWidget,
    required this.itemBuilder,
    required this.titleWidget,
    this.listWidget,
    required this.handleMessageEvent,
    required this.userProvider,
    required this.messageEventNotifier,
    required this.noUserWidget,
  });

  final Command fetchList;
  final UserStorageChangeNotifier userProvider;
  final MessageEventNotifier<M> messageEventNotifier;
  final Widget? initStateWidget;
  final Widget? loadingStateWidget;
  final Widget errorStateWidget;
  final Widget emptyStateWidget;
  final Widget noUserWidget;
  final Widget titleWidget;
  final Widget Function(T item) itemBuilder;
  final Widget? listWidget;
  final void Function() handleMessageEvent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.spacingMd),
      child: ListenableBuilder(
        listenable: Listenable.merge([
          userProvider,
          messageEventNotifier,
          fetchList,
        ]),
        builder: (context, child) {
          handleMessageEvent();
          if (userProvider.user == null) {
            return noUserWidget;
          }
          List<Widget> children = [titleWidget];
          switch (fetchList.state) {
            case CommandState.init:
              children.add(
                Expanded(child: initStateWidget ?? const LoadingGrid()),
              );
            case CommandState.loading:
              children.add(
                Expanded(child: loadingStateWidget ?? const LoadingGrid()),
              );
            case CommandState.error:
              children.add(errorStateWidget);
            case CommandState.completed:
              final result = fetchList.result as Ok<List<T>>;
              children.add(
                Expanded(
                  child:
                      result.value.isEmpty
                          ? emptyStateWidget
                          : listWidget ??
                              PaginatedGrid(
                                itemCount: result.value.length,
                                itemBuilder: (index) {
                                  final item = result.value[index];
                                  return itemBuilder(item);
                                },
                                scrollController: ScrollController(),
                                bottomLoadingWidget: const SizedBox(),
                                showLoading: () => false,
                                onLoadMore: () => false,
                                hasMoreItems: () => false,
                                showRetry: () => false,
                                retryWidget: const SizedBox(),
                              ),
                ),
              );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: Dimensions.spacingMd,
            children: children,
          );
        },
      ),
    );
  }
}
