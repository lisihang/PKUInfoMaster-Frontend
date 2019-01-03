import 'package:flutter/material.dart';
import 'package:flutter_app4/pages//SidebarPage.dart';
import 'package:flutter_app4/pages//ClassPage.dart';
class TabTest1 extends StatelessWidget {
  final int len = 8;
  final List<String> titles = ["一教", "二教", "三教", "四教", "理教", "文史", "电教", "哲学"];

  final TextStyle selected_style = new TextStyle(
      fontSize: 14.0, fontWeight: FontWeight.bold);
  final TextStyle unselected_style = new TextStyle(
      fontSize: 12.0, fontWeight: FontWeight.bold);

  final List<Tab> tabs = new List<Tab>();

  final List<ClassPage> news_pages = new List<ClassPage>();

  @override
  Widget build(BuildContext context) {

    createTabs();

    createTabVews();

    return new DefaultTabController(
        length: len,
        initialIndex: 0,
        child: new Column(
          children: <Widget>[
            new Container(
              color: Colors.lightBlue,
              child: new AspectRatio(
                  aspectRatio: 8.0,
                  child: new TabBar(
                      isScrollable: true,
                      indicatorColor: Colors.white,
                      indicatorWeight: 2.0,
                      labelStyle: selected_style,
                      unselectedLabelStyle: unselected_style,
                      tabs: tabs)),
            ),
            new Expanded(child: new TabBarView(children: news_pages))
          ],
        )
    );
  }

  void createTabs(){
    for(int i=0;i<len;i++){
      tabs.add(new Tab(text: titles[i],));
    }
  }

  void createTabVews(){
    for(int i=0;i<len;i++){
      news_pages.add(new ClassPage(titles[i].toString()));
    }
  }
}

class TabTest extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("空闲教室"),),
      body: new TabTest1(),
    );
  }
}