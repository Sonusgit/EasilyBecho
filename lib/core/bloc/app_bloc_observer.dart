import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    if (kDebugMode) {
      log(
        'onCreate -- ${bloc.runtimeType}',
        name: 'BlocObs',
      );
    }
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    if (kDebugMode) {
      log(
        'onEvent -- ${bloc.runtimeType}, $event',
        name: 'BlocObs',
      );
    }
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (kDebugMode) {
      log(
        'onChange -- ${bloc.runtimeType}, $change',
        name: 'BlocObs',
      );
    }
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (kDebugMode) {
      log(
        'onTransition -- ${bloc.runtimeType}, $transition',
        name: 'BlocObs',
      );
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      log(
        'onError -- ${bloc.runtimeType}',
        name: 'BlocObs',
        level: 800,
        error: error,
        stackTrace: stackTrace,
      );
    }
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    if (kDebugMode) {
      log(
        'onClose -- ${bloc.runtimeType}',
        name: 'BlocObs',
      );
    }
  }
}
