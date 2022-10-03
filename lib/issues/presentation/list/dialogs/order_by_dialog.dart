import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_good_practices/issues/application/filter/issues_filter_bloc.dart';
import 'package:flutter_good_practices/issues/domain/use_cases/i_issues_repository.dart';
import 'package:flutter_good_practices/l10n/l10n.dart';

class OrderByDialog extends StatelessWidget {
  const OrderByDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildDialog(context);
  }

  AlertDialog _buildDialog(BuildContext context) {
    final l10n = context.l10n;
    return AlertDialog(
      shape: _defaultShape(),
      insetPadding: const EdgeInsets.all(8),
      elevation: 10,
      titlePadding: EdgeInsets.zero,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 30, 0, 0),
            child: Text(
              l10n.oderByDialogTitle,
              key: const Key('order_by_dialog_title'),
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : Colors.white,
                  ),
            ),
          ),
          _getCloseButton(context),
        ],
      ),
      content: BlocBuilder<IssuesFilterBloc, IssuesFilterState>(
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                l10n.createdAt,
                key: const Key('order_by_dialog_created_at_text'),
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontSize: 18,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white,
                    ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.ascending_mode,
                    key: const Key('order_by_dialog_ascending_mode_text'),
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.black
                                  : Colors.white,
                        ),
                  ),
                  Switch(
                    key: const Key('order_by_dialog_ascending_mode_switch'),
                    onChanged: (bool value) {
                      context
                          .read<IssuesFilterBloc>()
                          .add(ChangeOrderByMode(ascending: value));
                    },
                    value:
                        state.filter.orderByDirection == OrderByDirection.asc,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.descending_mode,
                    key: const Key('order_by_dialog_descending_mode_text'),
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.black
                                  : Colors.white,
                        ),
                  ),
                  Switch(
                    key: const Key('order_by_dialog_descending_mode_switch'),
                    onChanged: (bool value) {
                      context
                          .read<IssuesFilterBloc>()
                          .add(ChangeOrderByMode(ascending: !value));
                    },
                    value:
                        state.filter.orderByDirection != OrderByDirection.asc,
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          );
        },
      ),
    );
  }

  // Returns alert default border style
  ShapeBorder _defaultShape() {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: const BorderSide(
        color: Colors.white,
      ),
    );
  }

  Widget _getCloseButton(BuildContext context) {
    return Padding(
      key: const Key('order_by_dialog_close_button'),
      padding: const EdgeInsets.fromLTRB(0, 10, 10, 30),
      child: GestureDetector(
        child: Container(
          alignment: FractionalOffset.topRight,
          child: InkWell(
            child: Icon(
              Icons.clear,
              key: const Key('order_by_dialog_close_icon'),
              color: Theme.of(context).colorScheme.secondary,
            ),
            onTap: () {
              final currentFilter =
                  context.read<IssuesFilterBloc>().state.filter;

              Navigator.pop(context, currentFilter);
            },
          ),
        ),
      ),
    );
  }
}
