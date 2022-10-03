#fvm flutter format --set-exit-if-changed lib test
#fvm flutter analyze lib test
fvm flutter test --test-randomize-ordering-seed random --coverage 
fvm flutter pub run remove_from_coverage -f coverage/lcov.info -r '.freezed.dart$|.config.dart$|app_graphql_client_module.dart|\.g.dart$|routes.dart$|graphql_github_repository_test.dart|\test\b'
genhtml coverage/lcov.info -o coverage/