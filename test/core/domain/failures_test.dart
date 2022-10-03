import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_good_practices/core/domain/failures/failures.dart';

void main() {
  test('Generic Failure is Equatable', () {
    const failure = GenericFailure();
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
