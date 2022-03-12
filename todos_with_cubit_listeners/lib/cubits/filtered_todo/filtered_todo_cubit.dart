import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:todo_cubit_streamsubscription/cubits/todo_filter/todo_filters_cubit.dart';
import 'package:todo_cubit_streamsubscription/cubits/todo_list/todo_list_cubit.dart';
import 'package:todo_cubit_streamsubscription/cubits/todo_search/todo_search_cubit.dart';
import 'package:todo_cubit_streamsubscription/models/todo_model.dart';

part 'filtered_todo_state.dart';

class FilteredTodoCubit extends Cubit<FilteredTodoState> {
late final StreamSubscription todoFiltersSubscription;
late final StreamSubscription todoSearchSubscription;
late final StreamSubscription todoListSubscription;

  final TodoFiltersCubit todoFiltersCubit;
  final TodoSearchCubit todoSearchCubit;
  final TodoListCubit todoListCubit;
  final List<Todo> initialTodo;
  FilteredTodoCubit({
  required this.initialTodo,
   required this.todoFiltersCubit,
   required this.todoSearchCubit,
   required this.todoListCubit,
  }) : super(FilteredTodoState(filteredTodos: initialTodo)){
    todoFiltersSubscription = todoFiltersCubit.stream.listen((TodoFilterState e) {
      setFilteredTodo();
    });
    todoSearchSubscription = todoSearchCubit.stream.listen((TodoSearchState e) {
       setFilteredTodo();
    });
    todoListSubscription =  todoListCubit.stream.listen((TodoListState e) {
       setFilteredTodo();
     });

  }

  void setFilteredTodo(){
    List<Todo> _filteredTodo;
    switch(todoFiltersCubit.state.filter){
      case Filter.active:
        _filteredTodo =  todoListCubit.state.todo.where((e) => !e.completed).toList();
        break;
      case Filter.completed:
        _filteredTodo = todoListCubit.state.todo.where((element) => element.completed).toList();
        break;
      case Filter.all:
      default :
      _filteredTodo = todoListCubit.state.todo;
      break;
    }


      if(todoSearchCubit.state.search.isNotEmpty){
        _filteredTodo = _filteredTodo.where((e) => e.desc.toLowerCase().contains(todoSearchCubit.state.search.toLowerCase())).toList();
      }

      emit(state.copyWith(filteredTodos: _filteredTodo));
  }



  @override
  Future<void> close() {
    todoFiltersSubscription.cancel();
    todoSearchSubscription.cancel();
    todoListSubscription.cancel();
    return super.close();
  }
}
