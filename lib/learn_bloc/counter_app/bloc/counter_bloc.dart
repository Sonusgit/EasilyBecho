import 'package:easilybecho/core/helpers/toast/toast_helper.dart';
import 'package:easilybecho/learn_bloc/counter_app/bloc/counter_events.dart';
import 'package:easilybecho/learn_bloc/counter_app/bloc/counter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Bloc<CounterEvents, CounterState> {
  CounterBloc() : super(const CounterState(counter: 0)) {
    on<IncrementCounter>((event, emit) {
      emit(CounterState(counter: state.counter + 5));
    });
    // on<DecrementCounter>((event, emit) {
    //   if (state.counter > 0) {
    //     emit(CounterState(counter: state.counter - 1));
    //   }
    // });
    on<DecrementCounter>((event, emit) {
      if (state.counter > 0) {
        emit(CounterState(counter: state.counter - 5));
      }else{
        ToastHelper.error(title: 'not');
      }
    });
  }
}
