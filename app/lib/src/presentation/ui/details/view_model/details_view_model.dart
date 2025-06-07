import 'package:app/src/data/remote/model/base/base_details_request_parameters.dart';
import 'package:app/src/domain/model/base_tmdb_details_model.dart';
import 'package:app/src/domain/use_case/tmdb/get_tmdb_item_details_use_case.dart';
import 'package:app/src/presentation/common/params/details_params.dart';
import 'package:core/core.dart';
import 'package:flutter/foundation.dart';

class DetailsViewModel extends BaseViewModel {
  final DetailsParams _params;
  final GetTMDBItemDetailsUseCase _getTMDBItemDetailsUseCase;

  DetailsViewModel({
    required DetailsParams params,
    required GetTMDBItemDetailsUseCase getTMDBItemDetailsUseCase,
  }) : _params = params,
       _getTMDBItemDetailsUseCase = getTMDBItemDetailsUseCase;

  // Commands
  late Command0<void> getDetails;

  // Other Variables
  BaseTMDBDetailsModel? details;

  @override
  void onInit() {
    super.onInit();
    getDetails.execute();
  }

  @override
  void initCommands() {
    getDetails = Command0<void>(_getDetails);
  }

  AsyncResult _getDetails() async {
    return await callUseCase<
      BaseDetailsRequestParameters,
      BaseTMDBDetailsModel
    >(
      useCase: _getTMDBItemDetailsUseCase,
      input: BaseDetailsRequestParameters(
        uid: _params.itemId,
        type: _params.itemType,
        language: _params.language,
      ),
      onSuccess: (result) {
        details = result;
      },
      onError: (error) {
        debugPrint(error.toString());
      },
    );
  }
}
