import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_good_practices/injection/injection.dart';
import 'package:flutter_good_practices/issues/application/filter/issues_filter_bloc.dart';
import 'package:flutter_good_practices/issues/domain/models/issue_filter.dart';
import 'package:flutter_good_practices/issues/domain/use_cases/i_issues_repository.dart';
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

  const titleKey = Key('order_by_dialog_title');

  const closeButtonIconKey = Key('order_by_dialog_close_icon');
  const closeButtonKey = Key('order_by_dialog_close_button');

  const createdAtTextKey = Key('order_by_dialog_created_at_text');

  const ascendingModeTextKey = Key('order_by_dialog_ascending_mode_text');
  const descendingModeTextKey = Key('order_by_dialog_descending_mode_text');

  const ascendingModeSwitchKey = Key('order_by_dialog_ascending_mode_switch');
  const descendingModeSwitchKey = Key('order_by_dialog_descending_mode_switch');

  group('Rendering Order By Dialog', () {
    testWidgets('Display correct title', (tester) async {
      await tester.pumpApp(
        BlocProvider.value(
          value: bloc,
          child: const OrderByDialog(),
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
        'Order Issues',
      );
    });
    testWidgets('Display correct close button', (tester) async {
      await tester.pumpApp(
        BlocProvider.value(
          value: bloc,
          child: const OrderByDialog(),
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

    testWidgets('Display correct Created At option', (tester) async {
      await tester.pumpApp(
        BlocProvider.value(
          value: bloc,
          child: const OrderByDialog(),
        ),
      );

      final createdAtTitle = tester.widget(
        find.byKey(
          createdAtTextKey,
        ),
      );
      expect(
        createdAtTitle,
        isA<Text>(),
      );

      expect(
        (createdAtTitle as Text).data,
        'Created At',
      );
    });

    testWidgets('Display correct ascending mode option', (tester) async {
      await tester.pumpApp(
        BlocProvider.value(
          value: bloc,
          child: const OrderByDialog(),
        ),
      );

      final ascendingModeTitle = tester.widget(
        find.byKey(
          ascendingModeTextKey,
        ),
      );
      expect(
        ascendingModeTitle,
        isA<Text>(),
      );

      expect(
        (ascendingModeTitle as Text).data,
        'Ascending',
      );

      final ascendingModeSwitch = tester.widget(
        find.byKey(
          ascendingModeSwitchKey,
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
          child: const OrderByDialog(),
        ),
      );

      final descendingModeTitle = tester.widget(
        find.byKey(
          descendingModeTextKey,
        ),
      );
      expect(
        descendingModeTitle,
        isA<Text>(),
      );

      expect(
        (descendingModeTitle as Text).data,
        'Descending',
      );

      final ascendingModeSwitch = tester.widget(
        find.byKey(
          ascendingModeSwitchKey,
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
          child: const OrderByDialog(),
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

    testWidgets('Tap on ascending mode', (tester) async {
      await tester.pumpApp(
        BlocProvider.value(
          value: bloc,
          child: const OrderByDialog(),
        ),
      );

      final ascendingModeSwitch = tester.widget(
        find.byKey(
          ascendingModeSwitchKey,
        ),
      );
      await tester.tap(
        find.byKey(
          ascendingModeSwitchKey,
        ),
      );
      expect(
        (ascendingModeSwitch as Switch).value,
        true,
      );
      verify(
        () => bloc.add(
          const ChangeOrderByMode(
            ascending: false,
          ),
        ),
      ).called(1);
    });
    testWidgets('Tap on descending mode', (tester) async {
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
          child: const OrderByDialog(),
        ),
      );

      final descendingModeSwitch = tester.widget(
        find.byKey(
          descendingModeSwitchKey,
        ),
      );
      await tester.tap(
        find.byKey(
          descendingModeSwitchKey,
        ),
      );
      expect(
        (descendingModeSwitch as Switch).value,
        true,
      );
      verify(
        () => bloc.add(
          const ChangeOrderByMode(
            ascending: true,
          ),
        ),
      ).called(1);
    });
  });
}
