// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:easilybecho/core/data/error/app_exception.dart';
// import 'package:easilybecho/core/data/error/exception_mapper.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';

// // ─── File type → subfolder + extension map ───────────────────────────────────
// // Supports: pdf, doc/docx, xls/xlsx, ppt/pptx, txt, csv,
// //           jpg/jpeg/png/gif/webp, mp4/mov/avi, mp3/wav, zip/rar, apk

// String _resolveFileName(String endpoint, String? customName) {
//   if (customName != null && customName.isNotEmpty) return customName;
//   final uri = Uri.tryParse(endpoint);
//   final name = uri?.pathSegments.isNotEmpty == true
//       ? uri!.pathSegments.last
//       : 'file_${DateTime.now().millisecondsSinceEpoch}';
//   return name.contains('.') ? name : '$name.bin';
// }

// String _subFolder(String fileName) {
//   final ext = fileName.split('.').last.toLowerCase();
//   const images = {'jpg', 'jpeg', 'png', 'gif', 'webp', 'bmp', 'svg'};
//   const videos = {'mp4', 'mov', 'avi', 'mkv', 'webm'};
//   const audio  = {'mp3', 'wav', 'aac', 'flac', 'ogg'};
//   const docs   = {'pdf', 'doc', 'docx', 'txt', 'csv', 'ppt', 'pptx', 'xls', 'xlsx'};
//   const archives = {'zip', 'rar', '7z', 'tar', 'gz'};

//   if (images.contains(ext))   return 'Pictures';
//   if (videos.contains(ext))   return 'Movies';
//   if (audio.contains(ext))    return 'Music';
//   if (docs.contains(ext))     return 'Documents';
//   if (archives.contains(ext)) return 'Downloads';
//   if (ext == 'apk')           return 'Downloads';
//   return 'Downloads';
// }

// Future<String> _buildSavePath(String fileName) async {
//   final sub = _subFolder(fileName);

//   if (Platform.isAndroid) {
//     // Try public Downloads folder first
//     final public = Directory('/storage/emulated/0/$sub');
//     if (await public.exists() || await public.create(recursive: true) != null) {
//       return '${public.path}/$fileName';
//     }
//   }

//   // iOS / fallback: app documents directory
//   final dir = await getApplicationDocumentsDirectory();
//   final folder = Directory('${dir.path}/$sub');
//   await folder.create(recursive: true);
//   return '${folder.path}/$fileName';
// }

// Future<bool> _requestStoragePermission() async {
//   if (Platform.isIOS) return true; // iOS doesn't need explicit permission
//   final status = await Permission.storage.request();
//   if (status.isGranted) return true;
//   // Android 13+ uses granular permissions
//   final photos  = await Permission.photos.request();
//   final videos  = await Permission.videos.request();
//   final audio   = await Permission.audio.request();
//   return photos.isGranted || videos.isGranted || audio.isGranted || status.isGranted;
// }

// // ─── The download method (drop-in replacement) ────────────────────────────────

//   Future<dynamic> download({
//     required String endpoint,
//     bool requiresAuth = false,
//     Map<String, dynamic>? queryParams,
//     String? fileName,           // optional — auto-detected from URL if null
//     void Function(int received, int total)? onReceiveProgress,
//   }) async {
//     await _checkInternet();

//     // 1. Permission
//     final hasPermission = await _requestStoragePermission();
//     if (!hasPermission) {
//       throw const UnknownException(message: 'Storage permission denied.');
//     }

//     // 2. Resolve file name + save path automatically
//     final resolvedName = _resolveFileName(endpoint, fileName);
//     final savePath     = await _buildSavePath(resolvedName);

//     try {
//       final opts = await _buildOptions(requiresAuth);
//       final res  = await _dio.download(
//         endpoint,
//         savePath,
//         queryParameters: queryParams,
//         options: opts,
//         onReceiveProgress: onReceiveProgress,
//       );
//       return res.data; // file is saved at [savePath]
//     } on DioException catch (e) {
//       throw ExceptionMapper.fromDioException(e);
//     } catch (e) {
//       if (e is AppException) rethrow;
//       throw UnknownException(message: e.toString());
//     }
//   }

// // ─── Usage examples ───────────────────────────────────────────────────────────
// //
// // PDF  → saved to /storage/emulated/0/Documents/report.pdf
// // PNG  → saved to /storage/emulated/0/Pictures/photo.png
// // MP4  → saved to /storage/emulated/0/Movies/video.mp4
// // MP3  → saved to /storage/emulated/0/Music/song.mp3
// // ZIP  → saved to /storage/emulated/0/Downloads/archive.zip
// // APK  → saved to /storage/emulated/0/Downloads/app.apk
// //
// // await download(
// //   endpoint: 'https://example.com/files/report.pdf',
// //   requiresAuth: true,
// //   onReceiveProgress: (received, total) {
// //     if (total != -1) print('${(received / total * 100).toInt()}%');
// //   },
// // );
// //
// // Custom name:
// // await download(
// //   endpoint: 'https://example.com/export?id=123',
// //   fileName: 'my_export.xlsx',
// // );