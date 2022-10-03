import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_good_practices/settings/application/settings_bloc.dart';
import 'package:flutter_good_practices/settings/domain/models/accessibility_settings.dart';
import 'package:flutter_good_practices/settings/domain/usecases/i_accessibility.dart';
import 'package:mocktail/mocktail.dart';

class MockAccessibility extends Mock implements IAccessibility {}

void main() {
  late IAccessibility accessibility;
  late SettingsBloc accessibilityBloc;
  setUp(() {
    accessibility = MockAccessibility();
    accessibilityBloc = SettingsBloc(accessibility);
  });
  test('Initial state is correct', () {
    expect(
      accessibilityBloc.state,
      const SettingsState(
        darkMode: false,
      ),
    );
  });

  group('Change values', () {
    blocTest<SettingsBloc, SettingsState>(
      'Emits SettingsState with plain text when ChangeStyleEvent',
      build: () {
        when(
          () => accessibility.save(
            const AccessibilitySettings(
              darkMode: true,
            ),
          ),
        ).thenAnswer(
          (_) async => unit,
        );
        return accessibilityBloc;
      },
      act: (bloc) => bloc.add(
        const ChangeStyleEvent(darkMode: true),
      ),
      expect: () => <SettingsState>[
        const SettingsState(darkMode: true),
      ],
    );
  });

  group('Request values', () {
    blocTest<SettingsBloc, SettingsState>(
      'Emits SettingsState with values when '
      'RequestAccessibilitySettings correctly',
      build: () {
        when(
          () => accessibility.get(),
        ).thenAnswer(
          (_) async => const AccessibilitySettings(
            darkMode: true,
          ),
        );
        return accessibilityBloc;
      },
      act: (bloc) => bloc.add(
        const RequestAccessibilitySettings(),
      ),
      expect: () => <SettingsState>[
        const SettingsState(
          darkMode: true,
        ),
      ],
    );
  });

  group('Save values', () {
    blocTest<SettingsBloc, SettingsState>(
      'Call save with current state values',
      build: () {
        when(
          () => accessibility.save(
            const AccessibilitySettings(
              darkMode: true,
            ),
          ),
        ).thenAnswer(
          (_) async => unit,
        );
        return accessibilityBloc
          ..add(
            const ChangeStyleEvent(
              darkMode: true,
            ),
          );
      },
      act: (bloc) => bloc.add(
        const SaveAccessibilitySettings(),
      ),
      skip: 1,
      expect: () => <SettingsState>[],
      verify: (_) {
        verify(
          () => accessibility.save(
            const AccessibilitySettings(
              darkMode: true,
            ),
          ),
        ).called(2);
      },
    );
  });
  group('Events', () {
    test('ChangeStyleEvent is Equatable', () {
      const event = ChangeStyleEvent(darkMode: true);

      expect(
        event,
        isA<Equatable>(),
      );
      expect(
        event.props,
        [
          event.darkMode,
        ],
      );
    });
    test('RequestAccessibilitySettings is Equatable', () {
      const event = RequestAccessibilitySettings();

      expect(
        event,
        isA<Equatable>(),
      );
      expect(
        event.props,
        <Object?>[],
      );
    });
    test('SaveAccessibilitySettings', () {
      const event = SaveAccessibilitySettings();
      expect(
        event,
        isA<Equatable>(),
      );
      expect(
        event.props,
        <Object?>[],
      );
    });
  });
}
