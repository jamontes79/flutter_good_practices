import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AppGraphQLClientModule {
  @lazySingleton
  GraphQLClient get graphQLClient {
    final token = FlavorConfig.instance.variables['github_token'] as String;
    final link = HttpLink(
      'https://api.github.com/graphql',
      defaultHeaders: {
        'Authorization': 'bearer $token',
      },
    );
    return GraphQLClient(
      link: link,
      cache: GraphQLCache(
        store: InMemoryStore(),
      ),
    );
  }
}
