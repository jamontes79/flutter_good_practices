import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_good_practices/issues/domain/models/issue.dart';
import 'package:flutter_good_practices/issues/presentation/detail/issue_detail_navigate_button.dart';
import 'package:flutter_good_practices/issues/presentation/detail/issue_state_widget.dart';
import 'package:flutter_good_practices/issues/presentation/detail/issue_title_widget.dart';
import 'package:flutter_good_practices/l10n/l10n.dart';

class IssueDetailPage extends StatelessWidget {
  const IssueDetailPage({super.key, required this.issue});
  final Issue issue;
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text('${l10n.issueDetailAppBarTitle} ${issue.number}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IssueTitle(
              key: const Key('issue_detail_title'),
              title: issue.title,
            ),
            const Gap(10),
            IssueState(
              key: const Key('issue_detail_state'),
              state: issue.state,
            ),
            const Gap(10),
            IssueNavigateButton(
              key: const Key('issue_detail_navigate'),
              url: issue.url,
            ),
          ],
        ),
      ),
    );
  }
}
