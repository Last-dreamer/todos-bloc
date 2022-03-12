import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_cubit_streamsubscription/models/todo_model.dart';

part 'todo_list_state.dart';

class TodoListCubit extends Cubit<TodoListState> {
  TodoListCubit() : super(TodoListState.initial());

  void addTodo(String todoDesc){
    final newTodo = Todo(desc: todoDesc);
    final todos = [...state.todo, newTodo];

    emit(state.copyWith(todo: todos));
  }


  void editTodo(String id, String desc){
    final newTodo = state.todo.map((e) {
      if(e.id == id){
        return Todo(id: id, desc: desc, completed: e.completed);
      }
      return e;
    }).toList();

    emit(state.copyWith(todo: newTodo));  
  }

  void toggleTodo(String id){
    final newTodos = state.todo.map((e){
      if(e.id == id){
        return Todo(id: id, desc: e.desc, completed: !e.completed);
      }
      return e;
    }).toList();
    emit(state.copyWith(todo: newTodos));
  }


void removeTodo(Todo todo){
  final newTodo = state.todo.where((e) => e.id != todo.id).toList();
  emit(state.copyWith(todo: newTodo));
}

}
