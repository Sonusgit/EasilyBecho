import 'package:easilybecho/core/navigation/app_key.dart';
import 'package:flutter/material.dart';

class ToastHelper {
  ToastHelper._();

  static OverlayEntry? _currentToast;

  static void success({
    required String title,
    String? message,
    Duration duration = const Duration(seconds: 4),
  }) {
    _show(
      title: title,
      message: message,
      background: const Color(0xFF10B981),
      icon: Icons.check_circle_rounded,
      duration: duration,
    );
  }

  static void error({
    required String title,
    String? message,
    Duration duration = const Duration(seconds: 10),
  }) {
    _show(
      title: title,
      message: message,
      background: const Color(0xFFEF4444),
      icon: Icons.error_rounded,
      duration: duration,
    );
  }

  static void info({
    required String title,
    String? message,
    Duration duration = const Duration(seconds: 4),
  }) {
    _show(
      title: title,
      message: message,
      background: const Color(0xFF3B82F6),
      icon: Icons.info_rounded,
      duration: duration,
    );
  }

  static void warning({
    required String title,
    String? message,
    Duration duration = const Duration(seconds: 4),
  }) {
    _show(
      title: title,
      message: message,
      background: const Color(0xFFFBBF24),
      icon: Icons.warning_rounded,
      textColor: Colors.black87,
      duration: duration,
    );
  }

  static void custom({
    required String title,
    String? message,
    required Color background,
    required IconData icon,
    Color textColor = Colors.white,
    Duration duration = const Duration(seconds: 4),
  }) {
    _show(
      title: title,
      message: message,
      background: background,
      icon: icon,
      textColor: textColor,
      duration: duration,
    );
  }

  static OverlayState? _getOverlayState() {
    try {
      return AppKey.navigatorKey.currentState?.overlay;
    } catch (e) {
      debugPrint('Error getting overlay state: $e');
      return null;
    }
  }

  static void _show({
    required String title,
    String? message,
    required Color background,
    required IconData icon,
    Color textColor = Colors.white,
    Duration duration = const Duration(seconds: 4),
  }) {
    _currentToast?.remove();

    final overlayState = _getOverlayState();

    if (overlayState == null) {
      return;
    }

    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) => _ToastWidget(
        title: title,
        message: message,
        background: background,
        icon: icon,
        textColor: textColor,
        onClose: () => _removeToast(entry),
      ),
    );

    _currentToast = entry;
    overlayState.insert(entry);

    Future.delayed(duration, () {
      _removeToast(entry);
    });
  }

  static void _removeToast(OverlayEntry entry) {
    try {
      entry.remove();
      if (_currentToast == entry) {
        _currentToast = null;
      }
    } catch (e) {}
  }

  static void dismiss({required String title}) {
    _currentToast?.remove();
    _currentToast = null;
  }
}

class _ToastWidget extends StatefulWidget {
  final String title;
  final String? message;
  final Color background;
  final IconData icon;
  final Color textColor;
  final VoidCallback onClose;

  const _ToastWidget({
    required this.title,
    this.message,
    required this.background,
    required this.icon,
    required this.textColor,
    required this.onClose,
  });

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 12,
      left: 16,
      right: 16,
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: widget.background,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(widget.icon, color: widget.textColor, size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                            color: widget.textColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        if (widget.message != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            widget.message!,
                            style: TextStyle(
                              color: widget.textColor.withOpacity(0.85),
                              fontSize: 12,
                              height: 1.4,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: widget.onClose,
                    child: Icon(Icons.close, color: widget.textColor, size: 20),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void showSuccess(String title, [String? message]) =>
    ToastHelper.success(title: title, message: message);

void showError(String title, [String? message]) =>
    ToastHelper.error(title: title, message: message);

void showInfo(String title, [String? message]) =>
    ToastHelper.info(title: title, message: message);

void showWarning(String title, [String? message]) =>
    ToastHelper.warning(title: title, message: message);
