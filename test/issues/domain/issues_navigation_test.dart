import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_good_practices/issues/domain/models/issue.dart';
import 'package:flutter_good_practices/issues/domain/models/issues_navigation.dart';

void main() {
  test('IssuesNavigation is Equatable', () {
    const issue = Issue(
      id: 'id',
      title: 'title',
      number: 1,
      state: 'state',
      url: 'url',
    );
    const issuesNavigation = IssuesNavigation(
      issues: [
        issue,
      ],
      hasNextPage: true,
      endCursor: '123456789',
    );
    expect(
      issuesNavigation,
      isA<Equatable>(),
    );
    expect(
      issuesNavigation.props,
      [
        [
          issue,
        ],
        true,
        '123456789',
      ],
    );
  });
}
