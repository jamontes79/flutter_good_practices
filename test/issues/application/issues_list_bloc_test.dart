import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_good_practices/issues/application/list/issues_list_bloc.dart';
import 'package:flutter_good_practices/issues/domain/models/failures.dart';
import 'package:flutter_good_practices/issues/domain/models/issue.dart';
import 'package:flutter_good_practices/issues/domain/models/issue_filter.dart';
import 'package:flutter_good_practices/issues/domain/models/issues_navigation.dart';
import 'package:flutter_good_practices/issues/domain/use_cases/i_issues_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockIssuesRepository extends Mock implements IIssuesRepository {}

void main() {
  late IssuesListBloc bloc;
  late IIssuesRepository mockRepository;
  late IssuesNavigation issuesNavigationEmpty;
  late IssuesNavigation issuesNavigationFirstPage;
  late IssuesNavigation issuesNavigationSecondPage;
  late List<Issue> issuesFirstPage;
  late List<Issue> issuesSecondPage;
  late List<Issue> issuesAllPages;
  const issue = Issue(
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
  setUp(() {
    mockRepository = MockIssuesRepository();
    bloc = IssuesListBloc(mockRepository);

    issuesFirstPage = [
      issue,
    ];
    issuesSecondPage = [
      issue2,
    ];
    issuesAllPages = [
      issue,
      issue2,
    ];
    issuesNavigationFirstPage = IssuesNavigation(
      issues: issuesFirstPage,
      hasNextPage: true,
      endCursor: '123456789',
    );
    issuesNavigationSecondPage = IssuesNavigation(
      issues: issuesSecondPage,
      hasNextPage: false,
      endCursor: '',
    );
    issuesNavigationEmpty = const IssuesNavigation(
      issues: [],
      hasNextPage: false,
      endCursor: '',
    );
  });

  test(
    'Initial state is correct',
    () {
      expect(
        bloc.state,
        IssuesListState(
          status: IssuesListStatus.initial,
          issues: const [],
          hasNextPage: true,
          filter: IssueFilter.initial(),
        ),
      );
    },
  );

  group(
    'LoadIssues',
    () {
      blocTest<IssuesListBloc, IssuesListState>(
        'LoadIssues emits [loading, error] when repository returns event',
        build: () {
          when(
            () => mockRepository.get(
              filter: IssueFilter.initial().copyWith(
                afterRecord: '',
                orderByDirection: OrderByDirection.desc,
                filterByOpen: true,
                filterByClosed: true,
              ),
            ),
          ).thenAnswer(
            (invocation) async => left(
              const IssuesFailure(),
            ),
          );
          return bloc;
        },
        act: (bloc) => bloc.add(
          const LoadIssues(),
        ),
        expect: () => [
          IssuesListState(
            status: IssuesListStatus.loading,
            issues: const [],
            hasNextPage: true,
            filter: IssueFilter.initial().copyWith(
              afterRecord: '',
              orderByDirection: OrderByDirection.desc,
              filterByClosed: true,
              filterByOpen: true,
            ),
          ),
          IssuesListState(
            status: IssuesListStatus.error,
            issues: const [],
            hasNextPage: false,
            filter: IssueFilter.initial().copyWith(
              afterRecord: '',
              orderByDirection: OrderByDirection.desc,
              filterByClosed: true,
              filterByOpen: true,
            ),
          ),
        ],
      );
      blocTest<IssuesListBloc, IssuesListState>(
        'LoadIssues emits [loading, loaded] when repository '
        'returns correct value',
        build: () {
          when(
            () => mockRepository.get(
              filter: IssueFilter.initial().copyWith(
                afterRecord: '',
                orderByDirection: OrderByDirection.desc,
                filterByOpen: true,
                filterByClosed: true,
              ),
            ),
          ).thenAnswer(
            (invocation) async => right(
              issuesNavigationFirstPage,
            ),
          );
          return bloc;
        },
        act: (bloc) => bloc.add(
          const LoadIssues(),
        ),
        expect: () => [
          IssuesListState(
            status: IssuesListStatus.loading,
            issues: const [],
            hasNextPage: true,
            filter: IssueFilter.initial().copyWith(
              afterRecord: '',
              orderByDirection: OrderByDirection.desc,
              filterByClosed: true,
              filterByOpen: true,
            ),
          ),
          IssuesListState(
            status: IssuesListStatus.loaded,
            issues: issuesFirstPage,
            hasNextPage: true,
            filter: IssueFilter.initial().copyWith(
              afterRecord: '123456789',
              orderByDirection: OrderByDirection.desc,
              filterByClosed: true,
              filterByOpen: true,
            ),
          ),
        ],
      );
    },
  );

  group(
    'LoadNextPageIssues',
    () {
      blocTest<IssuesListBloc, IssuesListState>(
        'LoadNextPageIssues emits nothing when no more pages',
        build: () {
          return bloc;
        },
        seed: () => IssuesListState(
          status: IssuesListStatus.loaded,
          issues: issuesFirstPage,
          hasNextPage: false,
          filter: IssueFilter.initial().copyWith(
            afterRecord: '',
            orderByDirection: OrderByDirection.asc,
            filterByClosed: true,
            filterByOpen: true,
          ),
        ),
        act: (bloc) => bloc.add(
          const LoadNextPageIssues(),
        ),
        expect: () => <IssuesListState>[],
      );
      blocTest<IssuesListBloc, IssuesListState>(
        'LoadNextPageIssues emits [loading, error] when repository '
        'returns event',
        build: () {
          when(
            () => mockRepository.get(
              filter: IssueFilter.initial().copyWith(
                afterRecord: '1234567890',
                orderByDirection: OrderByDirection.asc,
                filterByOpen: true,
                filterByClosed: true,
              ),
            ),
          ).thenAnswer(
            (invocation) async => left(
              const IssuesFailure(),
            ),
          );
          return bloc;
        },
        seed: () => IssuesListState(
          status: IssuesListStatus.loaded,
          issues: issuesFirstPage,
          hasNextPage: true,
          filter: IssueFilter.initial().copyWith(
            afterRecord: '1234567890',
            orderByDirection: OrderByDirection.asc,
            filterByClosed: true,
            filterByOpen: true,
          ),
        ),
        act: (bloc) => bloc.add(
          const LoadNextPageIssues(),
        ),
        expect: () => [
          IssuesListState(
            status: IssuesListStatus.updatingList,
            issues: issuesFirstPage,
            hasNextPage: true,
            filter: IssueFilter.initial().copyWith(
              afterRecord: '1234567890',
              orderByDirection: OrderByDirection.asc,
              filterByClosed: true,
              filterByOpen: true,
            ),
          ),
          IssuesListState(
            status: IssuesListStatus.error,
            issues: issuesFirstPage,
            hasNextPage: true,
            filter: IssueFilter.initial().copyWith(
              afterRecord: '1234567890',
              orderByDirection: OrderByDirection.asc,
              filterByClosed: true,
              filterByOpen: true,
            ),
          ),
        ],
      );
      blocTest<IssuesListBloc, IssuesListState>(
        'LoadNextPageIssues emits [loading, loaded] when repository '
        'returns correct value',
        build: () {
          when(
            () => mockRepository.get(
              filter: IssueFilter.initial().copyWith(
                afterRecord: '1234567890',
                orderByDirection: OrderByDirection.asc,
                filterByOpen: true,
                filterByClosed: true,
              ),
            ),
          ).thenAnswer(
            (invocation) async => right(
              issuesNavigationSecondPage,
            ),
          );
          return bloc;
        },
        act: (bloc) => bloc.add(
          const LoadNextPageIssues(),
        ),
        seed: () => IssuesListState(
          status: IssuesListStatus.loaded,
          issues: issuesFirstPage,
          hasNextPage: true,
          filter: IssueFilter.initial().copyWith(
            afterRecord: '1234567890',
            orderByDirection: OrderByDirection.asc,
            filterByClosed: true,
            filterByOpen: true,
          ),
        ),
        expect: () => [
          IssuesListState(
            status: IssuesListStatus.updatingList,
            issues: issuesFirstPage,
            hasNextPage: true,
            filter: IssueFilter.initial().copyWith(
              afterRecord: '1234567890',
              orderByDirection: OrderByDirection.asc,
              filterByClosed: true,
              filterByOpen: true,
            ),
          ),
          IssuesListState(
            status: IssuesListStatus.loaded,
            issues: issuesAllPages,
            hasNextPage: false,
            filter: IssueFilter.initial().copyWith(
              afterRecord: '',
              orderByDirection: OrderByDirection.asc,
              filterByClosed: true,
              filterByOpen: true,
            ),
          ),
        ],
      );
    },
  );
  group('Mark Issue as Visited', () {
    blocTest<IssuesListBloc, IssuesListState>(
      'MarkIssueAsVisited emits [updatingList, loaded] whit issue updated',
      build: () {
        return bloc;
      },
      act: (bloc) => bloc.add(
        const MarkIssueAsVisited(issue: issue),
      ),
      seed: () => IssuesListState(
        status: IssuesListStatus.loaded,
        issues: const [issue],
        hasNextPage: true,
        filter: IssueFilter.initial().copyWith(
          afterRecord: '1234567890',
          orderByDirection: OrderByDirection.asc,
          filterByClosed: true,
          filterByOpen: true,
        ),
      ),
      expect: () => [
        IssuesListState(
          status: IssuesListStatus.updatingList,
          issues: const [issue],
          hasNextPage: true,
          filter: IssueFilter.initial().copyWith(
            afterRecord: '1234567890',
            orderByDirection: OrderByDirection.asc,
            filterByClosed: true,
            filterByOpen: true,
          ),
        ),
        IssuesListState(
          status: IssuesListStatus.loaded,
          issues: [
            issue.copyWith(visited: true),
          ],
          hasNextPage: true,
          filter: IssueFilter.initial().copyWith(
            afterRecord: '1234567890',
            orderByDirection: OrderByDirection.asc,
            filterByClosed: true,
            filterByOpen: true,
          ),
        ),
      ],
    );
  });
  group('UpdateFilter', () {
    blocTest<IssuesListBloc, IssuesListState>(
      'UpdateFilter emits [filter] and call LoadIssues event with event value',
      build: () {
        when(
          () => mockRepository.get(
            filter: IssueFilter.initial().copyWith(
              afterRecord: '1234567890',
              orderByDirection: OrderByDirection.desc,
              filterByClosed: true,
              filterByOpen: true,
            ),
          ),
        ).thenAnswer(
          (invocation) async => right(
            issuesNavigationEmpty,
          ),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(
        UpdateFilter(
          filter: IssueFilter.initial().copyWith(
            afterRecord: '1234567890',
            orderByDirection: OrderByDirection.desc,
            filterByClosed: true,
            filterByOpen: true,
          ),
        ),
      ),
      seed: () => IssuesListState(
        status: IssuesListStatus.loaded,
        issues: [
          issue.copyWith(visited: true),
        ],
        hasNextPage: true,
        filter: IssueFilter.initial(),
      ),
      expect: () => [
        IssuesListState(
          status: IssuesListStatus.loaded,
          issues: [
            issue.copyWith(visited: true),
          ],
          hasNextPage: true,
          filter: IssueFilter.initial().copyWith(
            afterRecord: '1234567890',
            orderByDirection: OrderByDirection.desc,
            filterByClosed: true,
            filterByOpen: true,
          ),
        ),
        IssuesListState(
          status: IssuesListStatus.loading,
          issues: const [],
          hasNextPage: true,
          filter: IssueFilter.initial().copyWith(
            afterRecord: '1234567890',
            orderByDirection: OrderByDirection.desc,
            filterByClosed: true,
            filterByOpen: true,
          ),
        ),
        IssuesListState(
          status: IssuesListStatus.loaded,
          issues: const [],
          hasNextPage: false,
          filter: IssueFilter.initial().copyWith(
            afterRecord: '',
            orderByDirection: OrderByDirection.desc,
            filterByClosed: true,
            filterByOpen: true,
          ),
        ),
      ],
    );
  });
  group('Events', () {
    test('LoadIssues is Equatable', () {
      const event = LoadIssues();
      expect(
        event,
        isA<Equatable>(),
      );
      expect(
        event.props,
        <Object?>[],
      );
    });
    test('LoadNextPageIssues is Equatable', () {
      const event = LoadNextPageIssues();
      expect(
        event,
        isA<Equatable>(),
      );
      expect(
        event.props,
        <Object?>[],
      );
    });
    test('MarkIssueAsVisited is Equatable', () {
      const event = MarkIssueAsVisited(issue: issue);
      expect(
        event,
        isA<Equatable>(),
      );
      expect(
        event.props,
        [
          issue,
        ],
      );
    });
    test('UpdateFilter is Equatable', () {
      final event = UpdateFilter(
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
