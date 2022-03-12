import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_cubit_streamsubscription/models/todo_model.dart';

part 'todo_filters_state.dart';

class TodoFiltersCubit extends Cubit<TodoFilterState> {
  
  TodoFiltersCubit() : super(TodoFilterState.initial());


void changeFilter(Filter newFilter){
  emit(state.copyWith(filter: newFilter));
}

}
