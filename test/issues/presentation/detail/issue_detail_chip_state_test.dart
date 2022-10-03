import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:flutter_good_practices/issues/presentation/detail/issue_detail_chip_state.dart';
import 'package:flutter_good_practices/l10n/l10n.dart';

import '../../../helpers/helpers.dart';

void main() {
  const stateKey = Key('issue_detail_state_text');

  group('render', () {
    testWidgets('Chip has correct state text', (tester) async {
      await tester.pumpApp(
        const Material(
          child: ChipState(
            state: 'OPEN',
          ),
        ),
      );
      final widgetFinder = find.byKey(stateKey);
      expect(
        widgetFinder,
        findsOneWidget,
      );
      final widgetTesting = tester.widget(widgetFinder);
      expect(
        widgetTesting,
        isA<Text>(),
      );
      expect(
        (widgetTesting as Text).data,
        'OPEN',
      );
    });
  });

  group('Golden tests', () {
    setUpAll(() async {
      await loadAppFonts();
    });

    goldenTest(
      'renders correctly',
      fileName: 'issue_chip_state_state',
      builder: () => GoldenTestGroup(
        children: [
          GoldenTestScenario(
            name: 'open state',
            child: ClipRect(
              child: SizedBox(
                width: 200,
                height: 25,
                child: MaterialApp(
                  theme: ThemeData(
                    appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
                    colorScheme: ColorScheme.fromSwatch(
                      accentColor: const Color(0xFF13B9FF),
                    ),
                  ),
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    DefaultWidgetsLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  debugShowCheckedModeBanner: false,
                  supportedLocales: AppLocalizations.supportedLocales,
                  home: const ChipState(
                    state: 'OPEN',
                  ),
                ),
              ),
            ),
          ),
          GoldenTestScenario(
            name: 'close state',
            child: ClipRect(
              child: SizedBox(
                width: 200,
                height: 25,
                child: MaterialApp(
                  theme: ThemeData(
                    appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
                    colorScheme: ColorScheme.fromSwatch(
                      accentColor: const Color(0xFF13B9FF),
                    ),
                  ),
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    DefaultWidgetsLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  debugShowCheckedModeBanner: false,
                  supportedLocales: AppLocalizations.supportedLocales,
                  home: const ChipState(
                    state: 'CLOSED',
                  ),
                ),
              ),
            ),
          ),
          GoldenTestScenario(
            name: 'other state',
            child: ClipRect(
              child: SizedBox(
                width: 200,
                height: 25,
                child: MaterialApp(
                  theme: ThemeData(
                    appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
                    colorScheme: ColorScheme.fromSwatch(
                      accentColor: const Color(0xFF13B9FF),
                    ),
                  ),
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    DefaultWidgetsLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  debugShowCheckedModeBanner: false,
                  supportedLocales: AppLocalizations.supportedLocales,
                  home: const ChipState(
                    state: 'other',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  });
}
