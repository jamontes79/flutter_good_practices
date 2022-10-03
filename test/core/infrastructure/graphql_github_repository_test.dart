import 'package:flutter_good_practices/core/domain/failures/graphql_failures.dart';
import 'package:flutter_good_practices/core/domain/models/mm_reponse.dart';
import 'package:flutter_good_practices/core/infrastructure/graphql_github_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mocktail/mocktail.dart';

class MockGraphQLClient extends Mock implements GraphQLClient {}

void main() {
  late GraphQLGithubRepository repository;
  late GraphQLClient mockGraphQLClient;
  const query = r'''
         query ($after: String, $orderBy: OrderDirection!){ 
  repository(owner:"flutter", name:"flutter") { 
    issues(
    first:30, states:[OPEN, CLOSED], after: $after, 
    orderBy:  {field: CREATED_AT, direction: $orderBy}  
    ) {
    pageInfo {
      hasNextPage
      endCursor
    }
       edges {
         cursor
         node {
            id 
            title
            url
            number
            state
            author {
              url
            }
        }
      }
    }
  }
}
  ''';
  setUp(() {
    mockGraphQLClient = MockGraphQLClient();
    repository = GraphQLGithubRepository(mockGraphQLClient);
  });
  test(
    'performQuery returns left with failure when client throws exception',
    () async {
      final options = QueryOptions(
        document: gql(query),
      );
      when(
        () => mockGraphQLClient.query(options),
      ).thenThrow(
        Exception('message'),
      );
      final failureOrResponse = await repository.performQuery(
        query,
        variables: {},
      );
      failureOrResponse.fold(
        (l) => expect(
          l,
          isA<GraphQLFailure>(),
        ),
        (r) => expect(true, false, reason: 'Expecting left side'),
      );
    },
  );
  test(
    'performQuery returns right with MMResponse failure when '
    'client has exception in result',
    () async {
      final options = QueryOptions(
        document: gql(query),
      );
      when(
        () => mockGraphQLClient.query(options),
      ).thenAnswer(
        (_) async => QueryResult(
          options: options,
          source: QueryResultSource.cache,
          exception: OperationException(),
        ),
      );
      final failureOrResponse = await repository.performQuery(
        query,
        variables: {},
      );
      failureOrResponse.fold(
        (l) => expect(
          l,
          isA<GraphQLFailure>(),
        ),
        (r) => expect(true, false, reason: 'Expecting left side'),
      );
    },
  );
  test(
    'performQuery returns right with MMResponse correct when '
    'client returns correct response',
    () async {
      final options = QueryOptions(
        document: gql(query),
      );
      when(
        () => mockGraphQLClient.query(options),
      ).thenAnswer(
        (_) async => QueryResult(
          options: options,
          source: QueryResultSource.cache,
          data: {'key': 'value'},
        ),
      );
      final failureOrResponse = await repository.performQuery(
        query,
        variables: {},
      );
      failureOrResponse.fold(
        (l) => expect(true, false, reason: 'Expecting right side'),
        (r) => expect(
          r,
          const MMResponse(
            correct: true,
            response: {'key': 'value'},
          ),
        ),
      );
    },
  );
}
