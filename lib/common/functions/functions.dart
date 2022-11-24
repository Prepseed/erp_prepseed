import 'package:intl/intl.dart';
class Functions{
  String? fromDate;
  dateFormatter(date){
    var fromDateTime = DateTime.parse(date.toString());
    var fromDateParse = DateFormat("yyyy-MM-dd HH:mm").parse(fromDateTime.toString(), true);
    print(fromDateParse);
    fromDate = DateFormat("dd-MMM").format(fromDateParse.toLocal()).toString();
    return fromDate;
  }

}