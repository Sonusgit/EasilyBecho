import 'package:easilybecho/core/utility/const/app_enums.dart';
import 'package:easilybecho/learn_bloc/test_bloc/bloc/test_bloc.dart';
import 'package:easilybecho/learn_bloc/test_bloc/repo/test_repo/test_api_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TastScreen extends StatelessWidget {
  const TastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TestBloc(TestApiRepo()),
      child: const DataList(),
    );
  }
}

class DataList extends StatefulWidget {
  const DataList({super.key});

  @override
  State<DataList> createState() => _DataListState();
}

class _DataListState extends State<DataList> {
  @override
  void initState() {
    context.read<TestBloc>().add(GetData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TestBloc, TestState>(
        builder: (context, state) {
          if (state.status == ApiStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == ApiStatus.error) {
            return Center(child: Text(state.message));
          } else if (state.status == ApiStatus.success) {
            if (state.data == null || state.data.isEmpty) {
              return const Center(child: Text("No Data Found"));
            }
            List data = state.data as List;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                var item = data[index];
                return ListTile(title: Text('${item["id"]}'));
              },
            );
          }
          return const Placeholder();
        },
      ),
    );
  }
}
