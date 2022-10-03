import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_good_practices/issues/application/list/issues_list_bloc.dart';
import 'package:flutter_good_practices/issues/domain/models/issue.dart';
import 'package:flutter_good_practices/routes/routes.dart';

class IssueCard extends StatelessWidget {
  const IssueCard({super.key, required this.issue});

  final Issue issue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: InkWell(
        onTap: () {
          context.read<IssuesListBloc>().add(
                MarkIssueAsVisited(
                  issue: issue,
                ),
              );
          Navigator.pushNamed(
            context,
            RouteGenerator.issueDetailPage,
            arguments: issue,
          );
        },
        child: BlocBuilder<IssuesListBloc, IssuesListState>(
          builder: (context, state) {
            return Card(
              key: const Key('issue_card'),
              color: issue.visited ? Colors.grey : Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 20,
                  bottom: 20,
                ),
                child: ListTile(
                  title: Text(
                    issue.title,
                    key: const Key('issue_title'),
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: Colors.black,
                        ),
                  ),
                  subtitle: Text(
                    issue.state,
                    key: const Key('issue_state'),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_sharp,
                    key: Key('issue_trailing'),
                    color: Colors.black,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
