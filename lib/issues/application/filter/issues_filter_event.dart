part of 'issues_filter_bloc.dart';

abstract class IssuesFilterEvent extends Equatable {
  const IssuesFilterEvent();
}

class InitFilter extends IssuesFilterEvent {
  const InitFilter({required this.filter});
  final IssueFilter filter;
  @override
  List<Object?> get props => [
        filter,
      ];
}

class ChangeOrderByMode extends IssuesFilterEvent {
  const ChangeOrderByMode({required this.ascending});
  final bool ascending;
  @override
  List<Object?> get props => [
        ascending,
      ];
}

class ChangeFilterByOpen extends IssuesFilterEvent {
  const ChangeFilterByOpen({required this.filterByOpen});
  final bool filterByOpen;
  @override
  List<Object?> get props => [
        filterByOpen,
      ];
}

class ChangeFilterByClosed extends IssuesFilterEvent {
  const ChangeFilterByClosed({required this.filterByClosed});
  final bool filterByClosed;
  @override
  List<Object?> get props => [
        filterByClosed,
      ];
}
