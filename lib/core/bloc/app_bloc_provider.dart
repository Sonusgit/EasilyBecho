import 'package:easilybecho/core/common/common_image_picker.dart';
import 'package:easilybecho/learn_bloc/counter_app/bloc/counter_bloc.dart';
import 'package:easilybecho/learn_bloc/counter_app/bloc/counter_cubit.dart';
import 'package:easilybecho/learn_bloc/image_picker/bloc/image_picker_bloc.dart';
import 'package:easilybecho/learn_bloc/switch_example/bloc/switch_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';

class AppBlocProvider {
  static List<SingleChildWidget> providers = [
    BlocProvider(create: (_) => SwitchBloc()),
    BlocProvider(create: (_) => CounterBloc()),
    BlocProvider(create: (_) => CounterCubit()),
    BlocProvider(create: (_) => ImagePickerBloc(CommonImagePicker())),
  ];
}
