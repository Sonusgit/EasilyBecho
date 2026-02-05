import 'package:bloc/bloc.dart';
import 'package:easilybecho/learn_bloc/switch_example/bloc/switch_event.dart';
import 'package:easilybecho/learn_bloc/switch_example/bloc/switch_state.dart';

class SwitchBloc extends Bloc<SwitchEvent, SwitchState> {
  SwitchBloc() : super(const SwitchState(isSwitch: false)) {
    on<EnableOrDisableNotification>(_enableOrDisableNotification);
    on<ControllerOpacity>(_controllerOpacity);
  }
  void _enableOrDisableNotification(
    EnableOrDisableNotification event,
    Emitter<SwitchState> emit,
  ) {
    emit(state.copyWith(isSwitch: !state.isSwitch));
  }
  void _controllerOpacity(
    ControllerOpacity event,
    Emitter<SwitchState> emit,
  ){
    emit(state.copyWith(opacity: event.opacity));
  }
}
