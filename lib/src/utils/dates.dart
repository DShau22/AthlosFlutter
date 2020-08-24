import 'package:intl/intl.dart';

String parseUploadDate(var date) {
  DateFormat format = new DateFormat("yyyy-mm-ddThh:mm:ss.SSSZ");
  var parsed = format.parse(date);
  return '${parsed.month}/${parsed.day}';
}