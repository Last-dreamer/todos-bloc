import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_cubit_streamsubscription/cubits/cubits.dart';
import 'package:todo_cubit_streamsubscription/pages/todo_page/todo_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodoFiltersCubit>(
          create: (context)=> TodoFiltersCubit(),
        ),
        BlocProvider<TodoSearchCubit>(
          create: (context)=> TodoSearchCubit(),
        ),
        BlocProvider<TodoListCubit>(
          create: (context)=> TodoListCubit(),
        ),
        BlocProvider<ActiveTodoCountCubit>(
          create: (context)=> ActiveTodoCountCubit(
             currentCount: context.read<TodoListCubit>().state.todo.length),
        ),
        BlocProvider<FilteredTodoCubit>(
          create: (context)=> FilteredTodoCubit(
            initialTodo: context.read<TodoListCubit>().state.todo
          ),
        ),
        
      ],
      child: MaterialApp(
        title: 'Todo Cubit',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const ToDosPage(),
      ),
    );
  }
}