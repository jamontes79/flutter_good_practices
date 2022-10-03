import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_good_practices/injection/injection.dart';
import 'package:flutter_good_practices/issues/application/list/issues_list_bloc.dart';
import 'package:flutter_good_practices/issues/domain/models/issue.dart';
import 'package:flutter_good_practices/issues/domain/models/issue_filter.dart';
import 'package:flutter_good_practices/issues/domain/use_cases/i_issues_repository.dart';
import 'package:flutter_good_practices/issues/presentation/list/widgets/issue_card_widget.dart';
import 'package:flutter_good_practices/issues/presentation/list/widgets/issues_list_body.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/helpers.dart';

class MockIssuesListBloc extends MockBloc<IssuesListEvent, IssuesListState>
    implements IssuesListBloc {}

void main() {
  const issue1 = Issue(
    id: 'id1',
    title: 'title',
    number: 1,
    state: 'state',
    url: 'url',
  );
  const issue2 = Issue(
    id: 'id2',
    title: 'title',
    number: 2,
    state: 'state',
    url: 'url',
  );
  late IssuesListBloc mockBloc;

  const refreshKey = Key('issues_refresh_list');
  const listKey = Key('issues_list');
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
        issues: const [],
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
    testWidgets('When bloc.status is initial renders CircularProgressIndicator',
        (tester) async {
      when(() => mockBloc.state).thenReturn(
        IssuesListState(
          status: IssuesListStatus.initial,
          issues: const [],
          hasNextPage: true,
          filter: IssueFilter.initial(),
        ),
      );
      await tester.pumpApp(
        BlocProvider.value(
          value: mockBloc,
          child: const IssuesListBody(),
        ),
      );

      expect(
        find.byType(CircularProgressIndicator),
        findsOneWidget,
      );
      expect(
        find.byType(ListView),
        findsNothing,
      );
    });
    testWidgets('When bloc.status is error renders Error Message',
        (tester) async {
      when(() => mockBloc.state).thenReturn(
        IssuesListState(
          status: IssuesListStatus.error,
          issues: const [],
          hasNextPage: true,
          filter: IssueFilter.initial(),
        ),
      );
      await tester.pumpApp(
        BlocProvider.value(
          value: mockBloc,
          child: const IssuesListBody(),
        ),
      );
      expect(
        find.text('An error has occurred'),
        findsOneWidget,
      );
      expect(
        find.byType(CircularProgressIndicator),
        findsNothing,
      );
      expect(
        find.byType(ListView),
        findsNothing,
      );
    });
    testWidgets('When bloc.status is loaded but empty renders Info Message',
        (tester) async {
      when(() => mockBloc.state).thenReturn(
        IssuesListState(
          status: IssuesListStatus.loaded,
          issues: const [],
          hasNextPage: true,
          filter: IssueFilter.initial(),
        ),
      );
      await tester.pumpApp(
        BlocProvider.value(
          value: mockBloc,
          child: const IssuesListBody(),
        ),
      );
      expect(
        find.text('No issues found with selected filters'),
        findsOneWidget,
      );
      expect(
        find.byType(CircularProgressIndicator),
        findsNothing,
      );
      expect(
        find.byType(ListView),
        findsNothing,
      );
    });
    testWidgets('When bloc.status is loading renders CircularProgressIndicator',
        (tester) async {
      when(() => mockBloc.state).thenReturn(
        IssuesListState(
          status: IssuesListStatus.loading,
          issues: const [],
          hasNextPage: true,
          filter: IssueFilter.initial(),
        ),
      );
      await tester.pumpApp(
        BlocProvider.value(
          value: mockBloc,
          child: const IssuesListBody(),
        ),
      );

      expect(
        find.byType(CircularProgressIndicator),
        findsOneWidget,
      );
      expect(
        find.byType(ListView),
        findsNothing,
      );
    });

    testWidgets('When bloc.status is loaded renders ListView', (tester) async {
      when(() => mockBloc.state).thenReturn(
        IssuesListState(
          status: IssuesListStatus.loaded,
          issues: const [
            issue1,
            issue2,
          ],
          hasNextPage: true,
          filter: IssueFilter.initial(),
        ),
      );

      await tester.pumpApp(
        BlocProvider.value(
          value: mockBloc,
          child: const Material(
            child: IssuesListBody(),
          ),
        ),
      );

      expect(
        find.byType(CircularProgressIndicator),
        findsNothing,
      );
      expect(
        find.byType(ListView),
        findsOneWidget,
      );
    });
    testWidgets('When bloc.status is loaded renders IssueCard for each issue',
        (tester) async {
      when(() => mockBloc.state).thenReturn(
        IssuesListState(
          status: IssuesListStatus.loaded,
          issues: const [
            issue1,
            issue2,
          ],
          hasNextPage: true,
          filter: IssueFilter.initial(),
        ),
      );
      await tester.pumpApp(
        BlocProvider.value(
          value: mockBloc,
          child: const Material(
            child: IssuesListBody(),
          ),
        ),
      );

      expect(
        find.byType(IssueCard),
        findsNWidgets(2),
      );
    });
    testWidgets(
        'When bloc.status is loadingNewPage renders ListView and '
        'CircularProgressIndicator', (tester) async {
      when(() => mockBloc.state).thenReturn(
        IssuesListState(
          status: IssuesListStatus.updatingList,
          issues: const [
            issue1,
            issue2,
          ],
          hasNextPage: true,
          filter: IssueFilter.initial(),
        ),
      );
      await tester.pumpApp(
        BlocProvider.value(
          value: mockBloc,
          child: const Material(
            child: IssuesListBody(),
          ),
        ),
      );

      expect(
        find.byType(CircularProgressIndicator),
        findsOneWidget,
      );
      expect(
        find.byType(ListView),
        findsOneWidget,
      );
    });
    testWidgets('When refresh list call to LoadIssues', (tester) async {
      when(() => mockBloc.state).thenReturn(
        IssuesListState(
          status: IssuesListStatus.loaded,
          issues: const [
            issue1,
            issue2,
            issue1,
            issue1,
            issue1,
            issue1,
            issue1,
            issue1,
            issue1,
            issue1,
          ],
          hasNextPage: true,
          filter: IssueFilter.initial(),
        ),
      );

      await tester.pumpApp(
        BlocProvider.value(
          value: mockBloc,
          child: const Material(
            child: IssuesListBody(),
          ),
        ),
      );

      await tester.drag(
        find.byKey(refreshKey),
        const Offset(0, 500),
      );
      await tester.pumpAndSettle();
      verify(
        () => mockBloc.add(
          const LoadIssues(),
        ),
      ).called(1);
    });
    testWidgets('When scroll down list call to LoadNextPageIssues',
        (tester) async {
      when(() => mockBloc.state).thenReturn(
        IssuesListState(
          status: IssuesListStatus.loaded,
          issues: const [
            issue1,
            issue2,
            issue1,
            issue1,
          ],
          hasNextPage: true,
          filter: IssueFilter.initial(),
        ),
      );

      await tester.pumpApp(
        MediaQuery(
          data: const MediaQueryData(
            size: Size(
              375,
              667,
            ),
          ),
          child: BlocProvider.value(
            value: mockBloc,
            child: const Material(
              child: IssuesListBody(),
            ),
          ),
        ),
      );

      final list = tester.widget(find.byKey(listKey)) as ListView;
      final ctrl = list.controller;
      ctrl?.jumpTo(1);

      await tester.pumpAndSettle();
      final value = verify(
        () => mockBloc.add(
          const LoadNextPageIssues(),
        ),
      ).callCount;
      expect(
        value > 0,
        true,
      );
    });
  });
}
