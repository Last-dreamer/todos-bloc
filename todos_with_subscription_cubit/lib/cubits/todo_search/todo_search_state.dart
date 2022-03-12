 
part of 'todo_search_cubit.dart';

class TodoSearchState extends Equatable {
  final String search;

  const TodoSearchState({ required this.search});

factory TodoSearchState.initial(){
  return const TodoSearchState(search: "");
}

  TodoSearchState copyWith({
    String? search,
  }) {
    return TodoSearchState(
      search: search ?? this.search,
    );
  }

  @override
  String toString() => 'TodoSearchState(search: $search)';

  @override
  List<Object> get props => [search];
}
