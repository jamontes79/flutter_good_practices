import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_good_practices/injection/injection.dart';
import 'package:flutter_good_practices/issues/application/list/issues_list_bloc.dart';
import 'package:flutter_good_practices/issues/domain/models/issue.dart';
import 'package:flutter_good_practices/issues/domain/models/issue_filter.dart';
import 'package:flutter_good_practices/issues/domain/use_cases/i_issues_repository.dart';
import 'package:flutter_good_practices/issues/presentation/list/widgets/issue_card_widget.dart';
import 'package:flutter_good_practices/routes/routes.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:injectable/injectable.dart';
import 'package:mockingjay/mockingjay.dart';

import '../../../helpers/helpers.dart';

class MockIssuesListBloc extends MockBloc<IssuesListEvent, IssuesListState>
    implements IssuesListBloc {}

void main() {
  const issue = Issue(
    id: 'id1',
    title: 'title',
    number: 1,
    state: 'state',
    url: 'url',
  );
  const titleKey = Key('issue_title');
  const stateKey = Key('issue_state');
  const trailingKey = Key('issue_trailing');
  const cardKey = Key('issue_card');
  late IssuesListBloc mockBloc;
  setUpAll(() async {
    WidgetController.hitTestWarningShouldBeFatal = true;
    WidgetsFlutterBinding.ensureInitialized();
  });
  tearDown(getIt.reset);
  setUp(() {
    configureInjection(Environment.test);
    mockBloc = MockIssuesListBloc();

    when(() => mockBloc.state).thenReturn(
      IssuesListState(
        status: IssuesListStatus.initial,
        issues: const [issue, issue],
        hasNextPage: true,
        filter: IssueFilter.initial().copyWith(
          afterRecord: '',
          orderByDirection: OrderByDirection.asc,
          filterByClosed: true,
          filterByOpen: true,
        ),
      ),
    );
  });
  group('render', () {
    testWidgets('Card has color white when not visited', (tester) async {
      await tester.pumpApp(
        Material(
          child: BlocProvider.value(
            value: mockBloc,
            child: const IssueCard(
              issue: issue,
            ),
          ),
        ),
      );
      final widgetFinder = find.byKey(cardKey);
      expect(
        widgetFinder,
        findsOneWidget,
      );
      final widgetTesting = tester.widget(widgetFinder);
      expect(
        widgetTesting,
        isA<Card>(),
      );
      expect(
        (widgetTesting as Card).color,
        Colors.white,
      );
    });
    testWidgets('Card has color white when visited', (tester) async {
      await tester.pumpApp(
        Material(
          child: BlocProvider.value(
            value: mockBloc,
            child: IssueCard(
              issue: issue.copyWith(
                visited: true,
              ),
            ),
          ),
        ),
      );
      final widgetFinder = find.byKey(cardKey);
      expect(
        widgetFinder,
        findsOneWidget,
      );
      final widgetTesting = tester.widget(widgetFinder);
      expect(
        widgetTesting,
        isA<Card>(),
      );
      expect(
        (widgetTesting as Card).color,
        Colors.grey,
      );
    });
    testWidgets('Card has Issue title', (tester) async {
      await tester.pumpApp(
        Material(
          child: BlocProvider.value(
            value: mockBloc,
            child: const IssueCard(
              issue: issue,
            ),
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
        isA<Text>(),
      );
      expect(
        (widgetTesting as Text).data,
        'title',
      );
    });
    testWidgets('Card has Issue state', (tester) async {
      await tester.pumpApp(
        Material(
          child: BlocProvider.value(
            value: mockBloc,
            child: const IssueCard(
              issue: issue,
            ),
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
        'state',
      );
    });
    testWidgets('Card has trailing icon', (tester) async {
      await tester.pumpApp(
        Material(
          child: BlocProvider.value(
            value: mockBloc,
            child: const IssueCard(
              issue: issue,
            ),
          ),
        ),
      );
      final widgetFinder = find.byKey(trailingKey);
      expect(
        widgetFinder,
        findsOneWidget,
      );
      final widgetTesting = tester.widget(widgetFinder);
      expect(
        widgetTesting,
        isA<Icon>(),
      );
      expect(
        (widgetTesting as Icon).icon,
        Icons.arrow_forward_ios_sharp,
      );
    });
  });

  group('Navigation', () {
    testWidgets('When tap on card then navigates to IssueDetailPage',
        (tester) async {
      final navigator = MockNavigator();
      when(
        () => navigator.pushNamed(
          RouteGenerator.issueDetailPage,
          arguments: issue,
        ),
      ).thenAnswer(
        (_) => Future.value(),
      );
      await tester.pumpApp(
        MockNavigatorProvider(
          navigator: navigator,
          child: Material(
            child: BlocProvider.value(
              value: mockBloc,
              child: const IssueCard(
                issue: issue,
              ),
            ),
          ),
        ),
      );

      await tester.tap(
        find.byKey(cardKey),
      );

      await tester.pumpAndSettle();

      verify(
        () => navigator.pushNamed(
          RouteGenerator.issueDetailPage,
          arguments: issue,
        ),
      ).called(1);
    });
  });
}
