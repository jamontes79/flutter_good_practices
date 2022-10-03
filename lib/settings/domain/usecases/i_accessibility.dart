import 'package:dartz/dartz.dart';
import 'package:flutter_good_practices/settings/domain/models/accessibility_settings.dart';

abstract class IAccessibility {
  Future<bool> isDarkTheme();
  Future<AccessibilitySettings> get();
  Future<Unit> save(
    AccessibilitySettings accessibilitySettings,
  );
}
