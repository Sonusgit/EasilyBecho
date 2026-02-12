import 'package:easilybecho/learn_bloc/todo/model/to_do_model.dart';
import 'package:equatable/equatable.dart';

class ToDoState extends Equatable {
  final List<ToDoModel> todoList;
  const ToDoState({this.todoList = const []});
 
  @override
  List<Object?> get props => [];
}