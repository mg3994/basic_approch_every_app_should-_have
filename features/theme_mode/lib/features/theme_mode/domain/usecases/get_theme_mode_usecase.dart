import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';

import '../repositories/theme_mode_repository.dart';

final class GetThemeModeUseCase implements UseCase<ThemeMode, NoParams> {
  final ThemeModeRepository repository;

  GetThemeModeUseCase(this.repository);

  @override
  Future<Either<Failure, ThemeMode>> call(NoParams params) async {
    return await repository.getThemeMode();
  }
}
