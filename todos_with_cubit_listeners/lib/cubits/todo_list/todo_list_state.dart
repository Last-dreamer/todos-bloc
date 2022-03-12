 
part of 'todo_list_cubit.dart';

class TodoListState extends Equatable {
  final List<Todo> todo;
  const TodoListState({
    required this.todo,
  });

  factory TodoListState.initial(){
    return TodoListState(todo: [
      Todo(id: "1", desc: "work todo "),
      Todo(id: "2", desc: "please wash the dishes")
    ]);
  }

  @override
  List<Object> get props => [todo];

  @override
  String toString() => 'TodoListState(todo: $todo)';

  TodoListState copyWith({
    List<Todo>? todo,
  }) {
    return TodoListState(
      todo: todo ?? this.todo,
    );
  }
}
