import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';

import '../../domain/repositories/theme_mode_repository.dart';
import '../datasources/local/theme_mode_local_data_source.dart';

class ThemeRepositoryImpl implements ThemeModeRepository {
  final ThemeModeLocalDataSource localDataSource;

  ThemeRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, ThemeMode>> getThemeMode() async {
    try {
      final ThemeMode? themeMode = await localDataSource.getThemeMode();
      return Right(themeMode ?? ThemeMode.system);
    } catch (e) {
      return const Left(CacheFailure("failed to get themeMode"));
    }
  }

  @override
  Future<Either<Failure, void>> setThemeMode(ThemeMode mode) async {
    try {
      await localDataSource.setThemeMode(mode);
      return const Right(null);
    } catch (e) {
      return const Left(CacheFailure("Could not set ThemeMode"));
    }
  }
}
