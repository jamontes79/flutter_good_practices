import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_good_practices/issues/domain/models/issue.dart';
import 'package:flutter_good_practices/issues/domain/models/issue_filter.dart';
import 'package:flutter_good_practices/issues/domain/use_cases/i_issues_repository.dart';

part 'issues_list_event.dart';
part 'issues_list_state.dart';

@injectable
class IssuesListBloc extends Bloc<IssuesListEvent, IssuesListState> {
  IssuesListBloc(this._repository)
      : super(
          IssuesListState(
            status: IssuesListStatus.initial,
            issues: const [],
            hasNextPage: true,
            filter: IssueFilter.initial(),
          ),
        ) {
    on<LoadIssues>(_onLoadIssues);
    on<LoadNextPageIssues>(_onLoadNextPageIssues);
    on<MarkIssueAsVisited>(_onMarkIssueAsVisited);
    on<UpdateFilter>(_onUpdateFilter);
  }

  final IIssuesRepository _repository;
  Future<FutureOr<void>> _onLoadIssues(
    LoadIssues event,
    Emitter<IssuesListState> emit,
  ) async {
    emit(
      state.copyWith(
        status: IssuesListStatus.loading,
        issues: [],
      ),
    );
    final failureOrIssues = await _repository.get(
      filter: state.filter,
    );
    emit(
      failureOrIssues.fold(
        (l) => state.copyWith(
          status: IssuesListStatus.error,
          hasNextPage: false,
        ),
        (issuesNavigation) => state.copyWith(
          status: IssuesListStatus.loaded,
          issues: issuesNavigation.issues,
          filter: state.filter.copyWith(
            afterRecord: issuesNavigation.endCursor,
          ),
          hasNextPage: issuesNavigation.hasNextPage,
        ),
      ),
    );
  }

  Future<FutureOr<void>> _onLoadNextPageIssues(
    LoadNextPageIssues event,
    Emitter<IssuesListState> emit,
  ) async {
    if (state.hasNextPage) {
      emit(
        state.copyWith(
          status: IssuesListStatus.updatingList,
        ),
      );
      final failureOrIssues = await _repository.get(
        filter: state.filter,
      );

      failureOrIssues.fold(
        (l) => emit(
          state.copyWith(
            status: IssuesListStatus.error,
          ),
        ),
        (issuesNavigation) {
          final newIssues = state.issues..addAll(issuesNavigation.issues);

          emit(
            state.copyWith(
              status: IssuesListStatus.loaded,
              filter: state.filter.copyWith(
                afterRecord: issuesNavigation.endCursor,
              ),
              hasNextPage: issuesNavigation.hasNextPage,
              issues: newIssues,
            ),
          );
        },
      );
    }
  }

  Future<FutureOr<void>> _onMarkIssueAsVisited(
    MarkIssueAsVisited event,
    Emitter<IssuesListState> emit,
  ) async {
    emit(
      state.copyWith(
        status: IssuesListStatus.updatingList,
      ),
    );

    final issueVisited = event.issue.copyWith(
      visited: true,
    );
    final indexIssue = state.issues.indexOf(event.issue);

    final issuesUpdated = <Issue>[];
    state.issues.forEach(issuesUpdated.add);
    issuesUpdated
      ..removeAt(
        indexIssue,
      )
      ..insert(
        indexIssue,
        issueVisited,
      );

    emit(
      state.copyWith(
        status: IssuesListStatus.loaded,
        issues: issuesUpdated,
      ),
    );
  }

  FutureOr<void> _onUpdateFilter(
    UpdateFilter event,
    Emitter<IssuesListState> emit,
  ) {
    emit(
      state.copyWith(
        filter: event.filter,
      ),
    );
    add(
      const LoadIssues(),
    );
  }
}
