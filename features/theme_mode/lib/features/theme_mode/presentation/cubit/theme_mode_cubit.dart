import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';

import '../../domain/usecases/get_theme_mode_usecase.dart';
import '../../domain/usecases/set_theme_mode_usecase.dart';

part 'theme_mode_state.dart';

class ThemeModeCubit extends Cubit<ThemeMode> {
  final GetThemeModeUseCase getThemeModeUseCase;
  final SetThemeModeUseCase setThemeModeUseCase;
  ThemeModeCubit(this.getThemeModeUseCase, this.setThemeModeUseCase)
      : super(ThemeMode.system) {
    loadThemeMode();
  }
  void loadThemeMode() async {
    final Either<Failure, ThemeMode> result =
        await getThemeModeUseCase(const NoParams());

    result.fold(
      (failure) =>
          emit(ThemeMode.system), // Fallback to system if there's a failure
      (themeMode) => emit(themeMode),
    );
  }

  void updateThemeMode(ThemeMode mode) async {
    emit(mode);
    final Either<Failure, void> result = await setThemeModeUseCase(mode);

    result.fold(
      (failure) => emit(
          ThemeMode.system), // Handle failure by falling back to system mode
      (_) => {}, // Success; no action needed
    );
  }

  // void ifThemeModeSystemThenChangeThemeMode(Brightness brightness) async {
  //   final Either<Failure, ThemeMode> result =
  //       await getThemeModeUseCase(const NoParams());

  //   result.fold(
  //     (failure) =>
  //         emit(ThemeMode.system), // Fallback to system if there's a failure
  //     (themeMode) {
  //       if (themeMode == ThemeMode.system) {
  //         switch (brightness) {
  //           case Brightness.light:
  //             emit(ThemeMode.light);
  //             break;
  //           case Brightness.dark:
  //             emit(ThemeMode.dark);
  //             break;
  //           default:
  //             emit(ThemeMode.system);
  //         }
  //       }
  //     },
  //   );
  // }
}
  // int? sf = 0;
  // ifThemeModeSystemThenChangeThemeMode(Brightness brightness) {
  //   if ((brightness == Brightness.dark) && (sf == null || sf == 0)) {
  //     emit(ThemeMode.dark);
  //   } else {
  //     emit(ThemeMode.light);
  //   }
  // }

