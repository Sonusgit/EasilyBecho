import 'package:flutter/material.dart';

class BillsManagementPage extends StatefulWidget {
  const BillsManagementPage({super.key});

  @override
  State<BillsManagementPage> createState() => _BillsManagementPageState();
}

class _BillsManagementPageState extends State<BillsManagementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bills Management'),
      ),
      body: const Center(
        child: Text('Bills Management Page'),
      ),
    );
  }
}