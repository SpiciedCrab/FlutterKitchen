import 'package:intl/intl.dart';
import 'dart:core';
import 'package:intl/date_symbol_data_local.dart';

class FattenFormats {
  static String formatDate(DateTime date) {
    initializeDateFormatting("zh_CN");
    final f = new DateFormat('hh:mm', 'zh_CN');
    return f.format(date);
  }
}
