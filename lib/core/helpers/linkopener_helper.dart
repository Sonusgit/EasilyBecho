import 'package:url_launcher/url_launcher.dart';

/// A utility class to open all types of links, calls, emails, maps, etc.
/// Usage: LinkOpenerHelper.openUrl('https://...')
/// Usage: LinkOpenerHelper.call('+919876543210')
class LinkOpenerHelper {
  LinkOpenerHelper._(); // private constructor — no instance needed

  // ─────────────────────────────────────────────────────────────────────────
  // CORE LAUNCHER
  // ─────────────────────────────────────────────────────────────────────────

  static Future<void> _launch(
    Uri uri, {
    LaunchMode mode = LaunchMode.externalApplication,
  }) async {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: mode);
    } else {
      throw 'Could not launch: $uri';
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  // 🌐 WEB URL
  // ─────────────────────────────────────────────────────────────────────────

  /// Opens any web URL in external browser
  /// Example: LinkOpenerHelper.openUrl('https://google.com')
  static Future<void> openUrl({required String url}) async {
    final uri = Uri.parse(url);
    await _launch(uri, mode: LaunchMode.externalApplication);
  }

  /// Opens URL inside in-app WebView
  /// Example: LinkOpenerHelper.openUrlInApp('https://google.com')
  static Future<void> openUrlInApp({required String url}) async {
    final uri = Uri.parse(url);
    await _launch(uri, mode: LaunchMode.inAppWebView);
  }

  // ─────────────────────────────────────────────────────────────────────────
  // 📞 PHONE CALL
  // ─────────────────────────────────────────────────────────────────────────

  /// Opens dialer with the given phone number
  /// Example: LinkOpenerHelper.call('+919876543210')
  /// Example: LinkOpenerHelper.call('9876543210')
  static Future<void> call({required String phoneNumber}) async {
    // Remove all spaces, dashes, brackets for clean number
    final cleaned = phoneNumber.replaceAll(RegExp(r'[\s\-\(\)]'), '');
    final uri = Uri(scheme: 'tel', path: cleaned);
    await _launch(uri);
  }

  // ─────────────────────────────────────────────────────────────────────────
  // 📱 SMS
  // ─────────────────────────────────────────────────────────────────────────

  /// Opens SMS app with optional pre-filled message
  /// Example: LinkOpenerHelper.sms('+919876543210')
  /// Example: LinkOpenerHelper.sms('9876543210', message: 'Hello!')
  static Future<void> sms({
    required String phoneNumber,
    String? message,
  }) async {
    final cleaned = phoneNumber.replaceAll(RegExp(r'[\s\-\(\)]'), '');
    final uri = Uri(
      scheme: 'sms',
      path: cleaned,
      queryParameters: message != null ? {'body': message} : null,
    );
    await _launch(uri);
  }

  // ─────────────────────────────────────────────────────────────────────────
  // 📧 EMAIL
  // ─────────────────────────────────────────────────────────────────────────

  /// Opens email app with optional subject and body
  /// Example: LinkOpenerHelper.email('test@example.com')
  /// Example: LinkOpenerHelper.email('test@example.com', subject: 'Hi', body: 'Hello!')
  static Future<void> email({
    required String emailAddress,
    String? subject,
    String? body,
    List<String>? cc,
    List<String>? bcc,
  }) async {
    final uri = Uri(
      scheme: 'mailto',
      path: emailAddress,
      queryParameters: {
        if (subject != null) 'subject': subject,
        if (body != null) 'body': body,
        if (cc != null && cc.isNotEmpty) 'cc': cc.join(','),
        if (bcc != null && bcc.isNotEmpty) 'bcc': bcc.join(','),
      },
    );
    await _launch(uri);
  }

  // ─────────────────────────────────────────────────────────────────────────
  // 📍 MAPS / LOCATION
  // ─────────────────────────────────────────────────────────────────────────

  /// Opens Google Maps at given coordinates
  /// Example: LinkOpenerHelper.openMapsLatLng(28.6139, 77.2090)
  static Future<void> openMapsLatLng({
    required double lat,
    required double lng,
    String? label,
  }) async {
    final query = label != null ? Uri.encodeComponent(label) : '$lat,$lng';
    final uri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$lat,$lng',
    );
    await _launch(uri);
  }

  /// Opens Google Maps with a search query
  /// Example: LinkOpenerHelper.openMapsSearch('Patna Bihar')
  static Future<void> openMapsSearch({required String query}) async {
    final encoded = Uri.encodeComponent(query);
    final uri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$encoded',
    );
    await _launch(uri);
  }

  /// Opens navigation directions in Google Maps
  /// Example: LinkOpenerHelper.openDirections(28.6139, 77.2090)
  static Future<void> openDirections({
    required double destLat,
    required double destLng,
  }) async {
    final uri = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination=$destLat,$destLng',
    );
    await _launch(uri);
  }

  // ─────────────────────────────────────────────────────────────────────────
  // 💬 WHATSAPP
  // ─────────────────────────────────────────────────────────────────────────

  /// Opens WhatsApp chat with a number (with country code)
  /// Example: LinkOpenerHelper.openWhatsApp('+919876543210')
  /// Example: LinkOpenerHelper.openWhatsApp('919876543210', message: 'Hello!')
  static Future<void> openWhatsApp({
    required String phoneNumber,
    String? message,
  }) async {
    final cleaned = phoneNumber.replaceAll(RegExp(r'[\s\-\+\(\)]'), '');
    final msg = message != null ? Uri.encodeComponent(message) : '';
    final uri = Uri.parse(
      'https://wa.me/$cleaned${msg.isNotEmpty ? '?text=$msg' : ''}',
    );
    await _launch(uri);
  }

  // ─────────────────────────────────────────────────────────────────────────
  // 📸 SOCIAL MEDIA
  // ─────────────────────────────────────────────────────────────────────────

  /// Opens Instagram profile
  /// Example: LinkOpenerHelper.openInstagram('username')
  static Future<void> openInstagram({required String username}) async {
    final uri = Uri.parse('https://instagram.com/$username');
    await _launch(uri);
  }

  /// Opens Facebook profile or page
  /// Example: LinkOpenerHelper.openFacebook('pagename')
  static Future<void> openFacebook({required String pageId}) async {
    final uri = Uri.parse('https://facebook.com/$pageId');
    await _launch(uri);
  }

  /// Opens Twitter / X profile
  /// Example: LinkOpenerHelper.openTwitter('username')
  static Future<void> openTwitter({required String username}) async {
    final uri = Uri.parse('https://twitter.com/$username');
    await _launch(uri);
  }

  /// Opens YouTube channel or video
  /// Example: LinkOpenerHelper.openYouTube('https://youtube.com/watch?v=xxx')
  static Future<void> openYouTube({required String url}) async {
    final uri = Uri.parse(url);
    await _launch(uri);
  }

  /// Opens LinkedIn profile
  /// Example: LinkOpenerHelper.openLinkedIn('username')
  static Future<void> openLinkedIn({required String username}) async {
    final uri = Uri.parse('https://linkedin.com/in/$username');
    await _launch(uri);
  }

  // ─────────────────────────────────────────────────────────────────────────
  // 📦 APP STORE / PLAY STORE
  // ─────────────────────────────────────────────────────────────────────────

  /// Opens Google Play Store for given package name
  /// Example: LinkOpenerHelper.openPlayStore('com.example.app')
  static Future<void> openPlayStore({required String packageName}) async {
    final uri = Uri.parse(
      'https://play.google.com/store/apps/details?id=$packageName',
    );
    await _launch(uri);
  }

  /// Opens Apple App Store for given app ID
  /// Example: LinkOpenerHelper.openAppStore('123456789')
  static Future<void> openAppStore({required String appId}) async {
    final uri = Uri.parse('https://apps.apple.com/app/id$appId');
    await _launch(uri);
  }

  // ─────────────────────────────────────────────────────────────────────────
  // 📄 FILE / DOCUMENT
  // ─────────────────────────────────────────────────────────────────────────

  /// Opens any file or document URL (PDF, DOC, etc.)
  /// Example: LinkOpenerHelper.openFile('https://example.com/file.pdf')
  static Future<void> openFile({required String fileUrl}) async {
    final uri = Uri.parse(fileUrl);
    await _launch(uri, mode: LaunchMode.externalApplication);
  }
}
