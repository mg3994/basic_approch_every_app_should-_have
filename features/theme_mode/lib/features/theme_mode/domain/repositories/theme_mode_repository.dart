import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';

abstract interface class ThemeModeRepository {
  Future<Either<Failure, ThemeMode>> getThemeMode();
  Future<Either<Failure, void>> setThemeMode(ThemeMode mode);
}
