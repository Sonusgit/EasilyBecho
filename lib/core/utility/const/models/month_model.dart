
class MonthModel {
  final String name;         // 'January'
  final String shortName;    // 'Jan'
  final int number;          // 1–12

  const MonthModel({
    required this.name,
    required this.shortName,
    required this.number,
  });

  @override
  String toString() => name;
}