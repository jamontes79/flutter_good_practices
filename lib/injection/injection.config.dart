// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:graphql/client.dart' as _i9;
import 'package:graphql_flutter/graphql_flutter.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;

import '../core/domain/use_cases/i_github_repository.dart' as _i6;
import '../core/infrastructure/app_graphql_client_module.dart' as _i15;
import '../core/infrastructure/graphql_github_repository.dart' as _i8;
import '../core/infrastructure/test/graphql_github_repository_test.dart' as _i7;
import '../issues/application/filter/issues_filter_bloc.dart' as _i12;
import '../issues/application/list/issues_list_bloc.dart' as _i13;
import '../issues/domain/use_cases/i_issues_repository.dart' as _i10;
import '../issues/infrastructure/issues_repository.dart' as _i11;
import '../settings/application/settings_bloc.dart' as _i14;
import '../settings/domain/usecases/i_accessibility.dart' as _i4;
import '../settings/infrastructure/accessibility_repository.dart' as _i5;

const String _test = 'test';
const String _dev = 'dev';
const String _prod = 'prod';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final appGraphQLClientModule = _$AppGraphQLClientModule();
  gh.lazySingleton<_i3.GraphQLClient>(
      () => appGraphQLClientModule.graphQLClient);
  gh.lazySingleton<_i4.IAccessibility>(() => _i5.AccessibilityRepository());
  gh.lazySingleton<_i6.IGithubRepository>(
    () => _i7.FakeGraphQLGithubRepository(),
    registerFor: {_test},
  );
  gh.lazySingleton<_i6.IGithubRepository>(
    () => _i8.GraphQLGithubRepository(get<_i9.GraphQLClient>()),
    registerFor: {
      _dev,
      _prod,
    },
  );
  gh.lazySingleton<_i10.IIssuesRepository>(
      () => _i11.IssuesRepository(get<_i6.IGithubRepository>()));
  gh.factory<_i12.IssuesFilterBloc>(() => _i12.IssuesFilterBloc());
  gh.factory<_i13.IssuesListBloc>(
      () => _i13.IssuesListBloc(get<_i10.IIssuesRepository>()));
  gh.factory<_i14.SettingsBloc>(
      () => _i14.SettingsBloc(get<_i4.IAccessibility>()));
  return get;
}

class _$AppGraphQLClientModule extends _i15.AppGraphQLClientModule {}
