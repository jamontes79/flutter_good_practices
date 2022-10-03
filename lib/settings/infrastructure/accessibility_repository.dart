import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_good_practices/settings/domain/models/accessibility_settings.dart';
import 'package:flutter_good_practices/settings/domain/usecases/i_accessibility.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(
  as: IAccessibility,
)
class AccessibilityRepository implements IAccessibility {
  AccessibilityRepository();

  @override
  Future<AccessibilitySettings> get() async {
    final prefs = await SharedPreferences.getInstance();
    final darkMode = prefs.getBool('dark_mode') ?? false;

    return AccessibilitySettings(darkMode: darkMode);
  }

  @override
  Future<Unit> save(
    AccessibilitySettings accessibilitySettings,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('dark_mode', accessibilitySettings.darkMode);

    return unit;
  }

  @override
  Future<bool> isDarkTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('dark_mode') ?? false;
  }
}
