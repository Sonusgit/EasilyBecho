import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

/// FIXES:
/// 1. Removed Dio.get ping → was going through interceptors → caused infinite loop
/// 2. Pure DNS lookup to 8.8.8.8 → no HTTP, no Dio, no interceptors
/// 3. Debounce 500ms → rapid changes don't spam checks
class ConnectivityManager {
  static final ConnectivityManager _instance = ConnectivityManager._internal();
  factory ConnectivityManager() => _instance;
  ConnectivityManager._internal();

  final Connectivity _connectivity = Connectivity();
  final StreamController<bool> _connectionController =
      StreamController<bool>.broadcast();

  Stream<bool> get connectionStream => _connectionController.stream;
  bool _isConnected = true;
  StreamSubscription<List<ConnectivityResult>>? _subscription;
  Timer? _debounce;

  bool get isConnected => _isConnected;

  Future<void> initialize() async {
    final initial = await _connectivity.checkConnectivity();
    await _updateConnectionStatus(initial);

    _subscription = _connectivity.onConnectivityChanged.listen((results) {
      _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () {
        _updateConnectionStatus(results);
      });
    });
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> results) async {
    if (kIsWeb) { _updateStatus(true); return; }

    if (results.contains(ConnectivityResult.none)) {
      _updateStatus(false);
      return;
    }

    // ✅ DNS only — never touches Dio or any interceptor
    _updateStatus(await _dnsCheck());
  }

  Future<bool> _dnsCheck() async {
    try {
      final result = await InternetAddress.lookup('8.8.8.8')
          .timeout(const Duration(seconds: 4));
      return result.isNotEmpty;
    } on SocketException {
      return false;
    } catch (_) {
      return false;
    }
  }

  void _updateStatus(bool status) {
    if (_isConnected != status) {
      _isConnected = status;
      _connectionController.add(status);
    }
  }

  Future<bool> checkConnection() async {
    final results = await _connectivity.checkConnectivity();
    await _updateConnectionStatus(results);
    return _isConnected;
  }

  void dispose() {
    _debounce?.cancel();
    _subscription?.cancel();
    _connectionController.close();
  }
}