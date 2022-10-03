import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_good_practices/injection/injection.dart';
import 'package:flutter_good_practices/issues/application/list/issues_list_bloc.dart';
import 'package:flutter_good_practices/issues/domain/models/issue_filter.dart';
import 'package:flutter_good_practices/issues/domain/use_cases/i_issues_repository.dart';
import 'package:flutter_good_practices/issues/presentation/list/dialogs/filter_dialog.dart';
import 'package:flutter_good_practices/issues/presentation/list/dialogs/order_by_dialog.dart';
import 'package:flutter_good_practices/issues/presentation/list/widgets/issues_list_body.dart';
import 'package:flutter_good_practices/issues/presentation/list/widgets/issues_list_view.dart';
import 'package:flutter_good_practices/settings/application/settings_bloc.dart';
import 'package:flutter_good_practices/settings/presentation/settings_dialog.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/helpers.dart';

class MockIssuesListBloc extends MockBloc<IssuesListEvent, IssuesListState>
    implements IssuesListBloc {}

class MockSettingsBloc extends MockBloc<SettingsEvent, SettingsState>
    implements SettingsBloc {}

void main() {
  late IssuesListBloc mockBloc;
  late SettingsBloc mockSettingsBloc;

  setUpAll(() async {
    WidgetController.hitTestWarningShouldBeFatal = true;
    WidgetsFlutterBinding.ensureInitialized();
  });
  tearDown(getIt.reset);
  setUp(() {
    configureInjection(Environment.test);
    mockBloc = MockIssuesListBloc();
    mockSettingsBloc = MockSettingsBloc();
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
    when(() => mockSettingsBloc.state).thenReturn(
      const SettingsState(
        darkMode: false,
      ),
    );
  });
  group('AppBar', () {
    testWidgets('When tap on menu Settings options is displayed',
        (tester) async {
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
      await tester.pumpAppWithSettings(
        BlocProvider.value(
          value: mockBloc,
          child: const IssuesListView(),
        ),
      );

      await tester.tap(
        find.byIcon(
          Icons.more_vert,
        ),
      );
      await tester.pump();

      expect(
        find.text('Settings'),
        findsOneWidget,
      );
    });
    testWidgets('When tap on menu Filter Issues options is displayed',
        (tester) async {
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

      await tester.pumpAppWithSettings(
        BlocProvider.value(
          value: mockBloc,
          child: const IssuesListView(),
        ),
      );

      await tester.tap(
        find.byIcon(
          Icons.more_vert,
        ),
      );
      await tester.pump();

      expect(
        find.text('Filter Issues'),
        findsOneWidget,
      );
    });
    testWidgets('When tap on menu Order Issues options is displayed',
        (tester) async {
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

      await tester.pumpAppWithSettings(
        BlocProvider.value(
          value: mockBloc,
          child: const IssuesListView(),
        ),
      );

      await tester.tap(
        find.byIcon(
          Icons.more_vert,
        ),
      );
      await tester.pump();

      expect(
        find.text('Order Issues'),
        findsOneWidget,
      );
    });

    testWidgets('When tap on Settings options SettingsDialog is displayed',
        (tester) async {
      when(() => mockSettingsBloc.state).thenReturn(
        const SettingsState(
          darkMode: false,
        ),
      );
      when(() => mockBloc.state).thenReturn(
        IssuesListState(
          status: IssuesListStatus.loaded,
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
      await tester.pumpAppWithSettings(
        BlocProvider.value(
          value: mockBloc,
          child: const IssuesListView(),
        ),
      );

      await tester.tap(
        find.byIcon(
          Icons.more_vert,
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(
        find.text('Settings'),
      );
      await tester.pumpAndSettle();
      expect(
        find.byType(SettingsDialog),
        findsOneWidget,
      );
    });
    testWidgets('When tap on Order Issues options OrderByDialog is displayed',
        (tester) async {
      when(() => mockSettingsBloc.state).thenReturn(
        const SettingsState(
          darkMode: false,
        ),
      );
      when(() => mockBloc.state).thenReturn(
        IssuesListState(
          status: IssuesListStatus.loaded,
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
      await tester.pumpAppWithSettings(
        BlocProvider.value(
          value: mockBloc,
          child: const IssuesListView(),
        ),
      );

      await tester.tap(
        find.byIcon(
          Icons.more_vert,
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(
        find.text('Order Issues'),
      );
      await tester.pumpAndSettle();
      expect(
        find.byType(OrderByDialog),
        findsOneWidget,
      );
    });
    testWidgets(
        'When tap on Order Issues and close OrderByDialog '
        'UpdateFilter is called', (tester) async {
      when(() => mockSettingsBloc.state).thenReturn(
        const SettingsState(
          darkMode: false,
        ),
      );
      when(() => mockBloc.state).thenReturn(
        IssuesListState(
          status: IssuesListStatus.loaded,
          issues: const [],
          hasNextPage: true,
          filter: IssueFilter.initial(),
        ),
      );
      await tester.pumpAppWithSettings(
        BlocProvider.value(
          value: mockBloc,
          child: const IssuesListView(),
        ),
      );

      await tester.tap(
        find.byIcon(
          Icons.more_vert,
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(
        find.text('Order Issues'),
      );
      await tester.pumpAndSettle();
      await tester.tap(
        find.byKey(
          const Key('order_by_dialog_close_button'),
        ),
      );
      await tester.pumpAndSettle();
      verify(
        () => mockBloc.add(
          UpdateFilter(
            filter: IssueFilter.initial(),
          ),
        ),
      ).called(1);
    });
    testWidgets('When tap on Filter Issues options FilterDialog is displayed',
        (tester) async {
      when(() => mockSettingsBloc.state).thenReturn(
        const SettingsState(
          darkMode: false,
        ),
      );
      when(() => mockBloc.state).thenReturn(
        IssuesListState(
          status: IssuesListStatus.loaded,
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
      await tester.pumpAppWithSettings(
        BlocProvider.value(
          value: mockBloc,
          child: const IssuesListView(),
        ),
      );

      await tester.tap(
        find.byIcon(
          Icons.more_vert,
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(
        find.text('Filter Issues'),
      );
      await tester.pumpAndSettle();
      expect(
        find.byType(FilterDialog),
        findsOneWidget,
      );
    });
    testWidgets(
        'When tap on Order Issues and close OrderByDialog '
        'UpdateFilter is called', (tester) async {
      when(() => mockSettingsBloc.state).thenReturn(
        const SettingsState(
          darkMode: false,
        ),
      );
      when(() => mockBloc.state).thenReturn(
        IssuesListState(
          status: IssuesListStatus.loaded,
          issues: const [],
          hasNextPage: true,
          filter: IssueFilter.initial(),
        ),
      );
      await tester.pumpAppWithSettings(
        BlocProvider.value(
          value: mockBloc,
          child: const IssuesListView(),
        ),
      );

      await tester.tap(
        find.byIcon(
          Icons.more_vert,
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(
        find.text('Filter Issues'),
      );
      await tester.pumpAndSettle();
      await tester.tap(
        find.byKey(
          const Key('filter_dialog_close_button'),
        ),
      );
      await tester.pumpAndSettle();
      verify(
        () => mockBloc.add(
          UpdateFilter(
            filter: IssueFilter.initial(),
          ),
        ),
      ).called(1);
    });
  });
  group('render', () {
    testWidgets('When page is render IssuesListBody is displayed ',
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
        find.byType(IssuesListBody),
        findsOneWidget,
      );
    });
  });
}
