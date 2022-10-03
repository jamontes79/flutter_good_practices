import 'package:dartz/dartz.dart';
import 'package:flutter_good_practices/core/domain/failures/failures.dart';
import 'package:flutter_good_practices/issues/domain/models/issue_filter.dart';
import 'package:flutter_good_practices/issues/domain/models/issues_navigation.dart';

enum OrderByDirection { asc, desc }

abstract class IIssuesRepository {
  Future<Either<Failure, IssuesNavigation>> get({
    required IssueFilter filter,
  });
}
