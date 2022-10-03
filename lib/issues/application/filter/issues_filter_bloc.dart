import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_good_practices/issues/domain/models/issue_filter.dart';
import 'package:flutter_good_practices/issues/domain/use_cases/i_issues_repository.dart';
import 'package:injectable/injectable.dart';

part 'issues_filter_event.dart';
part 'issues_filter_state.dart';

@injectable
class IssuesFilterBloc extends Bloc<IssuesFilterEvent, IssuesFilterState> {
  IssuesFilterBloc()
      : super(
          IssuesFilterState(
            filter: IssueFilter.initial(),
          ),
        ) {
    on<InitFilter>(_onInitFilter);
    on<ChangeOrderByMode>(_onChangeOrderByMode);
    on<ChangeFilterByOpen>(_onChangeFilterByOpen);
    on<ChangeFilterByClosed>(_onChangeFilterByClosed);
  }

  FutureOr<void> _onChangeOrderByMode(
    ChangeOrderByMode event,
    Emitter<IssuesFilterState> emit,
  ) {
    emit(
      state.copyWith(
        filter: state.filter.copyWith(
          orderByDirection:
              event.ascending ? OrderByDirection.asc : OrderByDirection.desc,
        ),
      ),
    );
  }

  FutureOr<void> _onChangeFilterByOpen(
    ChangeFilterByOpen event,
    Emitter<IssuesFilterState> emit,
  ) {
    emit(
      state.copyWith(
        filter: state.filter.copyWith(
          filterByOpen: event.filterByOpen,
        ),
      ),
    );
  }

  FutureOr<void> _onChangeFilterByClosed(
    ChangeFilterByClosed event,
    Emitter<IssuesFilterState> emit,
  ) {
    emit(
      state.copyWith(
        filter: state.filter.copyWith(
          filterByClosed: event.filterByClosed,
        ),
      ),
    );
  }

  FutureOr<void> _onInitFilter(
    InitFilter event,
    Emitter<IssuesFilterState> emit,
  ) {
    emit(
      state.copyWith(
        filter: event.filter,
      ),
    );
  }
}
