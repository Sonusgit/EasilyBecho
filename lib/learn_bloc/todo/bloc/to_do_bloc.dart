import 'package:bloc/bloc.dart';
import 'package:easilybecho/learn_bloc/todo/bloc/to_do_event.dart';
import 'package:easilybecho/learn_bloc/todo/bloc/to_do_state.dart';

class ToDoBloc extends Bloc<ToDoEvent,ToDoState> {
  ToDoBloc() : super( const ToDoState() );
}