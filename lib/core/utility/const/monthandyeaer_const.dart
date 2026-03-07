// Month model 
 
 class _MonthModel {
  final String name;
  final int number;

  _MonthModel(this.name, this.number);
 }

class MonthAndYearConst {

  // Month List 
  static List<_MonthModel> months = [
    _MonthModel('january', 1),
    _MonthModel('february', 2),
    _MonthModel('march', 3),
    _MonthModel('april', 4),
    _MonthModel('may', 5),
    _MonthModel('june', 6),
    _MonthModel('july', 7),
    _MonthModel('august', 8),
    _MonthModel('september', 9),
    _MonthModel('october', 10),
    _MonthModel('november', 11),
    _MonthModel('december', 12),
  ];
 
  // Year list 
 
  List<int> years = List.generate(5, (index) => DateTime.now().year - index);
}
