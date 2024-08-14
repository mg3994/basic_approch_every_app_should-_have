import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart' as hive;
import 'package:flutter/material.dart';

abstract class ThemeModeLocalDataSource {
  Future<ThemeMode?> getThemeMode();
  Future<void> setThemeMode(ThemeMode themeMode);
}

class ThemeModeLocalDataSourceImpl implements ThemeModeLocalDataSource {
  final hive.Box box;

  ThemeModeLocalDataSourceImpl(this.box);

  @override
  Future<ThemeMode?> getThemeMode() async {
    final int? themeIndex = box.get(HiveKeys.themeMode);
    if (themeIndex != null) {
      return ThemeMode.values[themeIndex];
    }
    return null;
  }

  @override
  Future<void> setThemeMode(ThemeMode themeMode) async {
    await box.put(HiveKeys.themeMode, themeMode.index);
  }
}
