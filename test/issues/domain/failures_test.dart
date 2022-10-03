import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_good_practices/issues/domain/models/failures.dart';

void main() {
  test('IssuesFailure is Equatable', () {
    const failure = IssuesFailure();
    expect(
      failure,
      isA<Equatable>(),
    );
    expect(
      failure.props,
      <Object?>[],
    );
  });
}
