import 'package:easilybecho/learn_bloc/counter_app/bloc/counter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterState(counter: 0));

  void increment() {
    emit(CounterState(counter: state.counter + 1));
  }

  void decrement() {
    if (state.counter > 0) {
      emit(CounterState(counter: state.counter - 1));
    }
  }
}
