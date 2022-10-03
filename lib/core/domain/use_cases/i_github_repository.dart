import 'package:dartz/dartz.dart';
import 'package:flutter_good_practices/core/domain/failures/graphql_failures.dart';
import 'package:flutter_good_practices/core/domain/models/mm_reponse.dart';

abstract class IGithubRepository {
  Future<Either<GraphQLFailure, MMResponse>> performQuery(
    String query, {
    required Map<String, dynamic> variables,
  });
}
