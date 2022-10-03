import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure();
}

class GenericFailure extends Failure {
  const GenericFailure();

  @override
  List<Object?> get props => [];
}
