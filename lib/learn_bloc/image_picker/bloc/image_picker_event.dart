import 'package:equatable/equatable.dart';
 
 abstract class ImagePickerEvent extends Equatable {
  @override
  List<Object?> get props => [];
} 

class CameraCapture extends ImagePickerEvent{}
class GalleryCapture extends ImagePickerEvent{}
class RemoveImage extends ImagePickerEvent{}

class GalleryCapture2 extends ImagePickerEvent{}
class RemoveImage2 extends ImagePickerEvent{}