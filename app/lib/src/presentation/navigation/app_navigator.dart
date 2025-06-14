import 'package:app/src/domain/model/app_collection_item_model.dart';
import 'package:app/src/presentation/common/params/details_params.dart';
import 'package:app/src/presentation/navigation/app_routes.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

extension AppNavigator on BuildContext {
  void navigateToDetails(
    String id,
    AppCollectionItemType type,
    String storageId,
  ) {
    final user = read<UserStorageChangeNotifier>();
    pushNamed(
      AppRoute.details.name,
      pathParameters: {'itemId': id},
      queryParameters:
          DetailsParams(
            itemId: id,
            itemType: type,
            language: Localizations.localeOf(this).toLanguageTag(),
            uid: user.user?.uid,
            itemStorageId: storageId,
          ).toJson(),
    );
  }
}
