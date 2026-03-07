import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:easilybecho/core/navigation/app_key.dart';

/// ─────────────────────────────────────────────────────────────────────────────
/// NoInternetBottomSheet
///
/// • Auto shows when internet goes OFF  (polls every 3s)
/// • Auto closes when internet comes ON
/// • Shows BELOW bottom navigation bar
/// • Retry button re-checks internet
/// • Global — init once in main.dart, works everywhere
///
/// Setup:
///   NoInternetBottomSheet.instance.init();  // call in MyApp.initState
///   NoInternetBottomSheet.instance.dispose(); // call in MyApp.dispose
/// ─────────────────────────────────────────────────────────────────────────────
class NoInternetBottomSheet {
  NoInternetBottomSheet._();
  static final NoInternetBottomSheet instance = NoInternetBottomSheet._();

  Timer? _pollTimer;
  bool _isConnected   = true;
  bool _isShowing     = false;

  static const _pollInterval  = Duration(seconds: 3);
  static const _checkTimeout  = Duration(seconds: 5);

  // ─── Public API ─────────────────────────────────────────────────────────────

  void init() {
    _pollTimer?.cancel();
    _pollTimer = Timer.periodic(_pollInterval, (_) => _check());
  }

  void dispose() {
    _pollTimer?.cancel();
    _pollTimer = null;
  }

  // ─── Internal ────────────────────────────────────────────────────────────────

  Future<void> _check() async {
    final connected = await _checkInternet();

    if (!connected && _isConnected) {
      // Just lost internet
      _isConnected = false;
      _showSheet();
    } else if (connected && !_isConnected) {
      // Internet restored
      _isConnected = true;
      _closeSheet();
    }
  }

  Future<bool> _checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(_checkTimeout);
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  BuildContext? get _context => AppKey.navigatorKey.currentContext;

  void _showSheet() {
    if (_isShowing) return;
    final ctx = _context;
    if (ctx == null) return;

    _isShowing = true;

    showModalBottomSheet(
      context: ctx,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      // useRootNavigator = true → renders ABOVE everything incl. bottom nav
      useRootNavigator: true,
      builder: (_) => const _SheetContent(),
    ).whenComplete(() => _isShowing = false);
  }

  void _closeSheet() {
    if (!_isShowing) return;
    final ctx = _context;
    if (ctx == null) return;
    // Pop the sheet
    Navigator.of(ctx, rootNavigator: true).popUntil((route) {
      return route is! ModalBottomSheetRoute || route.isCurrent == false;
    });
    // Simpler fallback
    try {
      Navigator.of(ctx, rootNavigator: true).pop();
    } catch (_) {}
  }
}

// ─── Sheet UI ─────────────────────────────────────────────────────────────────

class _SheetContent extends StatefulWidget {
  const _SheetContent();

  @override
  State<_SheetContent> createState() => _SheetContentState();
}

class _SheetContentState extends State<_SheetContent> {
  bool _checking = false;
  String _msg    = 'Please check your connection and try again.';

  Future<bool> _checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 5));
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  Future<void> _onRetry() async {
    setState(() {
      _checking = true;
      _msg      = 'Checking connection...';
    });

    final connected = await _checkInternet();

    if (connected) {
      // Update manager state so it doesn't re-show immediately
      NoInternetBottomSheet.instance._isConnected = true;
      if (mounted) Navigator.of(context, rootNavigator: true).pop();
    } else {
      setState(() {
        _checking = false;
        _msg      = 'Still offline. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).padding.bottom;

    return Container(
      padding: EdgeInsets.fromLTRB(24, 20, 24, 20 + bottom),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Handle ─────────────────────────────────────────────────────────
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),

          // ── Icon ───────────────────────────────────────────────────────────
          Container(
            padding: const EdgeInsets.all(18),
            decoration: const BoxDecoration(
              color: Color(0xFFFFEBEE),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.wifi_off_rounded,
              size: 42,
              color: Color(0xFFC62828),
            ),
          ),
          const SizedBox(height: 16),

          const Text(
            'No Internet Connection',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          Text(
            _msg,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 28),

          // ── Retry ──────────────────────────────────────────────────────────
          SizedBox(
            width: double.infinity,
            height: 50,
            child: FilledButton.icon(
              onPressed: _checking ? null : _onRetry,
              icon: _checking
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
                    )
                  : const Icon(Icons.refresh_rounded),
              label: Text(_checking ? 'Checking...' : 'Try Again'),
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFFC62828),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}