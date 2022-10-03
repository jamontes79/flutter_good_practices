import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_good_practices/settings/domain/models/accessibility_settings.dart';
import 'package:flutter_good_practices/settings/infrastructure/accessibility_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late AccessibilityRepository accessibilityRepository;

  setUp(() {
    accessibilityRepository = AccessibilityRepository();
  });
  group('isDartTheme', () {
    test('isDarkTheme returns correct value', () async {
      SharedPreferences.setMockInitialValues({'dark_mode': true});

      final isDarkTheme = await accessibilityRepository.isDarkTheme();

      expect(isDarkTheme, true);
    });
  });
  group('save', () {
    test('save method returns unit', () async {
      SharedPreferences.setMockInitialValues({});

      final result = await accessibilityRepository.save(
        const AccessibilitySettings(
          darkMode: true,
        ),
      );

      expect(
        result,
        unit,
      );
    });
    test('save method store dark mode into sharedPreferences', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      await accessibilityRepository.save(
        const AccessibilitySettings(
          darkMode: true,
        ),
      );

      expect(
        prefs.containsKey('dark_mode'),
        true,
      );
      expect(
        prefs.getBool('dark_mode'),
        true,
      );
    });
  });
  group('Get', () {
    test(
        'when previous accessibility settings are '
        'saved correct object is returned', () async {
      SharedPreferences.setMockInitialValues({'dark_mode': true});

      final settings = await accessibilityRepository.get();

      expect(
        settings,
        const AccessibilitySettings(
          darkMode: true,
        ),
      );
    });
    test(
        'when no previous accessibility settings are '
        'saved default object is returned', () async {
      SharedPreferences.setMockInitialValues({});

      final settings = await accessibilityRepository.get();

      expect(
        settings,
        const AccessibilitySettings(),
      );
    });
  });
}
