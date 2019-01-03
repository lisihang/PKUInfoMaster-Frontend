import 'package:flutter/material.dart';

import 'cardNavigation/cardNavigation.dart';
import 'cardNavigation/sections.dart';
import 'package:flutter_app4/pages//BBSPage1.dart';
import 'package:flutter_app4/pages//BBSDatePage.dart';

import 'package:intl/intl.dart';
const Color _mariner = const Color(0xFF3B5F8F);
const Color _mediumPurple = const Color(0xFF8266D4);
const Color _tomato = const Color(0xFFF95B57);
const Color _mySin = const Color(0xFFF3A646);
var now = new DateTime.now();
var formatter = new DateFormat('yyyy/MM/dd');
String Date = formatter.format(now);
var formatter1 = new DateFormat('M');
String month = formatter1.format(now);
var formatter2 = new DateFormat('d');
String day = formatter2.format(now);
var formatter3 = new DateFormat('y');
String year = formatter3.format(now);

List<CardSection> allSections = <CardSection>[
  new CardSection(
      title: '全部信息',
      leftColor: _mediumPurple,
      rightColor: _mariner,
      contentWidget: Center(child: new BBSDatePage(""))),
  new CardSection(
      title: '2019/1/2',
      leftColor: _mariner,
      rightColor: _mySin,
      contentWidget: Center(child: new BBSDatePage('2019/1/2'))),
  new CardSection(
      title: '2019/1/1',
      leftColor: _mySin,
      rightColor: _tomato,
      contentWidget: Center(child: new BBSDatePage('2019/1/1'))),
  new CardSection(
      title: '2018/12/31',
      leftColor: _tomato,
      rightColor: Colors.blue,
      contentWidget: Center(child: new BBSDatePage('2018/12/31'))),
  new CardSection(
      title: '2018/12/30',
      leftColor: Colors.blue,
      rightColor: _mediumPurple,
      contentWidget: Center(child: new BBSDatePage('2018/12/30'))),
];
class Test extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Center(
          child: new AnimateTabNavigation(
            sectionList: allSections,
            ),
        )

     );


    }
}