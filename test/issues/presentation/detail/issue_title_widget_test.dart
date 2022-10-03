import 'package:flutter/material.dart';
import 'package:flutter_good_practices/issues/presentation/detail/issue_title_widget.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/helpers.dart';

void main() {
  const labelKey = Key('issue_detail_title_label');
  const valueKey = Key('issue_detail_title_view');

  group('render', () {
    testWidgets('IssueTitle has correct title', (tester) async {
      await tester.pumpApp(
        const Material(
          child: IssueTitle(
            title: 'issue title',
          ),
        ),
      );
      final widgetFinder = find.byKey(labelKey);
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
        'Title',
      );
    });
    testWidgets('IssueTitle has correct value', (tester) async {
      await tester.pumpApp(
        const Material(
          child: IssueTitle(
            title: 'issue title',
          ),
        ),
      );
      final widgetFinder = find.byKey(valueKey);
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
        'issue title',
      );
    });
  });
}
