import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_good_practices/issues/domain/models/issue.dart';

void main() {
  test('Issue is Equatable', () {
    const issue = Issue(
      id: 'id',
      title: 'title',
      number: 1,
      state: 'state',
      url: 'url',
      visited: true,
    );
    expect(
      issue,
      isA<Equatable>(),
    );
    expect(
      issue.props,
      [
        'id',
        'title',
        1,
        'state',
        'url',
        true,
      ],
    );
  });
  test(
    'Issue fromJSON returns correct object',
    () {
      const issue = Issue(
        id: 'id',
        title: 'title',
        number: 1,
        state: 'state',
        url: 'url',
      );
      expect(
        Issue.fromJSON(
          const {
            'id': 'id',
            'title': 'title',
            'number': 1,
            'state': 'state',
            'url': 'url',
          },
        ),
        issue,
      );
    },
  );
}
