import 'package:equatable/equatable.dart';
import 'package:flutter_good_practices/issues/domain/use_cases/i_issues_repository.dart';

class IssueFilter extends Equatable {
  const IssueFilter._({
    required this.afterRecord,
    required this.orderByDirection,
    required this.filterByOpen,
    required this.filterByClosed,
  });

  factory IssueFilter.initial() => const IssueFilter._(
        afterRecord: '',
        orderByDirection: OrderByDirection.desc,
        filterByClosed: true,
        filterByOpen: true,
      );
  final String afterRecord;
  final OrderByDirection orderByDirection;
  final bool filterByOpen;
  final bool filterByClosed;

  IssueFilter copyWith({
    String? afterRecord,
    OrderByDirection? orderByDirection,
    bool? filterByOpen,
    bool? filterByClosed,
  }) {
    return IssueFilter._(
      afterRecord: afterRecord ?? this.afterRecord,
      orderByDirection: orderByDirection ?? this.orderByDirection,
      filterByClosed: filterByClosed ?? this.filterByClosed,
      filterByOpen: filterByOpen ?? this.filterByOpen,
    );
  }

  Map<String, dynamic> toJSON() {
    final states = <String>[];
    if (filterByOpen) {
      states.add('OPEN');
    }
    if (filterByClosed) {
      states.add('CLOSED');
    }
    final json = <String, dynamic>{
      'orderBy': orderByDirection == OrderByDirection.asc ? 'ASC' : 'DESC',
      'states': states
    };
    if (afterRecord.isNotEmpty) {
      json.addAll(
        {'after': afterRecord},
      );
    }
    return json;
  }

  @override
  List<Object?> get props => [
        afterRecord,
        orderByDirection,
        filterByOpen,
        filterByClosed,
      ];
}
