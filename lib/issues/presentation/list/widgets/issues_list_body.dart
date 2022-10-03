import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_good_practices/issues/application/list/issues_list_bloc.dart';
import 'package:flutter_good_practices/issues/presentation/list/widgets/issue_card_widget.dart';
import 'package:flutter_good_practices/l10n/l10n.dart';

class IssuesListBody extends StatelessWidget {
  const IssuesListBody({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<IssuesListBloc, IssuesListState>(
      builder: (context, state) {
        final scrollController = ScrollController();
        scrollController.addListener(() {
          final triggerFetchMoreSize =
              0.9 * scrollController.position.maxScrollExtent;

          if (scrollController.position.pixels > triggerFetchMoreSize) {
            context.read<IssuesListBloc>().add(
                  const LoadNextPageIssues(),
                );
          }
        });
        if (state.status == IssuesListStatus.loading ||
            state.status == IssuesListStatus.initial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.status == IssuesListStatus.error) {
          return Center(
            child: Text(
              l10n.errorLoading,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          );
        } else {
          if (state.issues.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(8),
              child: Center(
                child: Text(
                  l10n.emptyList,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            );
          }
          return RefreshIndicator(
            key: const Key('issues_refresh_list'),
            onRefresh: () {
              context.read<IssuesListBloc>().add(
                    const LoadIssues(),
                  );
              return Future.value();
            },
            child: ListView.builder(
              key: const Key('issues_list'),
              physics: const AlwaysScrollableScrollPhysics(),
              controller: scrollController,
              itemCount: state.status == IssuesListStatus.updatingList
                  ? state.issues.length + 1
                  : state.issues.length,
              itemBuilder: (BuildContext context, int index) {
                if (index == state.issues.length) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  );
                }
                return IssueCard(
                  key: Key('issue_$index'),
                  issue: state.issues[index],
                );
              },
            ),
          );
        }
      },
    );
  }
}
