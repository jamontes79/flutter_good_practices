import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_good_practices/injection/injection.dart';
import 'package:flutter_good_practices/settings/application/settings_bloc.dart';
import 'package:flutter_good_practices/settings/presentation/settings_dialog.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

class MockAccessibilityBloc extends MockBloc<SettingsEvent, SettingsState>
    implements SettingsBloc {}

void main() {
  late SettingsBloc bloc;
  setUpAll(() async {
    configureInjection(Environment.test);
    WidgetController.hitTestWarningShouldBeFatal = true;
    WidgetsFlutterBinding.ensureInitialized();
  });
  tearDown(getIt.reset);
  setUp(() {
    bloc = MockAccessibilityBloc();
    when(() => bloc.state).thenReturn(
      const SettingsState(
        darkMode: false,
      ),
    );
  });

  const darkmodeSwitchKey = Key('accessibility_dialog_darkmode_switch');

  const closeButtonKey = Key('accessibility_dialog_close_button');

  group('Rendering Settings Dialog', () {
    const titleKey = Key('accessibility_dialog_title');

    const closeButtonIconKey = Key('accessibility_dialog_close_icon');

    const darkModeTextKey = Key('accessibility_dialog_darkmode_text');

    testWidgets('Display correct title', (tester) async {
      await tester.pumpApp(
        BlocProvider.value(
          value: bloc,
          child: const SettingsDialog(),
        ),
      );

      expect(
        find.byKey(
          titleKey,
        ),
        findsOneWidget,
      );
      final widgetTesting = tester.widget(
        find.byKey(
          titleKey,
        ),
      );
      expect(
        widgetTesting,
        isA<Text>(),
      );
      expect(
        (widgetTesting as Text).data,
        'Settings',
      );
    });
    testWidgets('Display correct close button', (tester) async {
      await tester.pumpApp(
        BlocProvider.value(
          value: bloc,
          child: const SettingsDialog(),
        ),
      );

      expect(
        find.byKey(
          closeButtonKey,
        ),
        findsOneWidget,
      );

      final closeButtonIcon = tester.widget(
        find.byKey(
          closeButtonIconKey,
        ),
      );
      expect(
        closeButtonIcon,
        isA<Icon>(),
      );

      expect(
        (closeButtonIcon as Icon).icon,
        Icons.clear,
      );
    });

    testWidgets('Display correct darkmode option', (tester) async {
      await tester.pumpApp(
        BlocProvider.value(
          value: bloc,
          child: const SettingsDialog(),
        ),
      );

      final darkmode = tester.widget(
        find.byKey(
          darkModeTextKey,
        ),
      );
      expect(
        darkmode,
        isA<Text>(),
      );

      expect(
        (darkmode as Text).data,
        'Dark mode',
      );

      final darkmodeSwitch = tester.widget(
        find.byKey(
          darkmodeSwitchKey,
        ),
      );
      expect(
        darkmodeSwitch,
        isA<Switch>(),
      );
    });
  });
  group('Taps', () {
    testWidgets('Tap on close', (tester) async {
      await tester.pumpApp(
        BlocProvider.value(
          value: bloc,
          child: const SettingsDialog(),
        ),
      );

      await tester.tap(
        find.byKey(
          closeButtonKey,
        ),
      );
      await tester.pumpAndSettle();
      expect(
        find.byType(SettingsDialog),
        findsNothing,
      );
    });

    testWidgets('Tap on dark mode', (tester) async {
      await tester.pumpApp(
        BlocProvider.value(
          value: bloc,
          child: const SettingsDialog(),
        ),
      );

      final darkModeSwitch = tester.widget(
        find.byKey(
          darkmodeSwitchKey,
        ),
      );
      await tester.tap(
        find.byKey(
          darkmodeSwitchKey,
        ),
      );
      expect(
        (darkModeSwitch as Switch).value,
        false,
      );
      verify(
        () => bloc.add(
          const ChangeStyleEvent(
            darkMode: true,
          ),
        ),
      ).called(1);
    });
  });
}
