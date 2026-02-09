import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerState extends Equatable {
  final XFile? file;
  final XFile? file2;
  const ImagePickerState({this.file, this.file2});

  ImagePickerState copyWith({
    XFile? file,
    bool removeFile = false,
    XFile? file2,
    bool removeFile2 = false,
  }) {
    return ImagePickerState(
      file: removeFile ? null : (file ?? this.file),
      file2: removeFile2 ? null : (file2 ?? this.file2),
    );
  }

  @override
  List<Object?> get props => [file, file2];
}
