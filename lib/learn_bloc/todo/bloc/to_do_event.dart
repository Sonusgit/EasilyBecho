import 'package:equatable/equatable.dart';

abstract class ToDoEvent extends Equatable {
  const ToDoEvent();
}

class AddToDoEvent extends ToDoEvent {
  @override
  List<Object?> get props => [];
}

class RemoveToDoEvent extends ToDoEvent {
  @override
  List<Object?> get props => [];
}
