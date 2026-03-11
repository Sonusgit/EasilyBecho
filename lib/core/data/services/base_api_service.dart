import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easilybecho/core/data/error/app_exception.dart';
import 'package:easilybecho/core/data/error/exception_mapper.dart';
import 'package:easilybecho/core/data/services/dio_client.dart';
import 'package:easilybecho/core/data/services/secure_storage_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class BaseApiService {
  final Dio _dio = DioClient.instance;

  // ─── Retry config ─────────────────────────────────────────────────────────
  // Railway free tier cold start = 30–60s wake up time.
  // Retry silently while server is waking up.
  // Delays: 5s → 10s → 15s → 20s → 25s (total ~75s max wait)
  static const int _maxRetries      = 5;
  static const Duration _retryDelay = Duration(seconds: 5);

  // ─── Auth Header ──────────────────────────────────────────────────────────

  Future<Options> _buildOptions(bool requiresAuth) async {
    if (!requiresAuth) return Options();
    final token = await SecureStorageHelper.getUserToken();
    return Options(
      headers: {
        if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
      },
    );
  }

  // ─── Should Retry ─────────────────────────────────────────────────────────
  // ✅ FIX: 'Failed host lookup' is a DNS error — MUST be retried
  // It happens for 2–6s after internet reconnects. Not a permanent failure.

  bool _shouldRetry(Object e) {
    if (e is DioException) {
      // Connection level errors → always retry
      if (e.type == DioExceptionType.connectionError)   return true;
      if (e.type == DioExceptionType.connectionTimeout) return true;
      if (e.type == DioExceptionType.sendTimeout)       return true;
      if (e.type == DioExceptionType.receiveTimeout)    return true;

      // DNS specific errors → retry (this is the main fix)
      final msg = e.message ?? '';
      if (msg.contains('Failed host lookup'))          return true;
      if (msg.contains('No address associated'))       return true;
      if (msg.contains('SocketException'))             return true;
      if (msg.contains('Connection refused'))          return true;
      if (msg.contains('Network is unreachable'))      return true;
      if (msg.contains('connection error'))            return true;

      // Inner error check
      final inner = e.error;
      if (inner is SocketException)                    return true;
    }
    if (e is SocketException) return true;
    return false;
  }

  // ─── Safe Request Wrapper ─────────────────────────────────────────────────

  Future<dynamic> _request(Future<Response> Function() call) async {
    int attempt = 0;

    while (true) {
      try {
        final res = await call();
        return res.data;
      } catch (e) {
        if (_shouldRetry(e) && attempt < _maxRetries) {
          attempt++;
          // Exponential delay: 5s, 10s, 15s, 20s, 25s — covers Railway cold start
          await Future.delayed(_retryDelay * attempt);
          continue;
        }
        // All retries exhausted
        if (e is DioException) throw ExceptionMapper.fromDioException(e);
        if (e is AppException)  rethrow;
        throw NoInternetException();
      }
    }
  }

  // ─── GET ──────────────────────────────────────────────────────────────────

  Future<dynamic> getApi({
    required String endpoint,
    Map<String, dynamic>? queryParams,
    bool requiresAuth = false,
  }) => _request(
        () async => _dio.get(
          endpoint,
          queryParameters: queryParams,
          options: await _buildOptions(requiresAuth),
        ),
      );

  // ─── POST ─────────────────────────────────────────────────────────────────

  Future<dynamic> postApi({
    required String endpoint,
    dynamic data,
    Map<String, dynamic>? queryParams,
    bool requiresAuth = false,
  }) => _request(
        () async => _dio.post(
          endpoint,
          data: data,
          queryParameters: queryParams,
          options: await _buildOptions(requiresAuth),
        ),
      );

  // ─── PUT ──────────────────────────────────────────────────────────────────

  Future<dynamic> putApi({
    required String endpoint,
    dynamic data,
    Map<String, dynamic>? queryParams,
    bool requiresAuth = false,
  }) => _request(
        () async => _dio.put(
          endpoint,
          data: data,
          queryParameters: queryParams,
          options: await _buildOptions(requiresAuth),
        ),
      );

  // ─── PATCH ────────────────────────────────────────────────────────────────

  Future<dynamic> patchApi({
    required String endpoint,
    dynamic data,
    Map<String, dynamic>? queryParams,
    bool requiresAuth = false,
  }) => _request(
        () async => _dio.patch(
          endpoint,
          data: data,
          queryParameters: queryParams,
          options: await _buildOptions(requiresAuth),
        ),
      );

  // ─── DELETE ───────────────────────────────────────────────────────────────

  Future<dynamic> deleteApi({
    required String endpoint,
    dynamic data,
    Map<String, dynamic>? queryParams,
    bool requiresAuth = false,
  }) => _request(
        () async => _dio.delete(
          endpoint,
          data: data,
          queryParameters: queryParams,
          options: await _buildOptions(requiresAuth),
        ),
      );

  // ─── UPLOAD (FormData) ────────────────────────────────────────────────────

  Future<dynamic> multipartApi({
    required String endpoint,
    required FormData formData,
    bool requiresAuth = false,
    String method = 'POST',
    void Function(int sent, int total)? onSendProgress,
  }) async {
    final opts = (await _buildOptions(requiresAuth)).copyWith(
      contentType: 'multipart/form-data',
      method: method.toUpperCase(),
    );
    return _request(
      () async => _dio.request(
        endpoint,
        data: formData,
        options: opts,
        onSendProgress: onSendProgress,
      ),
    );
  }

  // ─── DOWNLOAD ─────────────────────────────────────────────────────────────

  String _resolveFileName(String endpoint, String? customName) {
    if (customName != null && customName.isNotEmpty) return customName;
    final uri  = Uri.tryParse(endpoint);
    final name = uri?.pathSegments.isNotEmpty == true
        ? uri!.pathSegments.last
        : 'file_${DateTime.now().millisecondsSinceEpoch}';
    return name.contains('.') ? name : '$name.bin';
  }

  String _subFolder(String fileName) {
    final ext      = fileName.split('.').last.toLowerCase();
    const images   = {'jpg', 'jpeg', 'png', 'gif', 'webp', 'bmp', 'svg'};
    const videos   = {'mp4', 'mov', 'avi', 'mkv', 'webm'};
    const audio    = {'mp3', 'wav', 'aac', 'flac', 'ogg'};
    const docs     = {'pdf', 'doc', 'docx', 'txt', 'csv', 'ppt', 'pptx', 'xls', 'xlsx'};
    const archives = {'zip', 'rar', '7z', 'tar', 'gz'};
    if (images.contains(ext))   return 'Pictures';
    if (videos.contains(ext))   return 'Movies';
    if (audio.contains(ext))    return 'Music';
    if (docs.contains(ext))     return 'Documents';
    if (archives.contains(ext)) return 'Downloads';
    return 'Downloads';
  }

  Future<String> _buildSavePath(String fileName) async {
    final sub = _subFolder(fileName);
    if (Platform.isAndroid) {
      final public = Directory('/storage/emulated/0/$sub');
      if (await public.exists() || await public.create(recursive: true) != null) {
        return '${public.path}/$fileName';
      }
    }
    final dir    = await getApplicationDocumentsDirectory();
    final folder = Directory('${dir.path}/$sub');
    await folder.create(recursive: true);
    return '${folder.path}/$fileName';
  }

  Future<bool> _requestStoragePermission() async {
    if (Platform.isIOS) return true;
    final status = await Permission.storage.request();
    if (status.isGranted) return true;
    final photos = await Permission.photos.request();
    final videos = await Permission.videos.request();
    final audio  = await Permission.audio.request();
    return photos.isGranted || videos.isGranted || audio.isGranted;
  }

  Future<dynamic> downloadApi({
    required String endpoint,
    bool requiresAuth = false,
    Map<String, dynamic>? queryParams,
    String? fileName,
    void Function(int received, int total)? onReceiveProgress,
  }) async {
    final hasPermission = await _requestStoragePermission();
    if (!hasPermission) throw const UnknownException(message: 'Storage permission denied.');
    final resolvedName = _resolveFileName(endpoint, fileName);
    final savePath     = await _buildSavePath(resolvedName);
    try {
      final opts = await _buildOptions(requiresAuth);
      final res  = await _dio.download(
        endpoint,
        savePath,
        queryParameters: queryParams,
        options: opts,
        onReceiveProgress: onReceiveProgress,
      );
      return res.data;
    } on DioException catch (e) {
      throw ExceptionMapper.fromDioException(e);
    } catch (e) {
      if (e is AppException) rethrow;
      throw UnknownException(message: e.toString());
    }
  }
}