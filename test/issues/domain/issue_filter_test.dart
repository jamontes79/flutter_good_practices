import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_good_practices/issues/domain/models/issue_filter.dart';
import 'package:flutter_good_practices/issues/domain/use_cases/i_issues_repository.dart';

void main() {
  test('IssueFilter is Equatable', () {
    final filter = IssueFilter.initial().copyWith(
      afterRecord: '',
      orderByDirection: OrderByDirection.desc,
      filterByOpen: true,
      filterByClosed: true,
    );
    expect(
      filter,
      isA<Equatable>(),
    );
    expect(
      filter.props,
      [
        '',
        OrderByDirection.desc,
        true,
        true,
      ],
    );
  });
  test(
    'IssueFilter toJSON returns correct object when afterRecord is empty',
    () {
      final filter = IssueFilter.initial().copyWith(
        afterRecord: '',
        orderByDirection: OrderByDirection.desc,
        filterByOpen: true,
        filterByClosed: true,
      );
      expect(
        filter.toJSON(),
        {
          'orderBy': 'DESC',
          'states': ['OPEN', 'CLOSED'],
        },
      );
    },
  );
  test(
    'IssueFilter toJSON returns correct object when afterRecord is NOT empty',
    () {
      final filter = IssueFilter.initial().copyWith(
        afterRecord: '1234567890',
        orderByDirection: OrderByDirection.desc,
        filterByOpen: true,
        filterByClosed: true,
      );
      expect(
        filter.toJSON(),
        {
          'orderBy': 'DESC',
          'states': ['OPEN', 'CLOSED'],
          'after': '1234567890'
        },
      );
    },
  );
  test(
    'IssueFilter toJSON returns correct object when only filter by closed',
    () {
      final filter = IssueFilter.initial().copyWith(
        afterRecord: '1234567890',
        orderByDirection: OrderByDirection.desc,
        filterByOpen: false,
        filterByClosed: true,
      );
      expect(
        filter.toJSON(),
        {
          'orderBy': 'DESC',
          'states': ['CLOSED'],
          'after': '1234567890'
        },
      );
    },
  );
  test(
    'IssueFilter toJSON returns correct object when only filter by open',
    () {
      final filter = IssueFilter.initial().copyWith(
        afterRecord: '1234567890',
        orderByDirection: OrderByDirection.desc,
        filterByOpen: true,
        filterByClosed: false,
      );
      expect(
        filter.toJSON(),
        {
          'orderBy': 'DESC',
          'states': ['OPEN'],
          'after': '1234567890'
        },
      );
    },
  );
}
