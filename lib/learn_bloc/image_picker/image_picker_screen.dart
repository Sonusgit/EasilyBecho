// image_picker_Page.dart
import 'dart:io';

import 'package:easilybecho/core/extensions/size_extension.dart';
import 'package:easilybecho/core/navigation/app_navigators.dart';
import 'package:easilybecho/core/navigation/routes/app_routes_names.dart';
import 'package:easilybecho/core/navigation/routes/app_routes_paths.dart';
import 'package:easilybecho/learn_bloc/image_picker/bloc/image_picker_bloc.dart';
import 'package:easilybecho/learn_bloc/image_picker/bloc/image_picker_event.dart';
import 'package:easilybecho/learn_bloc/image_picker/bloc/image_picker_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImagePickerPage extends StatelessWidget {
  const ImagePickerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image Picker')),
      body: Center(
        child: Column(
          children: [
            BlocBuilder<ImagePickerBloc, ImagePickerState>(
              builder: (context, state) {
                if (state.file == null) {
                  return IconButton.filled(
                    iconSize: 40,
                    icon: const Icon(Icons.image),
                    onPressed: () {
                      context
                          .read<ImagePickerBloc>()
                          .add(GalleryCapture());
                    },
                  );
                }
            
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // tap to change image (optional)
                        context
                            .read<ImagePickerBloc>()
                            .add(GalleryCapture());
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(50.radius),
                        
                        child: Image.file(
                          File(state.file!.path),
                         width: 80.width,
                         height: 80.height,
                         fit:BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton(
                      onPressed: () {
                        context
                            .read<ImagePickerBloc>()
                            .add(RemoveImage());
                      },
                      child: const Text('Remove Image'),
                    ),
                  ],
                );
              },
            ),

//image 2 
            BlocBuilder<ImagePickerBloc, ImagePickerState>(
              builder: (context, state) {
                if (state.file2 == null) {
                  return IconButton.filled(
                    iconSize: 40,
                    icon: const Icon(Icons.image),
                    onPressed: () {
                      context
                          .read<ImagePickerBloc>()
                          .add(GalleryCapture2());
                    },
                  );
                }
            
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // tap to change image (optional)
                        context
                            .read<ImagePickerBloc>()
                            .add(GalleryCapture2());
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(50.radius),
                        
                        child: Image.file(
                          File(state.file2!.path),
                         width: 80.width,
                         height: 80.height,
                         fit:BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton(
                      onPressed: () {
                        context
                            .read<ImagePickerBloc>()
                            .add(RemoveImage2());
                      },
                      child: const Text('Remove Image2'),
                    ),
                  ],
                );
              },
            ),
            ElevatedButton(onPressed: () => AppNavigators.push(AppRoutesPaths.toDoPage), child: Text('go to ToDo'))
          ],
        ),
      ),
    );
  }
}
