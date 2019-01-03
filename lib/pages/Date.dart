import 'package:intl/intl.dart';
main(){
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');
  var formatter1 = new DateFormat('d');
  String formatted = formatter.format(now);
  String formatted1 = formatter1.format(now);
  int a=int.parse(formatted1);
  print(a);
  print(formatted);
  print(formatted1.toString());
}
