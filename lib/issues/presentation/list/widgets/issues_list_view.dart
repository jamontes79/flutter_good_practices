import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_good_practices/injection/injection.dart';
import 'package:flutter_good_practices/issues/application/filter/issues_filter_bloc.dart';
import 'package:flutter_good_practices/issues/application/list/issues_list_bloc.dart';
import 'package:flutter_good_practices/issues/domain/models/issue_filter.dart';
import 'package:flutter_good_practices/issues/presentation/list/dialogs/filter_dialog.dart';
import 'package:flutter_good_practices/issues/presentation/list/dialogs/order_by_dialog.dart';
import 'package:flutter_good_practices/issues/presentation/list/widgets/issues_list_body.dart';
import 'package:flutter_good_practices/l10n/l10n.dart';
import 'package:flutter_good_practices/settings/presentation/settings_dialog.dart';

class IssuesListView extends StatelessWidget {
  const IssuesListView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<IssuesListBloc, IssuesListState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.appBarTitle),
            actions: [
              PopupMenuButton(
                color: Theme.of(context).colorScheme.background,
                icon: const Icon(Icons.more_vert),
                onSelected: (value) {
                  if (value == 'Settings') {
                    _showSettingsDialog(context);
                  } else if (value == 'Order') {
                    _showOrderByDialog(
                      context,
                      context.read<IssuesListBloc>().state.filter,
                    ).then((result) {
                      if (result != null) {
                        context.read<IssuesListBloc>().add(
                              UpdateFilter(filter: result),
                            );
                      }
                    });
                  } else if (value == 'Filter') {
                    _showFilterDialog(
                      context,
                      context.read<IssuesListBloc>().state.filter,
                    ).then((result) {
                      if (result != null) {
                        context.read<IssuesListBloc>().add(
                              UpdateFilter(filter: result),
                            );
                      }
                    });
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'Order',
                    child: Text(l10n.menuOrderBy),
                  ),
                  PopupMenuItem(
                    value: 'Filter',
                    child: Text(l10n.menuFilter),
                  ),
                  PopupMenuItem(
                    value: 'Settings',
                    child: Text(l10n.menuSettings),
                  ),
                ],
              ),
            ],
          ),
          body: const IssuesListBody(),
        );
      },
    );
  }

  Future<void> _showSettingsDialog(BuildContext context) async {
    await showGeneralDialog(
      context: context,
      pageBuilder: (
        BuildContext buildContext,
        Animation<dynamic> animation,
        Animation<dynamic> secondaryAnimation,
      ) {
        return const SettingsDialog(
          key: Key('accessibility_dialog'),
        );
      },
    );
  }

  Future<IssueFilter?> _showOrderByDialog(
    BuildContext context,
    IssueFilter currentFilter,
  ) async {
    final result = await showGeneralDialog<IssueFilter>(
      context: context,
      pageBuilder: (
        BuildContext buildContext,
        Animation<dynamic> animation,
        Animation<dynamic> secondaryAnimation,
      ) {
        return BlocProvider(
          create: (context) => getIt<IssuesFilterBloc>()
            ..add(
              InitFilter(
                filter: currentFilter,
              ),
            ),
          child: const OrderByDialog(
            key: Key('order_by_dialog'),
          ),
        );
      },
    );
    return result;
  }

  Future<IssueFilter?> _showFilterDialog(
    BuildContext context,
    IssueFilter currentFilter,
  ) async {
    final result = await showGeneralDialog<IssueFilter>(
      context: context,
      pageBuilder: (
        BuildContext buildContext,
        Animation<dynamic> animation,
        Animation<dynamic> secondaryAnimation,
      ) {
        return BlocProvider(
          create: (context) => getIt<IssuesFilterBloc>()
            ..add(
              InitFilter(
                filter: currentFilter,
              ),
            ),
          child: const FilterDialog(
            key: Key('order_by_dialog'),
          ),
        );
      },
    );
    return result;
  }
}
