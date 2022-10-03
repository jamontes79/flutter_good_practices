import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_good_practices/issues/presentation/detail/issue_detail_chip_state.dart';
import 'package:flutter_good_practices/issues/presentation/detail/issue_state_widget.dart';

import '../../../helpers/helpers.dart';

void main() {
  const labelKey = Key('issue_detail_state_label');
  const chipKey = Key('issue_detail_chip_state');

  group('render', () {
    testWidgets('IssueState has correct title', (tester) async {
      await tester.pumpApp(
        const Material(
          child: IssueState(
            state: 'OPEN',
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
        'Status',
      );
    });
    testWidgets('IssueState has correct component', (tester) async {
      await tester.pumpApp(
        const Material(
          child: IssueState(
            state: 'OPEN',
          ),
        ),
      );
      final widgetFinder = find.byKey(chipKey);
      expect(
        widgetFinder,
        findsOneWidget,
      );
      final widgetTesting = tester.widget(widgetFinder);
      expect(
        widgetTesting,
        isA<ChipState>(),
      );
    });
  });
}
