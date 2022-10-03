part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  const SettingsState({
    required this.darkMode,
  });

  final bool darkMode;

  @override
  List<Object> get props => [
        darkMode,
      ];

  SettingsState copyWith({
    required bool darkMode,
  }) {
    return SettingsState(
      darkMode: darkMode,
    );
  }
}
