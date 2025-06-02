import 'package:app/src/domain/use_case/app/get_theme_mode_local_use_case.dart';
import 'package:app/src/domain/use_case/app/set_theme_mode_local_use_case.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class CustomThemeNotifier extends ThemeNotifier {
  final GetThemeModeLocalUseCase _getThemeModeLocalUseCase;
  final SetThemeModeLocalUseCase _setThemeModeLocalUseCase;

  CustomThemeNotifier({
    required GetThemeModeLocalUseCase getThemeModeLocalUseCase,
    required SetThemeModeLocalUseCase setThemeModeLocalUseCase,
  }) : _getThemeModeLocalUseCase = getThemeModeLocalUseCase,
       _setThemeModeLocalUseCase = setThemeModeLocalUseCase {
    onInit();
  }

  void onInit() async {
    (await _getThemeModeLocalUseCase.call(NoParam())).fold(
      onOk: (result) {
        setThemeMode(result);
      },
      onError: (error) {},
    );
  }

  @override
  void toggleTheme() {
    super.toggleTheme();
    _setThemeModeLocalUseCase.call(themeMode == ThemeMode.dark);
  }
}
