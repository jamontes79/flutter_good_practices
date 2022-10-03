import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_good_practices/core/domain/failures/failures.dart';
import 'package:flutter_good_practices/core/domain/use_cases/i_github_repository.dart';
import 'package:flutter_good_practices/issues/domain/models/failures.dart';
import 'package:flutter_good_practices/issues/domain/models/issue.dart';
import 'package:flutter_good_practices/issues/domain/models/issue_filter.dart';
import 'package:flutter_good_practices/issues/domain/models/issues_navigation.dart';
import 'package:flutter_good_practices/issues/domain/use_cases/i_issues_repository.dart';

@LazySingleton(
  as: IIssuesRepository,
)
class IssuesRepository implements IIssuesRepository {
  IssuesRepository(this._repository);

  final IGithubRepository _repository;
  @override
  Future<Either<Failure, IssuesNavigation>> get({
    required IssueFilter filter,
  }) async {
    const query = r'''
         query ($after: String, $orderBy: OrderDirection!,$states: [IssueState!]
        ){ 
  repository(owner:"flutter", name:"flutter") { 
    issues(
    first:30, states:$states, after: $after, 
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

    final response = await _repository.performQuery(
      query,
      variables: filter.toJSON(),
    );

    return response.fold(
      (l) => left(
        const IssuesFailure(),
      ),
      (r) {
        final repository = r.response['repository'] as Map<String, dynamic>;
        final issues = repository['issues'] as Map<String, dynamic>;
        final pageInfo = issues['pageInfo'] as Map<String, dynamic>;
        final edges = issues['edges'] as List<dynamic>;
        final issuesList = edges.map((e) {
          final json = e as Map<String, dynamic>;
          final node = json['node'];

          return Issue.fromJSON(
            node as Map<String, dynamic>,
          );
        }).toList();

        final issuesNavigation = IssuesNavigation(
          issues: issuesList,
          hasNextPage: pageInfo['hasNextPage'] as bool,
          endCursor: (pageInfo['endCursor'] as String?) ?? '',
        );
        return right(
          issuesNavigation,
        );
      },
    );
  }
}
