import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_good_practices/core/domain/failures/graphql_failures.dart';
import 'package:flutter_good_practices/core/domain/models/mm_reponse.dart';
import 'package:flutter_good_practices/core/domain/use_cases/i_github_repository.dart';

@LazySingleton(
  as: IGithubRepository,
  env: [
    Environment.test,
  ],
)
class FakeGraphQLGithubRepository implements IGithubRepository {
  const FakeGraphQLGithubRepository();

  @override
  Future<Either<GraphQLFailure, MMResponse>> performQuery(
    String query, {
    required Map<String, dynamic> variables,
  }) async {
    return right(
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
                {
                  'cursor': 'Y3Vyc29yOnYyOpHOCXIP-g==',
                  'node': {
                    'id': 'MDU6SXNzdWUxNTg0NzAxMzg=',
                    'title': 'Update compile flags per security review',
                    'url': 'https://github.com/flutter/flutter/issues/4368',
                    'number': 4368,
                    'state': 'OPEN',
                    'author': {'url': 'https://github.com/eseidelGoogle'}
                  }
                },
                {
                  'cursor': 'Y3Vyc29yOnYyOpHOCXI4eQ==',
                  'node': {
                    'id': 'MDU6SXNzdWUxNTg0ODA1MDU=',
                    'title':
                        "DropdownButton doesn't animate newly selected value ",
                    'url': 'https://github.com/flutter/flutter/issues/4378',
                    'number': 4378,
                    'state': 'OPEN',
                    'author': {'url': 'https://github.com/Hixie'}
                  }
                },
                {
                  'cursor': 'Y3Vyc29yOnYyOpHOCX4HSA==',
                  'node': {
                    'id': 'MDU6SXNzdWUxNTkyNTQzNDQ=',
                    'title':
                        'Should cross-fade the paginated data table header '
                            'when it changes',
                    'url': 'https://github.com/flutter/flutter/issues/4467',
                    'number': 4467,
                    'state': 'OPEN',
                    'author': {'url': 'https://github.com/Hixie'}
                  }
                },
                {
                  'cursor': 'Y3Vyc29yOnYyOpHOCX5LAw==',
                  'node': {
                    'id': 'MDU6SXNzdWUxNTkyNzE2ODM=',
                    'title': 'ScrollingDataTable',
                    'url': 'https://github.com/flutter/flutter/issues/4473',
                    'number': 4473,
                    'state': 'OPEN',
                    'author': {'url': 'https://github.com/Hixie'}
                  }
                },
                {
                  'cursor': 'Y3Vyc29yOnYyOpHOCYpodQ==',
                  'node': {
                    'id': 'MDU6SXNzdWUxNjAwNjU2NTM=',
                    'title': 'Show application version information in the about'
                        ' dialog',
                    'url': 'https://github.com/flutter/flutter/issues/4547',
                    'number': 4547,
                    'state': 'OPEN',
                    'author': {'url': 'https://github.com/drewwarren'}
                  }
                },
                {
                  'cursor': 'Y3Vyc29yOnYyOpHOCZfaNQ==',
                  'node': {
                    'id': 'MDU6SXNzdWUxNjA5NDY3NDE=',
                    'title': 'Vertical text alignment based off last baseline',
                    'url': 'https://github.com/flutter/flutter/issues/4614',
                    'number': 4614,
                    'state': 'OPEN',
                    'author': {'url': 'https://github.com/apwilson'}
                  }
                },
                {
                  'cursor': 'Y3Vyc29yOnYyOpHOCae54g==',
                  'node': {
                    'id': 'MDU6SXNzdWUxNjE5ODcwNDI=',
                    'title': 'flutter test --coverage and flutter test --watch',
                    'url': 'https://github.com/flutter/flutter/issues/4719',
                    'number': 4719,
                    'state': 'OPEN',
                    'author': {'url': 'https://github.com/Hixie'}
                  }
                },
                {
                  'cursor': 'Y3Vyc29yOnYyOpHOCbALDg==',
                  'node': {
                    'id': 'MDU6SXNzdWUxNjI1MzIxMTA=',
                    'title': 'Navigator can still get spurious writes during '
                        'navigation',
                    'url': 'https://github.com/flutter/flutter/issues/4770',
                    'number': 4770,
                    'state': 'OPEN',
                    'author': {'url': 'https://github.com/abarth'}
                  }
                },
                {
                  'cursor': 'Y3Vyc29yOnYyOpHOCbAUjg==',
                  'node': {
                    'id': 'MDU6SXNzdWUxNjI1MzQ1NDI=',
                    'title': 'Enable navigator test that involves pointer '
                        'cancellation',
                    'url': 'https://github.com/flutter/flutter/issues/4771',
                    'number': 4771,
                    'state': 'OPEN',
                    'author': {'url': 'https://github.com/abarth'}
                  }
                },
                {
                  'cursor': 'Y3Vyc29yOnYyOpHOCclF7Q==',
                  'node': {
                    'id': 'MDU6SXNzdWUxNjQxODU1ODE=',
                    'title': 'iOS Accessibility "Button Shapes"',
                    'url': 'https://github.com/flutter/flutter/issues/4826',
                    'number': 4826,
                    'state': 'OPEN',
                    'author': {'url': 'https://github.com/eseidelGoogle'}
                  }
                },
                {
                  'cursor': 'Y3Vyc29yOnYyOpHOCclHjA==',
                  'node': {
                    'id': 'MDU6SXNzdWUxNjQxODU5OTY=',
                    'title': 'iOS Accessibility: Reduce Motion',
                    'url': 'https://github.com/flutter/flutter/issues/4827',
                    'number': 4827,
                    'state': 'OPEN',
                    'author': {'url': 'https://github.com/eseidelGoogle'}
                  }
                },
                {
                  'cursor': 'Y3Vyc29yOnYyOpHOCclYsQ==',
                  'node': {
                    'id': 'MDU6SXNzdWUxNjQxOTAzODU=',
                    'title': 'iOS Accessibility: On/Off labels',
                    'url': 'https://github.com/flutter/flutter/issues/4830',
                    'number': 4830,
                    'state': 'OPEN',
                    'author': {'url': 'https://github.com/eseidelGoogle'}
                  }
                },
                {
                  'cursor': 'Y3Vyc29yOnYyOpHOCdPPqA==',
                  'node': {
                    'id': 'MDU6SXNzdWUxNjQ4NzYyMDA=',
                    'title': 'control-C does not exit app on iOS device from '
                        '`flutter '
                        'run`',
                    'url': 'https://github.com/flutter/flutter/issues/4875',
                    'number': 4875,
                    'state': 'OPEN',
                    'author': {'url': 'https://github.com/eseidelGoogle'}
                  }
                },
                {
                  'cursor': 'Y3Vyc29yOnYyOpHOCeg1jg==',
                  'node': {
                    'id': 'MDU6SXNzdWUxNjYyMTMwMDY=',
                    'title':
                        'Ability to show action options (e.g. Share) from text '
                            'selection menu',
                    'url': 'https://github.com/flutter/flutter/issues/4961',
                    'number': 4961,
                    'state': 'OPEN',
                    'author': {'url': 'https://github.com/sethladd'}
                  }
                },
                {
                  'cursor': 'Y3Vyc29yOnYyOpHOCehEIw==',
                  'node': {
                    'id': 'MDU6SXNzdWUxNjYyMTY3Mzk=',
                    'title': 'Support peek/pop on iOS',
                    'url': 'https://github.com/flutter/flutter/issues/4963',
                    'number': 4963,
                    'state': 'OPEN',
                    'author': {'url': 'https://github.com/sethladd'}
                  }
                },
                {
                  'cursor': 'Y3Vyc29yOnYyOpHOCfWImw==',
                  'node': {
                    'id': 'MDU6SXNzdWUxNjcwODYyMzU=',
                    'title': 'Links from docs to source.',
                    'url': 'https://github.com/flutter/flutter/issues/4999',
                    'number': 4999,
                    'state': 'OPEN',
                    'author': {'url': 'https://github.com/dragostis'}
                  }
                },
                {
                  'cursor': 'Y3Vyc29yOnYyOpHOCfr5Kg==',
                  'node': {
                    'id': 'MDU6SXNzdWUxNjc0NDI3MzA=',
                    'title':
                        'Flutter should offer some way to test at a minimum '
                            'size',
                    'url': 'https://github.com/flutter/flutter/issues/5026',
                    'number': 5026,
                    'state': 'OPEN',
                    'author': {'url': 'https://github.com/eseidelGoogle'}
                  }
                },
                {
                  'cursor': 'Y3Vyc29yOnYyOpHOCftM2A==',
                  'node': {
                    'id': 'MDU6SXNzdWUxNjc0NjQxNTI=',
                    'title': 'Update license collection script to perform line '
                        'wrapping '
                        'and indentation normalization',
                    'url': 'https://github.com/flutter/flutter/issues/5031',
                    'number': 5031,
                    'state': 'OPEN',
                    'author': {'url': 'https://github.com/Hixie'}
                  }
                },
                {
                  'cursor': 'Y3Vyc29yOnYyOpHOCgHmAg==',
                  'node': {
                    'id': 'MDU6SXNzdWUxNjc4OTY1Nzg=',
                    'title':
                        'Material components: Ability to long-press a menu '
                            'icon to open menu, follow finger',
                    'url': 'https://github.com/flutter/flutter/issues/5064',
                    'number': 5064,
                    'state': 'OPEN',
                    'author': {'url': 'https://github.com/sethladd'}
                  }
                },
                {
                  'cursor': 'Y3Vyc29yOnYyOpHOCgIZIQ==',
                  'node': {
                    'id': 'MDU6SXNzdWUxNjc5MDk2NjU=',
                    'title':
                        "Once a drawer is transitioning out, don't let it grab "
                            'taps on its components',
                    'url': 'https://github.com/flutter/flutter/issues/5080',
                    'number': 5080,
                    'state': 'OPEN',
                    'author': {'url': 'https://github.com/sethladd'}
                  }
                },
                {
                  'cursor': 'Y3Vyc29yOnYyOpHOChL5-g==',
                  'node': {
                    'id': 'MDU6SXNzdWUxNjkwMTU4MDI=',
                    'title':
                        'determinate circular progress indicators have wrong '
                            'animation',
                    'url': 'https://github.com/flutter/flutter/issues/5194',
                    'number': 5194,
                    'state': 'OPEN',
                    'author': {'url': 'https://github.com/Hixie'}
                  }
                },
                {
                  'cursor': 'Y3Vyc29yOnYyOpHOChL6sQ==',
                  'node': {
                    'id': 'MDU6SXNzdWUxNjkwMTU5ODU=',
                    'title':
                        'Improve transition from indeterminate to determinate '
                            'circular progress indicators',
                    'url': 'https://github.com/flutter/flutter/issues/5195',
                    'number': 5195,
                    'state': 'OPEN',
                    'author': {'url': 'https://github.com/Hixie'}
                  }
                },
                {
                  'cursor': 'Y3Vyc29yOnYyOpHOCho0oQ==',
                  'node': {
                    'id': 'MDU6SXNzdWUxNjk0ODk1Njk=',
                    'title': 'Dropdown button menu is not repositioned after '
                        'rotating '
                        'the screen',
                    'url': 'https://github.com/flutter/flutter/issues/5240',
                    'number': 5240,
                    'state': 'OPEN',
                    'author': {'url': 'https://github.com/jason-simmons'}
                  }
                },
                {
                  'cursor': 'Y3Vyc29yOnYyOpHOCimzmg==',
                  'node': {
                    'id': 'MDU6SXNzdWUxNzA1MDUxMTQ=',
                    'title': 'No good way to determine who is causing my '
                        'RenderObject to paint (without markNeedsPaint being '
                        'called)',
                    'url': 'https://github.com/flutter/flutter/issues/5324',
                    'number': 5324,
                    'state': 'OPEN',
                    'author': {'url': 'https://github.com/apwilson'}
                  }
                },
                {
                  'cursor': 'Y3Vyc29yOnYyOpHOCinMzw==',
                  'node': {
                    'id': 'MDU6SXNzdWUxNzA1MTE1Njc=',
                    'title': 'Stack and other multi-child layout renderers '
                        "should not call markNeedsPaint if they don't actually "
                        'change their layout',
                    'url': 'https://github.com/flutter/flutter/issues/5325',
                    'number': 5325,
                    'state': 'OPEN',
                    'author': {'url': 'https://github.com/apwilson'}
                  }
                },
                {
                  'cursor': 'Y3Vyc29yOnYyOpHOCipM-A==',
                  'node': {
                    'id': 'MDU6SXNzdWUxNzA1NDQzNzY=',
                    'title': 'Should have finer grained linkability',
                    'url': 'https://github.com/flutter/flutter/issues/5330',
                    'number': 5330,
                    'state': 'OPEN',
                    'author': {'url': 'https://github.com/abarth'}
                  }
                },
                {
                  'cursor': 'Y3Vyc29yOnYyOpHOCjXXgg==',
                  'node': {
                    'id': 'MDU6SXNzdWUxNzEzMDA3Mzg=',
                    'title':
                        'Flutter needs to help developers list of supported/unsupported phones/gpus',
                    'url': 'https://github.com/flutter/flutter/issues/5416',
                    'number': 5416,
                    'state': 'OPEN',
                    'author': {'url': 'https://github.com/eseidelGoogle'}
                  }
                },
                {
                  'cursor': 'Y3Vyc29yOnYyOpHOCjjuyQ==',
                  'node': {
                    'id': 'MDU6SXNzdWUxNzE1MDMzMDU=',
                    'title':
                        'Test "flutter create; flutter run" on pre-commit (Simulator on Cirrus/LUCI?)',
                    'url': 'https://github.com/flutter/flutter/issues/5433',
                    'number': 5433,
                    'state': 'OPEN',
                    'author': {'url': 'https://github.com/collinjackson'}
                  }
                }
              ]
            },
          },
        },
        errorMessage: '',
      ),
    );
  }
}
