import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateFormatterHelper {
  static Widget dateFormatter({required List dateList, TextStyle ? textStyle}) {
    if (dateList.length < 3) {
      return Text('invaled date');
    }
    DateTime date = DateTime(dateList[0], dateList[1], dateList[2]);
    String formattedDate = DateFormat('dd/MM/yyyy').format(date);
    return Text('Date: $formattedDate',style: textStyle,);
  }
}
