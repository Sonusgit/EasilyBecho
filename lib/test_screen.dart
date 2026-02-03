import 'package:easilybecho/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return
    Scaffold(
      appBar: AppBar(title: Text("Test Screen")),
      body: Padding(
        padding:  EdgeInsets.all(context.defaultPadding),
        child: Column(
          children: [
            Center(child: Text("This is a test screen")),
            Card(
             
            )
          ],
        ),
      ),
    );    
  }
     }