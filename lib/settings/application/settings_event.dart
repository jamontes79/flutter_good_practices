part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
}

class ChangeStyleEvent extends SettingsEvent {
  const ChangeStyleEvent({required this.darkMode});
  final bool darkMode;
  @override
  List<Object?> get props => [darkMode];
}

class RequestAccessibilitySettings extends SettingsEvent {
  const RequestAccessibilitySettings();
  @override
  List<Object?> get props => [];
}

class SaveAccessibilitySettings extends SettingsEvent {
  const SaveAccessibilitySettings();
  @override
  List<Object?> get props => [];
}
