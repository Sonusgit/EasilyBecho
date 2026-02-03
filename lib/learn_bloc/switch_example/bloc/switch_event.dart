import 'package:equatable/equatable.dart';

sealed class SwitchEvent extends Equatable {
  const SwitchEvent();

  @override
  List<Object> get props => [];
}

class EnableOrDisableNotification extends SwitchEvent{}
// class DisableNotification extends SwitchEvent{}
