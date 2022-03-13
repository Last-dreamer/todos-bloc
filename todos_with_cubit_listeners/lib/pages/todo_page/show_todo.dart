

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_cubit_streamsubscription/cubits/todo_filter/todo_filters_cubit.dart';

import 'package:todo_cubit_streamsubscription/cubits/todo_list/todo_list_cubit.dart';
import 'package:todo_cubit_streamsubscription/cubits/todo_search/todo_search_cubit.dart';

import '../../cubits/filtered_todo/filtered_todo_cubit.dart';
import '../../models/todo_model.dart';

class ShowTodo extends StatelessWidget {
  const ShowTodo({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

      final todos = context.watch<FilteredTodoCubit>().state.filteredTodos;

    return MultiBlocListener(
      listeners: [
        BlocListener<TodoFiltersCubit, TodoFilterState>(listener: (context,state){
          context.read<FilteredTodoCubit>().setFilteredTodo(state.filter, context.read<TodoListCubit>().state.todo, context.read<TodoSearchCubit>().state.search);
        }),

        BlocListener<TodoListCubit, TodoListState>(listener: (context,state){
          context.read<FilteredTodoCubit>().setFilteredTodo(context.read<TodoFiltersCubit>().state.filter, state.todo, context.read<TodoSearchCubit>().state.search);
        }),

        BlocListener<TodoSearchCubit, TodoSearchState>(listener: (context,state){
          context.read<FilteredTodoCubit>().setFilteredTodo(context.read<TodoFiltersCubit>().state.filter, context.read<TodoListCubit>().state.todo, state.search);
        }),
      ],
      child: ListView.separated(
        primary: false,
        shrinkWrap: true,
          separatorBuilder: ((context, index) {
            return const  Divider(color: Colors.grey,);
          }), itemCount: todos.length, 
          itemBuilder: (context, index){
            return Dismissible(
              key: ValueKey(todos[index].id),
              background: showBackground(0),
              secondaryBackground: showBackground(1),
              onDismissed: (_){
                context.read<TodoListCubit>().removeTodo(todos[index]);
              },
              confirmDismiss: (_){
                // create a dialog with two buttons
                return showDialog(context: context, barrierDismissible: false, 
                 builder: (context){
                   return  AlertDialog(
                     title: const Text("Are your sure?"),
                     content: const Text("Do you really want to delete ?"),
                     actions: [
                       TextButton(onPressed: (){
                         Navigator.pop(context);
                       }, child: const Text("No")),
                       TextButton(onPressed: (){
                         context.read<TodoListCubit>().removeTodo(todos[index]);
                         Navigator.pop(context);
                       }, child: const Text("Yes")),
                     ],
                   );
                 });
              },
              child:  TodoItem(todo: todos[index],));
          },
          ),
    );
  }


  Widget showBackground(int dir){
    return Container(
      margin:const  EdgeInsets.all(4.0),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      color: Colors.red,
      alignment: dir  == 0 ? Alignment.centerLeft : Alignment.centerRight,
      child: const Icon(Icons.delete, size: 30, color: Colors.white,),
    );
  }
}

class TodoItem extends StatefulWidget {
  final Todo todo;
  const TodoItem({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {

late final TextEditingController _textEditingController;

@override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

@override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        showDialog(context: context,
         builder: (context){
           var _error = false;
           _textEditingController.text = widget.todo.desc;

           return StatefulBuilder(
             builder: (BuildContext context, setState) {
               return AlertDialog(
                 title: const Text("Edit Todo"),
                 content: TextField(
                   controller: _textEditingController,
                   autofocus: true,
                   decoration: InputDecoration(
                     errorText: _error ?  "Please enter some text" : null,
                   ),  
                 ),
                 actions: [
                   TextButton(
                     onPressed: (){
                       Navigator.pop(context);
                     },
                     child: const Text("Cancel"),
                   ),
                   TextButton(
                     onPressed: (){
                        
                       setState(() {
                         _error = _textEditingController.text.isEmpty ? true : false;
                       });
                       if(!_error){
                         context.read<TodoListCubit>().editTodo(widget.todo.id, _textEditingController.text);
                         Navigator.pop(context);
                       }
                     },
                     child: const Text("Edit"),
                   ),
                 ],
               );
             },
           );

         });
      },
      leading: Checkbox(
        value: widget.todo.completed, onChanged: (bool? value) {
          context.read<TodoListCubit>().toggleTodo(widget.todo.id);
          },
      ),
      title: Text(widget.todo.desc,  style: const TextStyle(fontSize: 20))
    );
  }
}