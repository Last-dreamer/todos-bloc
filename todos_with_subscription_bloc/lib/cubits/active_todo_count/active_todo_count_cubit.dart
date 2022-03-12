import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:todo_cubit_streamsubscription/cubits/todo_list/todo_list_cubit.dart';

part 'active_todo_count_state.dart';

class ActiveTodoCountCubit extends Cubit<ActiveTodoCountState> {
  late final StreamSubscription todoListStreamSubsciption;
  final int currentCount;
  final TodoListCubit todoListCubit;

  ActiveTodoCountCubit({
    required this.currentCount,
    required this.todoListCubit,
}) : super(ActiveTodoCountState(activeTodoCount: currentCount)){
  todoListStreamSubsciption = todoListCubit.stream.listen((TodoListState stateTodo) { 
    final int currentActiveTodoCount = stateTodo.todo.where((e) => !e.completed).toList().length;
    emit(state.copyWith(activeTodoCount: currentActiveTodoCount));
  });
}


@override
  Future<void> close() {
     todoListStreamSubsciption.cancel();
    return super.close();
  }

}
