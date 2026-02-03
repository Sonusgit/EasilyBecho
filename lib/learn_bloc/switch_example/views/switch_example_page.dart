import 'dart:developer';

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
                ToastHelper.info(title: 'Error is Good',message: 'jkljkljklaqyaylkaykayjkyakljayjklaykljay');
                log("Error good");
                AppNavigators.go(AppRoutesPaths.counterApp);
              },
              child: Text("test Tost"),
            ),

            BlocBuilder<SwitchBloc, SwitchState>(
              builder: (context, state) {
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
          ],
        ),
      ),
    );
  }
}
