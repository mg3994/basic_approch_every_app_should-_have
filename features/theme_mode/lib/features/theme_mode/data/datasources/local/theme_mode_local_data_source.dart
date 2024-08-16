import 'package:core/core.dart';

import 'package:flutter/material.dart';

abstract class ThemeModeLocalDataSource {
  Future<ThemeMode?> getThemeMode();
  Future<void> setThemeMode(ThemeMode themeMode);
}

class ThemeModeLocalDataSourceImpl implements ThemeModeLocalDataSource {
  final CacheManager _cacheManager;

  ThemeModeLocalDataSourceImpl(this._cacheManager);

  @override
  Future<ThemeMode?> getThemeMode() async {
    final int? themeIndex = _cacheManager.read(HiveKeys.themeModeKey);
    if (themeIndex != null) {
      return ThemeMode.values[themeIndex];
    }
    return null;
  }

  @override
  Future<void> setThemeMode(ThemeMode themeMode) async {
    await _cacheManager.write(HiveKeys.themeModeKey, themeMode.index);
  }
}
