import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_good_practices/settings/domain/models/accessibility_settings.dart';
import 'package:flutter_good_practices/settings/domain/usecases/i_accessibility.dart';

part 'settings_event.dart';
part 'settings_state.dart';

@injectable
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc(this._accessibility)
      : super(
          const SettingsState(
            darkMode: false,
          ),
        ) {
    on<ChangeStyleEvent>(_onChangeStyleEvent);
    on<RequestAccessibilitySettings>(_onRequestAccessibilitySettings);
    on<SaveAccessibilitySettings>(_onSaveAccessibilitySettings);
  }
  final IAccessibility _accessibility;

  Future<FutureOr<void>> _onChangeStyleEvent(
    ChangeStyleEvent event,
    Emitter<SettingsState> emit,
  ) async {
    await _accessibility.save(
      AccessibilitySettings(
        darkMode: event.darkMode,
      ),
    );

    emit(
      state.copyWith(darkMode: event.darkMode),
    );
  }

  Future<void> _onRequestAccessibilitySettings(
    RequestAccessibilitySettings event,
    Emitter<SettingsState> emit,
  ) async {
    final accessibility = await _accessibility.get();
    emit(
      state.copyWith(
        darkMode: accessibility.darkMode,
      ),
    );
  }

  Future<FutureOr<void>> _onSaveAccessibilitySettings(
    SaveAccessibilitySettings event,
    Emitter<SettingsState> emit,
  ) async {
    await _accessibility.save(
      AccessibilitySettings(
        darkMode: state.darkMode,
      ),
    );
  }
}
