import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_good_practices/issues/domain/models/issue.dart';
import 'package:flutter_good_practices/issues/presentation/detail/issue_detail_navigate_button.dart';
import 'package:flutter_good_practices/issues/presentation/detail/issue_detail_page.dart';
import 'package:flutter_good_practices/issues/presentation/detail/issue_state_widget.dart';
import 'package:flutter_good_practices/issues/presentation/detail/issue_title_widget.dart';

import '../../../helpers/helpers.dart';

void main() {
  const titleKey = Key('issue_detail_title');
  const stateKey = Key('issue_detail_state');
  const navigateKey = Key('issue_detail_navigate');
  const issue = Issue(
    id: 'id1',
    title: 'title',
    number: 1,
    state: 'state',
    url: 'url',
  );
  group('render', () {
    testWidgets('IssueDetailPage has correct title', (tester) async {
      await tester.pumpApp(
        const Material(
          child: IssueDetailPage(
            issue: issue,
          ),
        ),
      );
      final widgetFinder = find.byKey(titleKey);
      expect(
        widgetFinder,
        findsOneWidget,
      );
      final widgetTesting = tester.widget(widgetFinder);
      expect(
        widgetTesting,
        isA<IssueTitle>(),
      );
      expect(
        (widgetTesting as IssueTitle).title,
        issue.title,
      );
    });
    testWidgets('IssueDetailPage has correct state', (tester) async {
      await tester.pumpApp(
        const Material(
          child: IssueDetailPage(
            issue: issue,
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
        isA<IssueState>(),
      );
      expect(
        (widgetTesting as IssueState).state,
        issue.state,
      );
    });
    testWidgets('IssueDetailPage has correct navigator', (tester) async {
      await tester.pumpApp(
        const Material(
          child: IssueDetailPage(
            issue: issue,
          ),
        ),
      );
      final widgetFinder = find.byKey(navigateKey);
      expect(
        widgetFinder,
        findsOneWidget,
      );
      final widgetTesting = tester.widget(widgetFinder);
      expect(
        widgetTesting,
        isA<IssueNavigateButton>(),
      );
      expect(
        (widgetTesting as IssueNavigateButton).url,
        issue.url,
      );
    });
  });
}
