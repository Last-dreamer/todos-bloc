import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/cubits.dart';

class TodoHeader extends StatelessWidget {
  const TodoHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
       const  Text("Todo ",  style: TextStyle(fontSize: 40),),
       Text("${context.watch<ActiveTodoCountCubit>().state.activeTodoCount} item left", 
       style:const  TextStyle(fontSize:20, color: Colors.redAccent)),

      ],
    );
  }
}
