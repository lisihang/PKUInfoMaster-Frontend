import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:flutter_app4/pages//HomePage.dart';
import 'package:flutter_app4/pages//HomePage1.dart';
import 'package:flutter_app4/pages//HomePage2.dart';
import 'package:flutter_app4/pages//BBSPage1.dart';
import 'package:flutter_app4/pages//BBSDatePage.dart';
import 'package:flutter_app4/pages//HolePage.dart';
import 'package:flutter_app4/pages//LecturePage.dart';
import 'package:flutter_app4/pages//TicketPage1.dart';
import 'package:flutter_app4/pages//SplashPage.dart';

void main() => runApp(new MaterialApp( home: new HomePage(),
  routes: <String, WidgetBuilder>{"bbs": (_) => BBSDatePage(""),'hole':(_)=> HolePage(),'lecture':(_) =>LecturePage("讲座"),'ticket':(_)=>TicketPage(""),'HomePage': (BuildContext context) => new HomePage()},
)

  /*(
    title: 'FlutterDemo',
    routes: <String,WidgetBuilder>{//配置路径
      '/HomePage':(BuildContext context)  => new HomePage(),
    },
    theme: new ThemeData(
      // This is the theme of your application.
      //
      // Try running your application with "flutter run". You'll see the
      // application has a blue toolbar. Then, without quitting the app, try
      // changing the primarySwatch below to Colors.green and then invoke
      // "hot reload" (press "r" in the console where you ran "flutter run",
      // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
      // counter didn't reset back to zero; the application is not restarted.
      primarySwatch: Colors.blue,
    ),
    home: new SplashPage()
  )*/
);

