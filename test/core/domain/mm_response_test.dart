import 'package:equatable/equatable.dart';
import 'package:flutter_good_practices/core/domain/models/mm_reponse.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('MMResponse is Equatable', () {
    const response = MMResponse(
      correct: true,
      response: {'response': 'data'},
      errorMessage: 'error',
    );
    expect(
      response,
      isA<Equatable>(),
    );
    expect(
      response.props,
      [
        true,
        'error',
        {'response': 'data'},
      ],
    );
  });
}
