import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_good_practices/injection/injection.dart';
import 'package:flutter_good_practices/issues/application/list/issues_list_bloc.dart';
import 'package:flutter_good_practices/issues/domain/models/issue_filter.dart';
import 'package:flutter_good_practices/issues/domain/use_cases/i_issues_repository.dart';
import 'package:flutter_good_practices/issues/presentation/list/widgets/issues_list_view.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/helpers.dart';

class MockIssuesListBloc extends MockBloc<IssuesListEvent, IssuesListState>
    implements IssuesListBloc {}

void main() {
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
    testWidgets('When page is render IssuesListView is displayed ',
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
          child: const IssuesListView(),
        ),
      );

      expect(
        find.byType(IssuesListView),
        findsOneWidget,
      );
    });
  });
}
