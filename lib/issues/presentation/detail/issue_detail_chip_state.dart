import 'package:flutter/material.dart';

class ChipState extends StatelessWidget {
  const ChipState({
    super.key,
    required this.state,
  });

  final String state;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(
          color: _stateColor(),
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Text(
          state,
          key: const Key('issue_detail_state_text'),
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                fontWeight: FontWeight.w400,
                color: _stateColor(),
              ),
        ),
      ),
    );
  }

  MaterialColor _stateColor() {
    switch (state.toLowerCase()) {
      case 'open':
        return Colors.green;
      case 'closed':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
