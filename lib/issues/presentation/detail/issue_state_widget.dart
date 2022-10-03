import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_good_practices/issues/presentation/detail/issue_detail_chip_state.dart';
import 'package:flutter_good_practices/l10n/l10n.dart';

class IssueState extends StatelessWidget {
  const IssueState({super.key, required this.state});
  final String state;
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.issueStatus,
          key: const Key('issue_detail_state_label'),
          style: Theme.of(context).textTheme.caption?.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
        ),
        const Gap(10),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: ChipState(
            key: const Key('issue_detail_chip_state'),
            state: state,
          ),
        )
      ],
    );
  }
}
