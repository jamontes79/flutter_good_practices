part of 'issues_filter_bloc.dart';

class IssuesFilterState extends Equatable {
  const IssuesFilterState({
    required this.filter,
  });

  final IssueFilter filter;

  IssuesFilterState copyWith({
    required IssueFilter filter,
  }) {
    return IssuesFilterState(
      filter: filter,
    );
  }

  @override
  List<Object> get props => [
        filter,
      ];
}
