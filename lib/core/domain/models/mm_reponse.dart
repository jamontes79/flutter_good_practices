import 'package:equatable/equatable.dart';

class MMResponse extends Equatable {
  const MMResponse({
    required this.correct,
    required this.response,
    this.errorMessage,
  });

  final bool correct;
  final String? errorMessage;
  final Map<String, dynamic> response;

  @override
  List<Object?> get props => [
        correct,
        errorMessage,
        response,
      ];
}
