import 'dart:ui';

import 'package:flutter/material.dart';

class ImagePickerScreen extends StatelessWidget {
  const ImagePickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: SingleChildScrollView(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CloseButton(),
            BackButton(
              
            ),
            Center(
              child: IconButton.filled(onPressed: () {
                
              }, icon: Icon(Icons.image)),
            )
          ],
        ) ),
      ) );
   
  }
}