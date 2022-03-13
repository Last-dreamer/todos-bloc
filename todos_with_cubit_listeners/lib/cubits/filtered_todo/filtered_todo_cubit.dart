import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_cubit_streamsubscription/models/todo_model.dart';

part 'filtered_todo_state.dart';

class FilteredTodoCubit extends Cubit<FilteredTodoState> {
  final List<Todo> initialTodo;
  FilteredTodoCubit({
  required this.initialTodo,
  }) : super(FilteredTodoState(filteredTodos: initialTodo));

  void setFilteredTodo(Filter filter, List<Todo> todos, String search) {
    List<Todo> _filteredTodo;
    switch(filter){
      case Filter.active:
        _filteredTodo =  todos.where((e) => !e.completed).toList();
        break;
      case Filter.completed:
        _filteredTodo = todos.where((element) => element.completed).toList();
        break;
      case Filter.all:
      default :
      _filteredTodo = todos;
      break;
    }


      if(search.isNotEmpty){
        _filteredTodo = _filteredTodo.where((e) => e.desc.toLowerCase().contains(search.toLowerCase())).toList();
      }

      emit(state.copyWith(filteredTodos: _filteredTodo));
  }


 
}
