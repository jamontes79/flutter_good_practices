part of 'issues_list_bloc.dart';

enum IssuesListStatus {
  initial,
  loading,
  loaded,
  updatingList,
  error,
}

class IssuesListState extends Equatable {
  const IssuesListState({
    required this.status,
    required this.issues,
    required this.hasNextPage,
    required this.filter,
  });
  final IssuesListStatus status;
  final List<Issue> issues;
  final bool hasNextPage;
  final IssueFilter filter;

  IssuesListState copyWith({
    IssuesListStatus? status,
    List<Issue>? issues,
    bool? hasNextPage,
    IssueFilter? filter,
  }) {
    return IssuesListState(
      status: status ?? this.status,
      issues: issues ?? this.issues,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object> get props => [
        status,
        issues,
        hasNextPage,
        filter,
      ];
}
