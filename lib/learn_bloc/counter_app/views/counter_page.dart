import 'package:easilybecho/core/extensions/size_extension.dart';
import 'package:easilybecho/learn_bloc/counter_app/bloc/counter_bloc.dart';
import 'package:easilybecho/learn_bloc/counter_app/bloc/counter_cubit.dart';
import 'package:easilybecho/learn_bloc/counter_app/bloc/counter_events.dart';
import 'package:easilybecho/learn_bloc/counter_app/bloc/counter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Counter App')),
      body: SafeArea(
        child: BlocBuilder<CounterBloc, CounterState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${state.counter}',
                    style: TextStyle(fontSize: 45.fontSp),
                  ),
                  100.horizontalW,
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          // context.read<CounterCubit>().increment();
                          context.read<CounterBloc>().add(IncrementCounter());
                        },
                        icon: Icon(Icons.plus_one_rounded,size: 30.fontSp,),
                      ),
                      IconButton(
                        onPressed: () {
                          context.read<CounterBloc>().add(DecrementCounter());
                          // context.read<CounterCubit>().decrement();
                        },
                        icon: Icon(Icons.flag ,size: 30.fontSp,),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
