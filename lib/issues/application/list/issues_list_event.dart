part of 'issues_list_bloc.dart';

abstract class IssuesListEvent extends Equatable {
  const IssuesListEvent();
}

class LoadIssues extends IssuesListEvent {
  const LoadIssues();

  @override
  List<Object?> get props => [];
}

class LoadNextPageIssues extends IssuesListEvent {
  const LoadNextPageIssues();

  @override
  List<Object?> get props => [];
}

class MarkIssueAsVisited extends IssuesListEvent {
  const MarkIssueAsVisited({required this.issue});
  final Issue issue;
  @override
  List<Object?> get props => [
        issue,
      ];
}

class UpdateFilter extends IssuesListEvent {
  const UpdateFilter({required this.filter});
  final IssueFilter filter;
  @override
  List<Object?> get props => [
        filter,
      ];
}
