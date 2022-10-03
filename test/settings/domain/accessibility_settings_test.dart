import 'package:flutter_good_practices/settings/domain/models/accessibility_settings.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('AccessibilitySettings is Equatable', () {
    const accessibility = AccessibilitySettings();
    expect(
      accessibility.props,
      [
        accessibility.darkMode,
      ],
    );
  });

  test('AccessibilitySettings fromJson', () {
    const expected = AccessibilitySettings(
      darkMode: true,
    );
    final json = <String, dynamic>{
      'darkMode': true,
    };
    final actual = AccessibilitySettings.fromJson(json);
    expect(
      actual,
      expected,
    );
  });
}
