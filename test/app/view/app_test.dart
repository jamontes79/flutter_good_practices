// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_good_practices/app/app.dart';
import 'package:flutter_good_practices/injection/injection.dart';
import 'package:flutter_good_practices/issues/application/list/issues_list_bloc.dart';
import 'package:flutter_good_practices/issues/presentation/list/issues_list_page.dart';

class MockIssuesListBloc extends MockBloc<IssuesListEvent, IssuesListState>
    implements IssuesListBloc {}

void main() {
  setUpAll(() {
    configureInjection(Environment.test);
    WidgetController.hitTestWarningShouldBeFatal = true;
    WidgetsFlutterBinding.ensureInitialized();
  });
  tearDown(getIt.reset);
  setUp(() {
    FlavorConfig(
      name: 'TESTS',
      variables: <String, String>{
        'github_token': '',
      },
    );
  });

  group('App', () {
    testWidgets('renders IssuesListPage', (tester) async {
      await tester.pumpWidget(
        const App(),
      );
      expect(find.byType(IssuesListPage), findsOneWidget);
    });
  });
}
