import 'package:flutter/material.dart';
import 'package:todo_cubit_streamsubscription/pages/todo_page/create_todo.dart';
import 'package:todo_cubit_streamsubscription/pages/todo_page/search_filter_todo.dart';
import 'package:todo_cubit_streamsubscription/pages/todo_page/show_todo.dart';
import 'package:todo_cubit_streamsubscription/pages/todo_page/todo_header.dart';


class ToDosPage extends StatelessWidget {
  const ToDosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(padding:const  EdgeInsets.symmetric(vertical: 40, horizontal: 20),
           child: Column(
             children:const [
               TodoHeader(),
               CreateTodo(),
                SizedBox(height: 20,),
               SearchFilterToDo(),
               SizedBox(height: 20,),
               ShowTodo(),
           ],
           ),
           ),
        ),
      ));
  }

}



