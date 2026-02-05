import 'dart:developer';

import 'package:easilybecho/core/extensions/app_log_Print_extention.dart';
import 'package:easilybecho/core/extensions/size_extension.dart';
import 'package:easilybecho/core/helpers/toast/toast_helper.dart';
import 'package:easilybecho/core/navigation/app_navigators.dart';
import 'package:easilybecho/core/navigation/routes/app_routes_paths.dart';
import 'package:easilybecho/learn_bloc/counter_app/views/counter_page.dart';
import 'package:easilybecho/learn_bloc/switch_example/bloc/switch_bloc.dart';
import 'package:easilybecho/learn_bloc/switch_example/bloc/switch_event.dart';
import 'package:easilybecho/learn_bloc/switch_example/bloc/switch_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SwitchExamplePage extends StatelessWidget {
  const SwitchExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BackButton(),
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                ToastHelper.info(
                  title: 'Error is Good',
                  message: 'jkljkljklaqyaylkaykayjkyakljayjklaykljay',
                );
                log("Error good");
                AppNavigators.push(AppRoutesPaths.counterApp);
              },
              child: Text("test Tost"),
            ),

            BlocBuilder<SwitchBloc, SwitchState>(
              buildWhen: (previous, current) => previous.isSwitch !=current.isSwitch,
              builder: (context, state) {
                'print Notification'.appPrint;

                return SwitchListTile.adaptive(
                  value: state.isSwitch,
                  onChanged: (value) {
                    context.read<SwitchBloc>().add(
                      EnableOrDisableNotification(),
                    );
                  },
                  title: Text('Notification'),
                );
              },
            ),

            BlocBuilder<SwitchBloc, SwitchState>(
              buildWhen: (previous, current) => previous.opacity !=current.opacity,

              builder: (context, state) {
                return Container(
                  height: 200.height,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: state.opacity),
                  ),
                );
              },
            ),

            BlocBuilder<SwitchBloc, SwitchState>(
              buildWhen: (previous, current) => previous.opacity !=current.opacity,
              builder: (context, state) {
                'print Slider'.appLogger(
                  tag: 'Switch App'
                );
                return Slider(
                  // min: 0,
                  // max: 100,
                  divisions: 10,
                  value: state.opacity,
                  label: state.opacity.toStringAsFixed(1),
                  // activeColor: Colors.amber,
                  // inactiveColor: Colors.grey,
                  // thumbColor: Colors.orange,
                  autofocus: true,
                  allowedInteraction: SliderInteraction.tapAndSlide,
                 
                  secondaryTrackValue: state.opacity,
                  secondaryActiveColor: Colors.redAccent,
                 
                  onChanged: (value) {
                    context.read<SwitchBloc>().add(
                      ControllerOpacity(opacity: value),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
