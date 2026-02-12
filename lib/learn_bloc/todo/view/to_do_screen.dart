import 'package:easilybecho/core/extensions/context_extension.dart';
import 'package:easilybecho/core/extensions/size_extension.dart';
import 'package:flutter/material.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ToDo Page')),
      floatingActionButton: IconButton.filled(
        onPressed: () => (),
        icon: Icon(Icons.add),
      ),
      body: SafeArea(
        minimum: EdgeInsets.all(10.height),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('hii Todo'),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 12,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('title $index'),
                    subtitle: Text('name $index'),
                  );
                },
              ),
              Text('Theme bodyLarge', style: Theme.of(context).textTheme.bodyLarge,),
              Text('Theme bodyMedium', style: Theme.of(context).textTheme.bodyMedium,),
              Text('Theme bodySmall', style: Theme.of(context).textTheme.bodySmall,),
              Text('Theme displayLarge', style: Theme.of(context).textTheme.displayLarge,),
              Text('Theme displayMedium', style: Theme.of(context).textTheme.displayMedium,),
              Text('Theme displaySmall', style: Theme.of(context).textTheme.displaySmall,),
              Text('Theme headlineLarge', style: Theme.of(context).textTheme.headlineLarge,),
              Text('Theme headlineMedium', style: Theme.of(context).textTheme.headlineMedium,),
              Text('Theme headlineSmall', style: Theme.of(context).textTheme.headlineSmall,),
              Text('Theme labelLarge', style: Theme.of(context).textTheme.labelLarge,),
              Text('Theme labelMedium', style: Theme.of(context).textTheme.labelMedium,),
              Text('Theme labelSmall', style: Theme.of(context).textTheme.labelSmall,),
              Text('Theme titleLarge', style: Theme.of(context).textTheme.titleLarge,),
              Text('Theme titleMedium', style: Theme.of(context).textTheme.titleMedium,),
              Text('Theme titleSmall', style: Theme.of(context).textTheme.titleSmall,),

              
              Text('Theme bodyLarge', style: context.textTheme.bodyLarge?.copyWith(
 color: context.theme.primaryColor
              ),),
              Text('Theme bodyMedium', style: context.textTheme.bodyMedium,),
              Text('Theme bodySmall', style: context.textTheme.bodySmall,),
              Text('Theme displayLarge', style: context.textTheme.displayLarge,),
              Text('Theme displayMedium', style: context.textTheme.displayMedium,),
              Text('Theme displaySmall', style: context.textTheme.displaySmall,),
              Text('Theme headlineLarge', style: context.textTheme.headlineLarge,),
              Text('Theme headlineMedium', style: context.textTheme.headlineMedium,),
              Text('Theme headlineSmall', style: context.textTheme.headlineSmall,),
              Text('Theme labelLarge', style: context.textTheme.labelLarge,),
              Text('Theme labelMedium', style: context.textTheme.labelMedium,),
              Text('Theme labelSmall', style: context.textTheme.labelSmall,),
              Text('Theme titleLarge', style: context.textTheme.titleLarge,),
              Text('Theme titleMedium', style: context.textTheme.titleMedium,),
              Text('Theme titleSmall', style: context.textTheme.titleSmall,),
            ],
          ),
        ),
      ),
    );
  }
}
