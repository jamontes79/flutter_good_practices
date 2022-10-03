import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_good_practices/core/domain/failures/graphql_failures.dart';

void main() {
  test('GraphQLFailure is Equatable', () {
    const failure = GraphQLFailure('message');
    expect(
      failure,
      isA<Equatable>(),
    );
    expect(
      failure.props,
      [
        'message',
      ],
    );
  });
}
