import 'package:flutter/material.dart';

class DuesManagementPage extends StatefulWidget {
  const DuesManagementPage({super.key});

  @override
  State<DuesManagementPage> createState() => _DuesManagementPageState();
}

class _DuesManagementPageState extends State<DuesManagementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dues Management'),
      ),
      body: const Center(
        child: Text('Dues Management Page'),
      ),
    );
  }
}