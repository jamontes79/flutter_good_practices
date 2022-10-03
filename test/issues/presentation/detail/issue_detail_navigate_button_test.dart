import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_good_practices/issues/presentation/detail/issue_detail_navigate_button.dart';

import '../../../helpers/helpers.dart';

void main() {
  const buttonKey = Key('url_navigator');
  const titleKey = Key('url_navigator_text');

  group('render', () {
    testWidgets('IssueNavigateButton has correct component', (tester) async {
      await tester.pumpApp(
        const Material(
          child: IssueNavigateButton(
            url: 'link',
          ),
        ),
      );
      final widgetFinder = find.byKey(buttonKey);
      expect(
        widgetFinder,
        findsOneWidget,
      );
      final widgetTesting = tester.widget(widgetFinder);
      expect(
        widgetTesting,
        isA<ElevatedButton>(),
      );
    });
    testWidgets('IssueNavigateButton has correct text', (tester) async {
      await tester.pumpApp(
        const Material(
          child: IssueNavigateButton(
            url: 'link',
          ),
        ),
      );
      final widgetFinder = find.descendant(
        of: find.byKey(buttonKey),
        matching: find.byKey(titleKey),
      );
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
        'See in GitHub',
      );
    });
  });
  group('Events', () {
    testWidgets('IssueNavigateButton has correct text', (tester) async {
      await tester.pumpApp(
        const Material(
          child: IssueNavigateButton(
            url: 'https://google.es',
          ),
        ),
      );
      final widgetFinder = find.byKey(buttonKey);
      await tester.tap(widgetFinder);
    });
  });
}
