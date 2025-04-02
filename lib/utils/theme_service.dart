import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app_theme.dart';

AppTheme appTheme = Get.isDarkMode
    ? AppTheme.fromType(ThemeType.dark)
    : AppTheme.fromType(ThemeType.light);

class ThemeService {
  final _getStorage = GetStorage();
  final _storageKey = "isDarkMode";

  /// Get isDarkMode info from local storage and return ThemeMode
  ThemeMode get theme =>
      _loadThemeFromStorage() ? ThemeMode.dark : ThemeMode.light;

  /// Load isDArkMode from local storage and if it's empty, returns false (that means default theme is light)
  bool _loadThemeFromStorage() => _getStorage.read(_storageKey) ?? false;

  /// Save isDarkMode to local storage
  _saveThemeToStorage(bool isDarkMode) =>
      _getStorage.write(_storageKey, isDarkMode);

  /// Switch theme and save to local storage
  switchTheme() async {
    bool loadThemeFromStorage = _loadThemeFromStorage()?false:true;
    log("loadThemeFromStorage :%$loadThemeFromStorage");
    if (loadThemeFromStorage) {
      Get.changeThemeMode(ThemeMode.dark);
      await updateTheme(AppTheme.fromType(ThemeType.dark));
      _saveThemeToStorage(true);

      Get.forceAppUpdate();
    } else {
      Get.changeThemeMode(ThemeMode.light);
      await updateTheme(AppTheme.fromType(ThemeType.light));
      _saveThemeToStorage(false);

      Get.forceAppUpdate();
    }
  }

  updateTheme(theme) {
    appTheme = theme;
    Get.forceAppUpdate();
  }
}
