import 'dart:async';

import 'package:easilybecho/core/data/network/connectivity_manager.dart';
import 'package:flutter/material.dart';

class ConnectivityWrapper extends StatefulWidget {
  final Widget child;
  final Widget? offlineWidget;
  final bool showBanner;
  final Function()? onConnected;
  final Function()? onDisconnected;

  const ConnectivityWrapper({
    super.key,
    required this.child,
    this.offlineWidget,
    this.showBanner = true,
    this.onConnected,
    this.onDisconnected,
  });
  @override
  State<ConnectivityWrapper> createState() => _ConnectivityWrapperState();
}

class _ConnectivityWrapperState extends State<ConnectivityWrapper> {
  final ConnectivityManager _manager = ConnectivityManager();
  bool _isConnected = true;
  StreamSubscription<bool>? _subscription;
  @override
  void initState() {
    super.initState();

    _isConnected = _manager.isConnected;

    _subscription = _manager.connectionStream.listen((isConnected) {
      setState(() => _isConnected = isConnected);

      if (!isConnected) {
        widget.onDisconnected?.call();

        // ✅ Show dialog
        NoInternetDialog.show(context, () async {
          await _manager.checkConnection();
        });
      } else {
        widget.onConnected?.call();

        // ✅ Hide dialog
        NoInternetDialog.hide(context);
      }
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: widget.child),

        // ✅ Banner (as you want to keep)
        if (!_isConnected && widget.showBanner)
          Material(
            color: Colors.red,
            child: SafeArea(
              bottom: true,
              top: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wifi_off, color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  const Text(
                    'No Internet Connection',
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () async {
                      await _manager.checkConnection();
                    },
                    child: const Text(
                      'Retry',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

        if (!_isConnected && widget.offlineWidget != null)
          widget.offlineWidget!,
      ],
    );
  }
}

class NoInternetDialog {
  static bool _isShowing = false;

  static void show(BuildContext context, VoidCallback onRetry) {
    if (_isShowing) return;

    _isShowing = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text("No Internet"),
        content: const Text("Please check your connection and try again."),
        actions: [TextButton(onPressed: onRetry, child: const Text("Retry"))],
      ),
    );
  }

  static void hide(BuildContext context) {
    if (_isShowing) {
      Navigator.of(context, rootNavigator: true).pop();
      _isShowing = false;
    }
  }
}
