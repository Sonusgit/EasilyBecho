import 'package:easilybecho/core/common/user_loction/model/user_location_model.dart';
import 'package:easilybecho/core/utility/const/models/month_model.dart';

// ─────────────────────────────────────────────────────────────────────────────
//
//  AppConst — Single Config File for Entire App
//
//  Usage:
//    AppConst.monthList            → List<MonthModel>
//    AppConst.yearList             → List<int>
//    AppConst.userLocation.city    → String?
//    AppConst.userLocation.state   → String?
//    AppConst.userLocation.country → String?
//    AppConst.userLocation.lat     → double?
//    AppConst.userLocation.lng     → double?
//
// ─────────────────────────────────────────────────────────────────────────────

class AppConst {
  AppConst._(); // private — no instances

  // ══════════════════════════════════════════════════════════════════════════
  // 📅 MONTH LIST
  // ══════════════════════════════════════════════════════════════════════════

  static const List<MonthModel> monthList = [
    MonthModel(name: 'January', shortName: 'Jan', number: 1),
    MonthModel(name: 'February', shortName: 'Feb', number: 2),
    MonthModel(name: 'March', shortName: 'Mar', number: 3),
    MonthModel(name: 'April', shortName: 'Apr', number: 4),
    MonthModel(name: 'May', shortName: 'May', number: 5),
    MonthModel(name: 'June', shortName: 'Jun', number: 6),
    MonthModel(name: 'July', shortName: 'Jul', number: 7),
    MonthModel(name: 'August', shortName: 'Aug', number: 8),
    MonthModel(name: 'September', shortName: 'Sep', number: 9),
    MonthModel(name: 'October', shortName: 'Oct', number: 10),
    MonthModel(name: 'November', shortName: 'Nov', number: 11),
    MonthModel(name: 'December', shortName: 'Dec', number: 12),
  ];

  // ══════════════════════════════════════════════════════════════════════════
  // 📆 YEAR LIST  (current year + 4 previous years)
  // ══════════════════════════════════════════════════════════════════════════

  /// Returns [2026, 2025, 2024, 2023, 2022] — always relative to current year
  static List<int> get yearList =>
      List.generate(5, (i) => DateTime.now().year - i);

  // ══════════════════════════════════════════════════════════════════════════
  // 📍 USER LOCATION  (updated by LocationBloc)
  // ══════════════════════════════════════════════════════════════════════════

  static UserLocationModel _userLocation = const UserLocationModel.empty();

  /// Read-only access to current user location
  static UserLocationModel get userLocation => _userLocation;

  /// Called by LocationBloc when location is successfully fetched
  /// Do NOT call this directly — use LocationBloc instead
  static void setUserLocation(UserLocationModel location) {
    _userLocation = location;
  }

  /// Reset location to empty
  static void clearUserLocation() {
    _userLocation = const UserLocationModel.empty();
  }

  // ══════════════════════════════════════════════════════════════════════════
  // 🗓️ CURRENT DATE HELPERS
  // ══════════════════════════════════════════════════════════════════════════

  static int get currentYear => DateTime.now().year;
  static int get currentMonth => DateTime.now().month;
  static int get currentDay => DateTime.now().day;

  /// Returns current MonthModel from monthList
  static MonthModel get currentMonthModel =>
      monthList.firstWhere((m) => m.number == currentMonth);
}

// ─────────────────────────────────────────────────────────────────────────────
// Month Model — internal use only
// ─────────────────────────────────────────────────────────────────────────────
