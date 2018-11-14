import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter_app4/pages//BBSinfo.dart';

Future<String> _loadAStudentAsset() async {
  return await rootBundle.loadString('assets/record.json');
}
Future loadStudent() async {
  String jsonString = await _loadAStudentAsset();
  final jsonResponse = json.decode(jsonString);
  BBSinfo bbSinfo = new BBSinfo.fromJson(jsonResponse);
  print(bbSinfo.title);
}

