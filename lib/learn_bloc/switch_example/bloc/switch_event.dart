import 'package:equatable/equatable.dart';

sealed class SwitchEvent extends Equatable {
  const SwitchEvent();

  @override
  List<Object> get props => [];
}

class EnableOrDisableNotification extends SwitchEvent{}
class ControllerOpacity extends SwitchEvent{
  final double opacity;
  const ControllerOpacity({ required this.opacity});

  @override
  List<Object> get props => [opacity];
  
}
