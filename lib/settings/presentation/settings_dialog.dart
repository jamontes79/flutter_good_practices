import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_good_practices/l10n/l10n.dart';
import 'package:flutter_good_practices/settings/application/settings_bloc.dart';

class SettingsDialog extends StatelessWidget {
  const SettingsDialog({super.key});

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
              l10n.settingsText,
              key: const Key('accessibility_dialog_title'),
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
      content: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.settingsDarkMode,
                    key: const Key('accessibility_dialog_darkmode_text'),
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.black
                                  : Colors.white,
                        ),
                  ),
                  Switch(
                    key: const Key('accessibility_dialog_darkmode_switch'),
                    onChanged: (bool value) {
                      context
                          .read<SettingsBloc>()
                          .add(ChangeStyleEvent(darkMode: value));
                    },
                    value: state.darkMode,
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
      key: const Key('accessibility_dialog_close_button'),
      padding: const EdgeInsets.fromLTRB(0, 10, 10, 30),
      child: GestureDetector(
        child: Container(
          alignment: FractionalOffset.topRight,
          child: InkWell(
            child: Icon(
              Icons.clear,
              key: const Key('accessibility_dialog_close_icon'),
              color: Theme.of(context).colorScheme.secondary,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
