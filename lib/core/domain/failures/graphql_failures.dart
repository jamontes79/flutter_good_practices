import 'package:flutter_good_practices/core/domain/failures/failures.dart';

class GraphQLFailure extends Failure {
  const GraphQLFailure(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
