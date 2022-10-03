import 'package:equatable/equatable.dart';

class AccessibilitySettings extends Equatable {
  const AccessibilitySettings({
    this.darkMode = false,
  });

  factory AccessibilitySettings.fromJson(Map<String, dynamic> json) {
    return AccessibilitySettings(
      darkMode: json['darkMode'] as bool,
    );
  }

  final bool darkMode;

  @override
  List<Object?> get props => [
        darkMode,
      ];
}
