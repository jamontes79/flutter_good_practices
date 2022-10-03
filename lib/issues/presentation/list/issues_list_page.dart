import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_good_practices/injection/injection.dart';
import 'package:flutter_good_practices/issues/application/list/issues_list_bloc.dart';
import 'package:flutter_good_practices/issues/presentation/list/widgets/issues_list_view.dart';

class IssuesListPage extends StatelessWidget {
  const IssuesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<IssuesListBloc>()
        ..add(
          const LoadIssues(),
        ),
      child: const IssuesListView(),
    );
  }
}
