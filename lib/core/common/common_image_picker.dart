import 'package:easilybecho/learn_bloc/image_picker/bloc/image_picker_event.dart';
import 'package:image_picker/image_picker.dart';

class CommonImagePicker {
   final ImagePicker _picker = ImagePicker();

   Future<XFile?> cameraCapture() async {
    final XFile? file = await _picker.pickImage(source: ImageSource.camera);
    return file;
  }

   Future<XFile?> galleryCapture() async {
    final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
    return file;
  }

   Future<List<XFile>?>  images () async {
    final List<XFile> files = await _picker.pickMultiImage();
    return files;
  }
}
