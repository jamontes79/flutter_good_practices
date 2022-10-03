import 'package:flutter/material.dart';
import 'package:flutter_good_practices/issues/domain/models/issue.dart';
import 'package:flutter_good_practices/issues/presentation/detail/issue_detail_page.dart';
import 'package:flutter_good_practices/issues/presentation/list/issues_list_page.dart';

class RouteGenerator {
  static const String issuesListPage = 'issues_list';
  static const String issueDetailPage = 'issue_detail';

  static Route<MaterialPageRoute<dynamic>> generateRoute(
    RouteSettings settings,
  ) {
    switch (settings.name) {
      case issuesListPage:
        return MaterialPageRoute(
          builder: (_) => const IssuesListPage(
            key: Key('issues_list_page'),
          ),
        );
      case issueDetailPage:
        final arguments = settings.arguments!;
        return MaterialPageRoute(
          builder: (_) => IssueDetailPage(
            key: const Key('issue_detail_page'),
            issue: arguments as Issue,
          ),
        );

      default:
        throw const FormatException('Route not found');
    }
  }
}
