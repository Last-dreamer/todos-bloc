import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:todo_cubit_streamsubscription/cubits/todo_list/todo_list_cubit.dart';

part 'active_todo_count_state.dart';

class ActiveTodoCountCubit extends Cubit<ActiveTodoCountState> {
 
  final int currentCount;

  ActiveTodoCountCubit({
    required this.currentCount,
}) : super(ActiveTodoCountState(activeTodoCount: currentCount));


  void updateActiveTodoCount(int activeCount) {
    emit(state.copyWith(activeTodoCount: activeCount));
}

}