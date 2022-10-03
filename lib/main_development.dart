// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_good_practices/app/app.dart';
import 'package:flutter_good_practices/bootstrap.dart';
import 'package:flutter_good_practices/injection/injection.dart';

void main() {
  configureInjection(Environment.dev);
  FlavorConfig(
    name: 'DEVELOPMENT',
    variables: <String, String>{
      'github_token': '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',
    },
  );
  bootstrap(() => const App());
}
