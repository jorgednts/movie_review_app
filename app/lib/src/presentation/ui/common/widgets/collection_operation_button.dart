import 'package:app/src/domain/model/app_collection_model.dart';
import 'package:app/src/domain/model/base_tmdb_details_model.dart';
import 'package:app/src/domain/model/collection_item_model.dart';
import 'package:app/src/presentation/ui/common/widgets/review_bottom_sheet.dart';
import 'package:app/src/presentation/ui/details/data/operation_command_request.dart';
import 'package:app/src/presentation/ui/details/widgets/confirm_operation_dialog.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:internationalization/internationalization.dart';
import 'package:provider/provider.dart';

class CollectionOperationButton extends StatelessWidget {
  const CollectionOperationButton({
    super.key,
    required this.commandOperation,
    required this.collectionType,
    required this.item,
    required this.itemType,
    required this.messageEventNotifier,
  });

  final Command1<bool, OperationCommandRequest> commandOperation;
  final MessageEventNotifier<OperationMessageType> messageEventNotifier;
  final AppCollectionType collectionType;
  final BaseTMDBDetailsModel item;
  final AppCollectionItemType itemType;

  void handleOperation(String uid, OperationType operationType) async {
    AppCollectionItemModel? review;
    if (collectionType == AppCollectionType.review &&
        operationType == OperationType.add) {
      (await CustomModalNavigator.showCustomBottomSheet<
        AppCollectionItemModel?
      >(ReviewBottomSheet(details: item, type: itemType))).fold(
        onOk: (result) {
          review = result;
        },
        onError: (error) {},
      );
    }
    commandOperation.execute(
      OperationCommandRequest(
        operationType: operationType,
        crudItemRequest: CRUDItemRequest(
          uid: uid,
          collectionName: collectionType.name,
          collectionItemModel: item.toCollectionItem(
            itemType,
            review?.review,
            review?.voteAverage,
          ),
        ),
      ),
    );
  }

  void handleMessageEvents(BuildContext context) {
    final messageEventType = messageEventNotifier.consumeEvent();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (messageEventType != null) {
        switch (messageEventType) {
          case OperationMessageType.success:
            CustomScaffoldMessenger.showSuccessSnackBar(
              AppIntl.of(context).msg_operation_completed,
            );

          case OperationMessageType.error:
            CustomScaffoldMessenger.showErrorSnackBar(
              AppIntl.of(context).msg_operation_not_completed,
            );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserStorageChangeNotifier>().user;

    return ListenableBuilder(
      listenable: Listenable.merge([commandOperation, messageEventNotifier]),
      builder: (context, child) {
        handleMessageEvents(context);

        if (commandOperation.running) {
          return const CircularProgressIndicator();
        }
        bool? exists;

        commandOperation.result?.fold(
          onOk: (result) {
            exists = result;
          },
          onError: (error) {},
        );
        if (exists == null) {
          return const SizedBox();
        }
        return RoundedBorderButton(
          icon:
              collectionType == AppCollectionType.review
                  ? Icons.edit_note
                  : Icons.beenhere_outlined,
          onPressed: () async {
            switch (exists) {
              case null:
                commandOperation.execute(
                  OperationCommandRequest(operationType: OperationType.check),
                );
                break;
              case true:
                bool shouldProceed = false;
                (await CustomModalNavigator.showCustomAdaptiveDialog<bool>(
                  ConfirmOperationDialog(
                    message: switch (collectionType) {
                      AppCollectionType.review =>
                        AppIntl.of(context).details_remove_review,
                      AppCollectionType.watchlist =>
                        AppIntl.of(context).details_remove_watchlist,
                    },
                  ),
                )).fold(
                  onOk: (result) {
                    shouldProceed = result ?? false;
                  },
                  onError: (error) {},
                );
                if (shouldProceed) {
                  handleOperation(user!.uid, OperationType.remove);
                }
                break;
              case false:
                handleOperation(user!.uid, OperationType.add);
                break;
            }
          },
          tooltip: AppIntl.of(context).details_add_watchlist,
          badge: Icon(
            exists! ? Icons.remove_circle : Icons.add_circle,
            color: Theme.of(context).colorScheme.primary,
          ),
        );
      },
    );
  }
}
