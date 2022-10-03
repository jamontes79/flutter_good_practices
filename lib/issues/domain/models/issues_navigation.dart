import 'package:equatable/equatable.dart';
import 'package:flutter_good_practices/issues/domain/models/issue.dart';

class IssuesNavigation extends Equatable {
  const IssuesNavigation({
    required this.issues,
    required this.hasNextPage,
    required this.endCursor,
  });

  final List<Issue> issues;
  final bool hasNextPage;
  final String endCursor;

  @override
  List<Object?> get props => [
        issues,
        hasNextPage,
        endCursor,
      ];
}
