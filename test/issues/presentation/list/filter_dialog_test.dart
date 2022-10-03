import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_good_practices/injection/injection.dart';
import 'package:flutter_good_practices/issues/application/filter/issues_filter_bloc.dart';
import 'package:flutter_good_practices/issues/domain/models/issue_filter.dart';
import 'package:flutter_good_practices/issues/domain/use_cases/i_issues_repository.dart';
import 'package:flutter_good_practices/issues/presentation/list/dialogs/filter_dialog.dart';
import 'package:flutter_good_practices/issues/presentation/list/dialogs/order_by_dialog.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/helpers.dart';

class MockIssuesFilterBloc
    extends MockBloc<IssuesFilterEvent, IssuesFilterState>
    implements IssuesFilterBloc {}

void main() {
  late IssuesFilterBloc bloc;
  setUpAll(() async {
    configureInjection(Environment.test);
    WidgetController.hitTestWarningShouldBeFatal = true;
    WidgetsFlutterBinding.ensureInitialized();
  });
  tearDown(getIt.reset);
  setUp(() {
    bloc = MockIssuesFilterBloc();
    when(() => bloc.state).thenReturn(
      IssuesFilterState(
        filter: IssueFilter.initial().copyWith(
          afterRecord: '',
          orderByDirection: OrderByDirection.asc,
          filterByClosed: true,
          filterByOpen: true,
        ),
      ),
    );
  });

  const titleKey = Key('filter_dialog_title');

  const closeButtonIconKey = Key('filter_dialog_close_icon');
  const closeButtonKey = Key('filter_dialog_close_button');

  const statusTextKey = Key('filter_dialog_status_text');

  const openTextKey = Key('filter_dialog_open_text');
  const closedTextKey = Key('filter_dialog_closed_mode_text');

  const openSwitchKey = Key('filter_dialog_open_switch');
  const closedSwitchKey = Key('filter_dialog_closed_switch');

  group('Rendering Filter Dialog', () {
    testWidgets('Display correct title', (tester) async {
      await tester.pumpApp(
        BlocProvider.value(
          value: bloc,
          child: const FilterDialog(),
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
        'Filter Issues',
      );
    });
    testWidgets('Display correct close button', (tester) async {
      await tester.pumpApp(
        BlocProvider.value(
          value: bloc,
          child: const FilterDialog(),
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

    testWidgets('Display correct Status option', (tester) async {
      await tester.pumpApp(
        BlocProvider.value(
          value: bloc,
          child: const FilterDialog(),
        ),
      );

      final createdAtTitle = tester.widget(
        find.byKey(
          statusTextKey,
        ),
      );
      expect(
        createdAtTitle,
        isA<Text>(),
      );

      expect(
        (createdAtTitle as Text).data,
        'Status',
      );
    });

    testWidgets('Display correct ascending mode option', (tester) async {
      await tester.pumpApp(
        BlocProvider.value(
          value: bloc,
          child: const FilterDialog(),
        ),
      );

      final ascendingModeTitle = tester.widget(
        find.byKey(
          openTextKey,
        ),
      );
      expect(
        ascendingModeTitle,
        isA<Text>(),
      );

      expect(
        (ascendingModeTitle as Text).data,
        'Open',
      );

      final ascendingModeSwitch = tester.widget(
        find.byKey(
          openSwitchKey,
        ),
      );
      expect(
        ascendingModeSwitch,
        isA<Switch>(),
      );
    });
    testWidgets('Display correct descending mode option', (tester) async {
      await tester.pumpApp(
        BlocProvider.value(
          value: bloc,
          child: const FilterDialog(),
        ),
      );

      final descendingModeTitle = tester.widget(
        find.byKey(
          closedTextKey,
        ),
      );
      expect(
        descendingModeTitle,
        isA<Text>(),
      );

      expect(
        (descendingModeTitle as Text).data,
        'Closed',
      );

      final ascendingModeSwitch = tester.widget(
        find.byKey(
          openSwitchKey,
        ),
      );
      expect(
        ascendingModeSwitch,
        isA<Switch>(),
      );
    });
  });
  group('Taps', () {
    testWidgets('Tap on close', (tester) async {
      await tester.pumpApp(
        BlocProvider.value(
          value: bloc,
          child: const FilterDialog(),
        ),
      );

      await tester.tap(
        find.byKey(
          closeButtonKey,
        ),
      );
      await tester.pumpAndSettle();
      expect(
        find.byType(OrderByDialog),
        findsNothing,
      );
    });

    testWidgets('Tap on open filter', (tester) async {
      await tester.pumpApp(
        BlocProvider.value(
          value: bloc,
          child: const FilterDialog(),
        ),
      );

      final openSwitch = tester.widget(
        find.byKey(
          openSwitchKey,
        ),
      );
      await tester.tap(
        find.byKey(
          openSwitchKey,
        ),
      );
      expect(
        (openSwitch as Switch).value,
        true,
      );
      verify(
        () => bloc.add(
          const ChangeFilterByOpen(
            filterByOpen: false,
          ),
        ),
      ).called(1);
    });
    testWidgets('Tap on closed filter', (tester) async {
      when(() => bloc.state).thenReturn(
        IssuesFilterState(
          filter: IssueFilter.initial().copyWith(
            afterRecord: '',
            orderByDirection: OrderByDirection.desc,
            filterByClosed: true,
            filterByOpen: true,
          ),
        ),
      );
      await tester.pumpApp(
        BlocProvider.value(
          value: bloc,
          child: const FilterDialog(),
        ),
      );

      final closedSwitch = tester.widget(
        find.byKey(
          closedSwitchKey,
        ),
      );
      await tester.tap(
        find.byKey(
          closedSwitchKey,
        ),
      );
      expect(
        (closedSwitch as Switch).value,
        true,
      );
      verify(
        () => bloc.add(
          const ChangeFilterByClosed(
            filterByClosed: false,
          ),
        ),
      ).called(1);
    });
  });
}
