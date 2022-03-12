 
part of 'filtered_todo_cubit.dart';

class FilteredTodoState extends Equatable {
  final List<Todo> filteredTodos;
 const  FilteredTodoState({
    required this.filteredTodos,
  });

factory FilteredTodoState.initial(){
  return const  FilteredTodoState(filteredTodos: []);
}  

  @override
  List<Object> get props => [filteredTodos];

  @override
  String toString() => 'FilteredTodoState(filteredTodos: $filteredTodos)';

  FilteredTodoState copyWith({
    List<Todo>? filteredTodos,
  }) {
    return FilteredTodoState(
      filteredTodos: filteredTodos ?? this.filteredTodos,
    );
  }
}
