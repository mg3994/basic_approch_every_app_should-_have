import 'package:core/core.dart';

import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';

import '../repositories/theme_mode_repository.dart';

final class SetThemeModeUseCase implements UseCase<void, ThemeMode> {
  final ThemeModeRepository repository;

  SetThemeModeUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(ThemeMode mode) async {
    return await repository.setThemeMode(mode);
  }
}
