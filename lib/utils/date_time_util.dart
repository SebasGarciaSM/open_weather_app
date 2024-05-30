import 'package:intl/intl.dart';

class DateTimeUtil {
  static String get12HourFormat(DateTime? date) {
    if (date != null) {
      var format = DateFormat('ha');
      return format.format(date);
    } else {
      return '';
    }
  }

  static String getDayName(DateTime? date) {
    if (date != null) {
      var format = DateFormat('EEEE');
      return format.format(date);
    } else {
      return '';
    }
  }

  static String getDayNameAnd12Hour(DateTime? date) {
    if (date != null) {
      // var format = DateFormat('EEEE');
      // return format.format(date);
      var now = DateTime.now();

      if ((date.day == now.day) &&
          (date.month == now.month) &&
          (date.year == now.year)) {
        return "Today at ${get12HourFormat(date)}";
      } else {
        return "${getDayName(date)} at ${get12HourFormat(date)}";
      }
    } else {
      return '';
    }
  }
}
