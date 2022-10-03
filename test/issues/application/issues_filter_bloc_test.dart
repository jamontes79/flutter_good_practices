import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_good_practices/issues/application/filter/issues_filter_bloc.dart';
import 'package:flutter_good_practices/issues/domain/models/issue_filter.dart';
import 'package:flutter_good_practices/issues/domain/use_cases/i_issues_repository.dart';

void main() {
  late IssuesFilterBloc bloc;

  setUp(() {
    bloc = IssuesFilterBloc();
  });

  test(
    'Initial state is correct',
    () {
      expect(
        bloc.state,
        IssuesFilterState(
          filter: IssueFilter.initial(),
        ),
      );
    },
  );

  group('ChangeOrderByMode', () {
    blocTest<IssuesFilterBloc, IssuesFilterState>(
      'ChangeOrderByMode emits [ascendingMode] when event value is true',
      build: () {
        return bloc;
      },
      act: (bloc) => bloc.add(
        const ChangeOrderByMode(ascending: true),
      ),
      seed: () => IssuesFilterState(
        filter: IssueFilter.initial().copyWith(
          afterRecord: '1234567890',
          orderByDirection: OrderByDirection.desc,
          filterByClosed: true,
          filterByOpen: true,
        ),
      ),
      expect: () => [
        IssuesFilterState(
          filter: IssueFilter.initial().copyWith(
            afterRecord: '1234567890',
            orderByDirection: OrderByDirection.asc,
            filterByClosed: true,
            filterByOpen: true,
          ),
        ),
      ],
    );
    blocTest<IssuesFilterBloc, IssuesFilterState>(
      'ChangeOrderByMode emits [!ascendingMode] when event value is false',
      build: () {
        return bloc;
      },
      act: (bloc) => bloc.add(
        const ChangeOrderByMode(ascending: false),
      ),
      seed: () => IssuesFilterState(
        filter: IssueFilter.initial().copyWith(
          afterRecord: '1234567890',
          orderByDirection: OrderByDirection.asc,
          filterByClosed: true,
          filterByOpen: true,
        ),
      ),
      expect: () => [
        IssuesFilterState(
          filter: IssueFilter.initial().copyWith(
            afterRecord: '1234567890',
            orderByDirection: OrderByDirection.desc,
            filterByClosed: true,
            filterByOpen: true,
          ),
        ),
      ],
    );
  });
  group('ChangeFilterByOpen', () {
    blocTest<IssuesFilterBloc, IssuesFilterState>(
      'ChangeFilterByOpen emits [filterByOpen] when event value is true',
      build: () {
        return bloc;
      },
      act: (bloc) => bloc.add(
        const ChangeFilterByOpen(filterByOpen: true),
      ),
      seed: () => IssuesFilterState(
        filter: IssueFilter.initial().copyWith(
          afterRecord: '1234567890',
          orderByDirection: OrderByDirection.desc,
          filterByClosed: true,
          filterByOpen: false,
        ),
      ),
      expect: () => [
        IssuesFilterState(
          filter: IssueFilter.initial().copyWith(
            afterRecord: '1234567890',
            orderByDirection: OrderByDirection.desc,
            filterByClosed: true,
            filterByOpen: true,
          ),
        ),
      ],
    );
    blocTest<IssuesFilterBloc, IssuesFilterState>(
      'ChangeFilterByOpen emits [!filterByOpen] when event value is false',
      build: () {
        return bloc;
      },
      act: (bloc) => bloc.add(
        const ChangeFilterByOpen(filterByOpen: false),
      ),
      seed: () => IssuesFilterState(
        filter: IssueFilter.initial().copyWith(
          afterRecord: '1234567890',
          orderByDirection: OrderByDirection.asc,
          filterByClosed: true,
          filterByOpen: true,
        ),
      ),
      expect: () => [
        IssuesFilterState(
          filter: IssueFilter.initial().copyWith(
            afterRecord: '1234567890',
            orderByDirection: OrderByDirection.asc,
            filterByClosed: true,
            filterByOpen: false,
          ),
        ),
      ],
    );
  });
  group('ChangeFilterByClosed', () {
    blocTest<IssuesFilterBloc, IssuesFilterState>(
      'ChangeFilterByClosed emits [filterByClosed] when event value is true',
      build: () {
        return bloc;
      },
      act: (bloc) => bloc.add(
        const ChangeFilterByClosed(filterByClosed: true),
      ),
      seed: () => IssuesFilterState(
        filter: IssueFilter.initial().copyWith(
          afterRecord: '1234567890',
          orderByDirection: OrderByDirection.desc,
          filterByClosed: false,
          filterByOpen: false,
        ),
      ),
      expect: () => [
        IssuesFilterState(
          filter: IssueFilter.initial().copyWith(
            afterRecord: '1234567890',
            orderByDirection: OrderByDirection.desc,
            filterByClosed: true,
            filterByOpen: false,
          ),
        ),
      ],
    );
    blocTest<IssuesFilterBloc, IssuesFilterState>(
      'ChangeFilterByClosed emits [!filterByClosed] when event value is false',
      build: () {
        return bloc;
      },
      act: (bloc) => bloc.add(
        const ChangeFilterByClosed(filterByClosed: false),
      ),
      seed: () => IssuesFilterState(
        filter: IssueFilter.initial().copyWith(
          afterRecord: '1234567890',
          orderByDirection: OrderByDirection.asc,
          filterByClosed: true,
          filterByOpen: true,
        ),
      ),
      expect: () => [
        IssuesFilterState(
          filter: IssueFilter.initial().copyWith(
            afterRecord: '1234567890',
            orderByDirection: OrderByDirection.asc,
            filterByClosed: false,
            filterByOpen: true,
          ),
        ),
      ],
    );
  });
  group('InitFilter', () {
    blocTest<IssuesFilterBloc, IssuesFilterState>(
      'InitFilter emits [filter] with event value',
      build: () {
        return bloc;
      },
      act: (bloc) => bloc.add(
        InitFilter(
          filter: IssueFilter.initial().copyWith(
            afterRecord: '1234567890',
            orderByDirection: OrderByDirection.desc,
            filterByClosed: true,
            filterByOpen: true,
          ),
        ),
      ),
      seed: () => IssuesFilterState(
        filter: IssueFilter.initial(),
      ),
      expect: () => [
        IssuesFilterState(
          filter: IssueFilter.initial().copyWith(
            afterRecord: '1234567890',
            orderByDirection: OrderByDirection.desc,
            filterByClosed: true,
            filterByOpen: true,
          ),
        ),
      ],
    );
  });
  group('Events', () {
    test('ChangeOrderByMode is Equatable', () {
      const event = ChangeOrderByMode(ascending: true);
      expect(
        event,
        isA<Equatable>(),
      );
      expect(
        event.props,
        [
          true,
        ],
      );
    });
    test('ChangeFilterByOpen is Equatable', () {
      const event = ChangeFilterByOpen(filterByOpen: true);
      expect(
        event,
        isA<Equatable>(),
      );
      expect(
        event.props,
        [
          true,
        ],
      );
    });
    test('ChangeFilterByClosed is Equatable', () {
      const event = ChangeFilterByClosed(filterByClosed: false);
      expect(
        event,
        isA<Equatable>(),
      );
      expect(
        event.props,
        [
          false,
        ],
      );
    });
    test('InitFilter is Equatable', () {
      final event = InitFilter(
        filter: IssueFilter.initial(),
      );
      expect(
        event,
        isA<Equatable>(),
      );
      expect(
        event.props,
        [
          IssueFilter.initial(),
        ],
      );
    });
  });
}
