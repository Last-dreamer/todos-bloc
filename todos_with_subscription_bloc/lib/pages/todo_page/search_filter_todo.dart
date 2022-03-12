 
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; 
import 'package:todo_cubit_streamsubscription/models/todo_model.dart';

import '../../cubits/todo_filter/todo_filters_cubit.dart';
import '../../cubits/todo_search/todo_search_cubit.dart';

class SearchFilterToDo extends StatelessWidget {
  const SearchFilterToDo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children:   [
        TextField(
          decoration:const  InputDecoration(
            labelText: "Search Todos ...",
            border: InputBorder.none,
            filled: true,
            prefixIcon: Icon(Icons.search)
          ),
          onChanged: (search){
            if(search.isNotEmpty){
              context.read<TodoSearchCubit>().setSearch(search);
            }
          },
        ),
        const SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            filteredButton(context, Filter.all),
            filteredButton(context, Filter.active),
            filteredButton(context, Filter.completed),
        ],)
      ],
    );
  }


  Widget filteredButton(BuildContext context, Filter filter){
    return TextButton(onPressed: (){
      context.read<TodoFiltersCubit>().changeFilter(filter);
    }, 
    child: Text(filter ==  Filter.all ?
    "All" :  filter == Filter.active ? "Active" : "Completed",
    style:  TextStyle(fontSize: 18.0,
    color: textColor(context, filter))), );  
  }

  Color textColor(BuildContext context, Filter filter){
    final currentFilter = context.watch<TodoFiltersCubit>().state.filter;
    return currentFilter  == filter ? Colors.blue: Colors.grey;
  }
}