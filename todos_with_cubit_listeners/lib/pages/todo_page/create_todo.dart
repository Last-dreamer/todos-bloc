


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_cubit_streamsubscription/cubits/cubits.dart';

class CreateTodo extends StatefulWidget {
   const  CreateTodo({Key? key}) : super(key: key);

  @override
  State<CreateTodo> createState() => _CreateTodoState();
}

class _CreateTodoState extends State<CreateTodo> {
  TextEditingController createController = TextEditingController();

@override
  void dispose() {
    createController.dispose();
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: createController,
      decoration: const InputDecoration(
        labelText: "what todo?"
      ),
      onSubmitted: (text){
        if(text.trim().isNotEmpty){

          context.read<TodoListCubit>().addTodo(text);
          createController.clear();

        }
      },
    );
  }
}