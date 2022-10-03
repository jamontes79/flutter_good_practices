import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_good_practices/l10n/l10n.dart';

class IssueTitle extends StatelessWidget {
  const IssueTitle({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.issueTitle,
          key: const Key('issue_detail_title_label'),
          style: Theme.of(context).textTheme.caption?.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
        ),
        const Gap(10),
        Text(
          title,
          key: const Key('issue_detail_title_view'),
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.caption?.copyWith(
                fontSize: 18,
              ),
        ),
      ],
    );
  }
}
