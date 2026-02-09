import 'package:bloc/bloc.dart';
import 'package:easilybecho/core/common/common_image_picker.dart';
import 'package:easilybecho/learn_bloc/image_picker/bloc/image_picker_event.dart';
import 'package:easilybecho/learn_bloc/image_picker/bloc/image_picker_state.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  final CommonImagePicker commonImagePicker;
  ImagePickerBloc(this.commonImagePicker) : super(const ImagePickerState()) {
    on<CameraCapture>(_cameraCapture);
    on<GalleryCapture>(_galleryCapture);
    on<RemoveImage>(_removeImage);

    on<GalleryCapture2>(_galleryCapture2);
    on<RemoveImage2>(_removeImage2);
  }

  void _cameraCapture(
    CameraCapture event,
    Emitter<ImagePickerState> emit,
  ) async {
    final XFile? file = await commonImagePicker.cameraCapture();
    emit(state.copyWith(file: file));
  }

  void _galleryCapture(
    GalleryCapture event,
    Emitter<ImagePickerState> emit,
  ) async {
    final XFile? file = await commonImagePicker.galleryCapture();
    emit(state.copyWith(file: file));
  }

  void _removeImage(RemoveImage event, Emitter<ImagePickerState> emit) async {
    emit(state.copyWith(removeFile: true, file: null));
  }

  void _galleryCapture2(
    GalleryCapture2 event,
    Emitter<ImagePickerState> emit,
  ) async {
    final XFile? file = await commonImagePicker.galleryCapture();
    emit(state.copyWith(file2: file));
  }

  void _removeImage2(RemoveImage2 event, Emitter<ImagePickerState> emit) async {
    emit(state.copyWith(removeFile2: true, file2: null));
  }
}
