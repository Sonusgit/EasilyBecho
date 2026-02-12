import 'package:easilybecho/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class LineChart extends StatelessWidget {
  const LineChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: context.screenHeight/3,
        width: context.screenWidth/3,
        child: Column(
          children: [
            Text('Line Chart',
            style: context.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold
            ),

            ),
          ],
      ),)
    );
  }
}