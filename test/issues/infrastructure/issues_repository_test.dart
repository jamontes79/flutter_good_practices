import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_good_practices/core/domain/failures/graphql_failures.dart';
import 'package:flutter_good_practices/core/domain/models/mm_reponse.dart';
import 'package:flutter_good_practices/core/domain/use_cases/i_github_repository.dart';
import 'package:flutter_good_practices/issues/domain/models/failures.dart';
import 'package:flutter_good_practices/issues/domain/models/issue.dart';
import 'package:flutter_good_practices/issues/domain/models/issue_filter.dart';
import 'package:flutter_good_practices/issues/domain/models/issues_navigation.dart';
import 'package:flutter_good_practices/issues/domain/use_cases/i_issues_repository.dart';
import 'package:flutter_good_practices/issues/infrastructure/issues_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockGithubRepository extends Mock implements IGithubRepository {}

void main() {
  late IGithubRepository mockGithubRepository;
  late IssuesRepository issuesRepository;
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
  setUp(() {
    mockGithubRepository = MockGithubRepository();
    issuesRepository = IssuesRepository(mockGithubRepository);
  });

  test('get without afterRecord returns left when performQuery returns left',
      () async {
    when(
      () => mockGithubRepository.performQuery(
        query,
        variables: {
          'orderBy': 'DESC',
          'states': ['OPEN', 'CLOSED'],
        },
      ),
    ).thenAnswer(
      (invocation) async => left(
        const GraphQLFailure('message'),
      ),
    );
    final failureOrIssuesNavigation = await issuesRepository.get(
      filter: IssueFilter.initial().copyWith(
        afterRecord: '',
        orderByDirection: OrderByDirection.desc,
        filterByOpen: true,
        filterByClosed: true,
      ),
    );

    failureOrIssuesNavigation.fold(
      (l) => expect(
        l,
        isA<IssuesFailure>(),
      ),
      (r) => expect(
        true,
        false,
        reason: 'Expecting left side',
      ),
    );
  });
  test('get with afterRecord returns left when performQuery returns left',
      () async {
    when(
      () => mockGithubRepository.performQuery(
        query,
        variables: {
          'after': '1234567890',
          'orderBy': 'DESC',
          'states': ['OPEN', 'CLOSED'],
        },
      ),
    ).thenAnswer(
      (invocation) async => left(
        const GraphQLFailure('message'),
      ),
    );
    final failureOrIssuesNavigation = await issuesRepository.get(
      filter: IssueFilter.initial().copyWith(
        afterRecord: '1234567890',
        orderByDirection: OrderByDirection.desc,
        filterByOpen: true,
        filterByClosed: true,
      ),
    );

    failureOrIssuesNavigation.fold(
      (l) => expect(
        l,
        isA<IssuesFailure>(),
      ),
      (r) => expect(
        true,
        false,
        reason: 'Expecting left side',
      ),
    );
  });

  test(
      'get with afterRecord returns right IssuesNavigation when performQuery '
      'returns correct value', () async {
    when(
      () => mockGithubRepository.performQuery(
        query,
        variables: {
          'after': '1234567890',
          'orderBy': 'ASC',
          'states': ['OPEN'],
        },
      ),
    ).thenAnswer(
      (invocation) async => right(
        const MMResponse(
          correct: true,
          response: {
            'repository': {
              'issues': {
                'pageInfo': {
                  'hasNextPage': true,
                  'endCursor': 'Y3Vyc29yOnYyOpHOCjjuyQ=='
                },
                'edges': [
                  {
                    'cursor': 'Y3Vyc29yOnYyOpHOCW4C6g==',
                    'node': {
                      'id': 'MDU6SXNzdWUxNTgyMDQ2NTA=',
                      'title':
                          'Provide a "flutter shutdown" command to shut down '
                              'resident deamons',
                      'url': 'https://github.com/flutter/flutter/issues/4325',
                      'number': 4325,
                      'state': 'OPEN',
                      'author': {'url': 'https://github.com/yjbanov'}
                    }
                  },
                  {
                    'cursor': 'Y3Vyc29yOnYyOpHOCXFW4g==',
                    'node': {
                      'id': 'MDU6SXNzdWUxNTg0MjI3NTQ=',
                      'title': 'Does flutter need to clean up crash logs at '
                          'some point?',
                      'url': 'https://github.com/flutter/flutter/issues/4353',
                      'number': 4353,
                      'state': 'OPEN',
                      'author': {'url': 'https://github.com/eseidelGoogle'}
                    }
                  },
                ]
              },
            },
          },
          errorMessage: '',
        ),
      ),
    );
    final failureOrIssuesNavigation = await issuesRepository.get(
      filter: IssueFilter.initial().copyWith(
        afterRecord: '1234567890',
        orderByDirection: OrderByDirection.asc,
        filterByClosed: false,
        filterByOpen: true,
      ),
    );

    failureOrIssuesNavigation.fold(
      (l) => expect(
        true,
        false,
        reason: 'Expecting right side',
      ),
      (r) => expect(
        r,
        const IssuesNavigation(
          hasNextPage: true,
          endCursor: 'Y3Vyc29yOnYyOpHOCjjuyQ==',
          issues: [
            Issue(
              id: 'MDU6SXNzdWUxNTgyMDQ2NTA=',
              title: 'Provide a "flutter shutdown" command to shut down '
                  'resident deamons',
              number: 4325,
              state: 'OPEN',
              url: 'https://github.com/flutter/flutter/issues/4325',
            ),
            Issue(
              id: 'MDU6SXNzdWUxNTg0MjI3NTQ=',
              title: 'Does flutter need to clean up crash logs at '
                  'some point?',
              number: 4353,
              state: 'OPEN',
              url: 'https://github.com/flutter/flutter/issues/4353',
            ),
          ],
        ),
      ),
    );
  });
}
