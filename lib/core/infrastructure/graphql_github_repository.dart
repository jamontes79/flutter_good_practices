import 'package:dartz/dartz.dart';
import 'package:graphql/client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_good_practices/core/domain/failures/graphql_failures.dart';
import 'package:flutter_good_practices/core/domain/models/mm_reponse.dart';
import 'package:flutter_good_practices/core/domain/use_cases/i_github_repository.dart';

@LazySingleton(
  as: IGithubRepository,
  env: [
    Environment.dev,
    Environment.prod,
  ],
)
class GraphQLGithubRepository implements IGithubRepository {
  GraphQLGithubRepository(this.graphQLClient);

  final GraphQLClient graphQLClient;

  @override
  Future<Either<GraphQLFailure, MMResponse>> performQuery(
    String query, {
    required Map<String, dynamic> variables,
  }) async {
    try {
      final options = QueryOptions(
        document: gql(query),
        variables: variables,
      );

      final result = await graphQLClient.query(options);

      if (result.hasException) {
        return left(
          GraphQLFailure(
            result.exception.toString(),
          ),
        );
      } else {
        return right(
          MMResponse(
            correct: true,
            response: result.data ?? {},
          ),
        );
      }
    } on Exception catch (_, e) {
      return left(
        GraphQLFailure(
          e.toString(),
        ),
      );
    }
  }
}
