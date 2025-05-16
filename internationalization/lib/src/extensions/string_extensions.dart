import 'package:intl/intl.dart';

extension StringsExtensions on String {
  String convertDate() {
    try {
      const dateFormat = 'MM/dd/yyyy';
      final dateTime = DateTime.parse(this);
      return DateFormat(dateFormat).format(dateTime);
    } catch (e) {
      return '';
    }
  }

  DateTime toDateFormat() {
    try {
      return DateTime.parse(this);
    } catch (e) {
      return DateTime(0000);
    }
  }
}
