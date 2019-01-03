import 'package:flutter/material.dart';
import 'package:flutter_app4/pages//SidebarPage.dart';
import 'package:flutter_app4/pages//BBSPage1.dart';
import 'package:flutter_app4/pages//BBS_ALLInfoPage.dart';
import 'package:flutter_app4/pages//SlideView.dart';
import 'package:flutter_app4/pages//TicketPage1.dart';
import 'package:flutter_app4/pages//AboutPage.dart';
import 'package:flutter_app4/pages//Canteen_indexPage.dart';
import 'package:flutter_app4/pages//Canteen_indexPage2.dart';
import 'package:flutter_app4/pages//LecturePage.dart';
import 'package:flutter_app4/pages//HolePage.dart';
import 'package:flutter_app4/pages//HoleComment.dart';
import 'package:flutter_app4/pages//ClassPage.dart';
import 'package:flutter_app4/pages//Test.dart';
import 'package:flutter_app4/pages//TabTest.dart';
import 'package:intl/intl.dart';

import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_app4/pages//HolePage.dart';
import 'package:flutter_app4/pages//LecturePage.dart';
import 'package:flutter_app4/pages//TicketPage1.dart';
import 'package:flutter_app4/pages//SplashPage.dart';

class Product {
  final List<Lecture> lectures;
  final List<BBS> bbs;
  final List<Ticket> tickets;
  final List<Hole> holes;

  Product({this.lectures, this.bbs, this.tickets,this.holes});

  factory Product.fromJson(Map<String, dynamic> parsedJson){

    var list1 = parsedJson['LECTURE'] as List;
    //print(list.runtimeType);
    List<Lecture> lecturesList = list1.map((i) => Lecture.fromJson(i)).toList();

    var list2 = parsedJson['HOLE'] as List;
    //print(list.runtimeType);
    List<Hole>holesList ;
    if(list2.length==0){
      holesList=[];
    }
    else
      holesList = list2.map((i) => Hole.fromJson(i)).toList();

    var list3 = parsedJson['BBS'] as List;
    //print(list.runtimeType);
    List<BBS> bbsList;
    if (list3.length==0){
      bbsList=[];
    }
    else  bbsList = list3.map((i) => BBS.fromJson(i)).toList();

    var list4 = parsedJson['TICKET'] as List;
    //print(list.runtimeType);
    List<Ticket> ticketsList;
    if (list4.length==0){
      ticketsList=[];
    }
    else  ticketsList = list4.map((i) => Ticket.fromJson(i)).toList();

    return Product(
      lectures: lecturesList,
      holes: holesList,
      bbs: bbsList,
      tickets: ticketsList,
    );
  }
}

class Lecture {
  final String title;
  final String date;
  final String place;
  Lecture({this.title,this.date,this.place});
  factory Lecture.fromJson(Map<String, dynamic> parsedJson){
    return Lecture(
        title:parsedJson['title'],
        date:parsedJson['date'],
        place:parsedJson['place']
    );
  }
}
class BBS {
  final String title;
  BBS({this.title});
  factory BBS.fromJson(Map<String, dynamic> parsedJson){
    return BBS(
        title:parsedJson['title']
    );
  }
}
class Ticket {
  final String title;
  final String date;
  final String time;
  Ticket({this.title,this.date,this.time});
  factory Ticket.fromJson(Map<String, dynamic> parsedJson){
    return Ticket(
      title:parsedJson['title'],
      date: parsedJson['date'],
      time: parsedJson['time'],
    );
  }
}
class Hole {
  final String text;
  Hole({this.text});
  factory Hole.fromJson(Map<String, dynamic> parsedJson){
    return Hole(
        text:parsedJson['text']
    );
  }
}

Future<Product> fetchPost(http.Client client,String date) async {
  String url;

  url='http://132.232.131.25:8888/MAIN/'+date;

  final response = await http.get(url);
  //final response = await http.get('http://132.232.131.25:8888/MAIN' + '/'+date);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    final jsonResponse = json.decode(response.body);
    Product product = new Product.fromJson(jsonResponse);
    return product;
    /*Post.fromJson(json.decode(response.body));*/
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class HomePage2 extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage2>{
  //final Product product = snapshot.hasData;
  List messages=["BBS","树洞","讲座","票务"];
  //var date = "2018/12/25";
  static var now = new DateTime.now();
  static var formatter = new DateFormat('yyyy/MM/dd');


  String Date = formatter.format(now);
  static var formatter1 = new DateFormat('M');
  String month = formatter1.format(now);
  static var formatter2 = new DateFormat('d');
  String day = formatter2.format(now);
  final _scrollController = ScrollController();
  // 生成数组
  final numbers = List.generate(1, (i) => i);
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // 监听现在的位置是否下滑到了底部
    _scrollController.addListener(() {
      if (_scrollController.offset ==
          _scrollController.position.maxScrollExtent) {
        // 加载更多数据
        loadMore(numbers.length);
      }
    });
  }

  loadMore(int from) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
    }
    // 延迟处理任务
    await Future.delayed(Duration(seconds: 0), () {
      setState(() {
        isLoading = false;
        numbers.addAll(List.generate(1, (i) => i + from));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(title: new Text("PKUInfoMaster",
            style: new TextStyle(
              fontFamily: "TimesRoman",
            )), backgroundColor: Colors.blueAccent,),
        drawer: new Drawer( //侧边栏按钮Drawer
          child: new ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader( //Material内置控件
                accountName: new Text(
                    'Alice',
                    style: new TextStyle(
                      color: Colors.black45,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: "TimesRoman",
                    )
                ), //用户名
                accountEmail: new Text(
                  '你若安好，便是晴天',
                  style: new TextStyle(
                    color: Colors.black45,
                    fontSize: 18.0, // 字号
                    fontWeight: FontWeight.bold, // 字体加粗
                    fontFamily: "simkai",
                    //fontStyle: FontStyle.italic, // 斜体
                    //decoration: new TextDecoration.combine([TextDecoration.underline]) // 文本加下划线
                  ),

                ),
                decoration: new BoxDecoration(
                  //用一个BoxDecoration装饰器提供背景图片
                  image: new DecorationImage(

                    fit: BoxFit.fill,
                    //image: new NetworkImage('https://raw.githubusercontent.com/flutter/website/master/_includes/code/layout/lakes/images/lake.jpg')
                    //可以试试图片调取自本地。调用本地资源，需要到pubspec.yaml中配置文件路径
                    image: new ExactAssetImage('images/cat2.jpg'),
                  ),
                ),
              ),
              new ListTile( //第一个功能项
                  leading: new Icon(
                    Icons.account_balance,
                    color: Colors.blue[500],
                  ),
                  title: new Text('讲座资讯'),
                  trailing: new Icon(Icons.arrow_right),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => new LecturePage(
                            '讲座资讯')));
                  }
              ), //讲座资讯
              new Divider(),
              new ListTile( //票务界面
                  leading: new Icon(
                    Icons.movie,
                    color: Colors.blue[500],
                  ),
                  title: new Text('票务信息'),
                  trailing: new Icon(Icons.arrow_right),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => new TicketPage("")));
                  }
              ), //票务界面
              new Divider(),
              new ListTile( //树洞热点界面
                  leading: new Icon(
                    Icons.favorite_border,
                    color: Colors.blue[500],
                  ),
                  title: new Text('树洞热点'),
                  trailing: new Icon(Icons.arrow_right),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => new HolePage()));
                  }
              ),
              new Divider(), //分割线控件
              new ListTile( //BBS界面
                  leading: new Icon(
                    Icons.comment,
                    color: Colors.blue[500],
                  ),
                  title: new Text('BBS十大'),
                  trailing: new Icon(Icons.arrow_right),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => new Test()));
                  }
              ),
              new Divider(),
              new ListTile(
                  title: new Text('就餐指数'),
                  leading: new Icon(
                    Icons.restaurant,
                    color: Colors.blue[500],
                  ),
                  trailing: new Icon(Icons.arrow_right),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(new MaterialPageRoute(builder: (
                        BuildContext context) =>
                    new Canteen_indexPage2('就餐指数')));
                  }
              ),
              new Divider(),
              new ListTile( //空闲教室界面
                  title: new Text('空闲教室'),
                  leading: new Icon(
                    Icons.class_,
                    color: Colors.blue[500],
                  ),
                  trailing: new Icon(Icons.arrow_right),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => new TabTest()));
                  }
              ),
              new Divider(),

              new Divider(),
              new ListTile( //关于界面
                  leading: new Icon(
                    Icons.help,
                    color: Colors.blue[500],
                  ),
                  title: new Text('关于'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => new AboutPage(
                            "关于")));
                  }
              ),
            ],
          ),
        ),
        body:
        new ListView.builder(
            itemCount: numbers.length+1,
            controller: _scrollController,
            itemBuilder: (context, index1) {
              if (index1 == numbers.length&&index1!=0) {
                return Center(
                  child: Opacity(
                    opacity: isLoading ? 1.0 : 0.0,
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              else {
                print("index1=="+index1.toString());
                return new Container(
                    height:0.8*MediaQuery.of(context).size.height,
                    child: FutureBuilder<Product>(
                        future: fetchPost(http.Client(), Date),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            print("hasdata");
                            Product product = snapshot.data;
                            return
                              new ListView.builder(
                                  itemCount: 4,
                                  //controller: _scrollController,
                                  itemBuilder: (context, index) {
                                    /*if (index == numbers.length&&index!=0) {
                                return Center(
                                  child: Opacity(
                                    opacity: isLoading ? 1.0 : 0.0,
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }*/
                                    if (index % 4 == 0) {
                                      List <String>message = ['', '', ''];
                                      for (int i = 0; i < 3; i++) {
                                        if (product.bbs.length > (i))
                                          message[i] = "↪" +
                                              product.bbs[(i).toInt()].title;
                                        else if (i == 0)
                                          message[i] = '今天没有相关的新资讯哦';
                                        else
                                          message[i] = '';
                                      }
                                      return new Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        children: <Widget>[
                                          new Container(
                                            width: 0.01 * MediaQuery
                                                .of(context)
                                                .size
                                                .width,
                                            height: MediaQuery
                                                .of(context)
                                                .size
                                                .height / 5,
                                            margin: const EdgeInsets.only(
                                                left: 10),
                                            color: Colors.blue[200],
                                          ),
                                          new Container(
                                            height: MediaQuery
                                                .of(context)
                                                .size
                                                .height / 5,
                                            width: 0.15 * MediaQuery
                                                .of(context)
                                                .size
                                                .width,
                                            child: new Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: <Widget>[
                                                new Text(
                                                  month.toString() + '/' +
                                                      (int.parse(
                                                          day.toString()) -
                                                          (index / 4).toInt())
                                                          .toString() + '\n',
                                                  style: new TextStyle(
                                                      fontWeight: FontWeight
                                                          .bold),),
                                                new Text(messages[index % 4]),
                                                new Center(
                                                  child: new Container(
                                                    height: 3,
                                                    width: 0.15 * MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width,
                                                    color: Colors.blue[200],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          new Container(
                                            width: 0.8 * MediaQuery
                                                .of(context)
                                                .size
                                                .width,
                                            height: MediaQuery
                                                .of(context)
                                                .size
                                                .height / 5,
                                            child: new Card(
                                                elevation: 5.0,
                                                //shape: CircleBorder(),
                                                color: Colors.blue[200],
                                                child: new RaisedButton(
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                        new MaterialPageRoute(
                                                            builder: (
                                                                BuildContext context) =>
                                                            new BBS_ALLInfoPage(
                                                                "BBS")));
                                                    //Navigator.of(context).pushNamed("bbs");
                                                  },
                                                  color: Colors.blue[200],
                                                  padding: const EdgeInsets.all(
                                                      0.0),
                                                  child: new Column(
                                                    //mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    children: <Widget>[
                                                      Text(message[0],
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 2,
                                                        style: new TextStyle(
                                                            fontSize: 20,
                                                            fontFamily: "华文行楷"),),
                                                      Text(message[1],
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 2,
                                                        style: new TextStyle(
                                                            fontSize: 20,
                                                            fontFamily: "华文行楷"),),
                                                      Text(message[2],
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 2,
                                                        style: new TextStyle(
                                                            fontSize: 20,
                                                            fontFamily: "华文行楷"),),
                                                    ],
                                                  ),
                                                )
                                            ),
                                          ),
                                        ],
                                      );
                                    }

                                    else if (index % 4 == 1) {
                                      List <String>message = ['', '', ''];
                                      for (int i = 0; i < 3; i++) {
                                        if (product.holes.length > (i))
                                          message[i] = "➢" +
                                              product.holes[(i).toInt()].text;
                                        else if (i == 0)
                                          message[i] = '今天没有相关的新资讯哦';
                                        else
                                          message[i] = '';
                                      }
                                      return new Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        children: <Widget>[
                                          new Container(
                                            width: 0.01 * MediaQuery
                                                .of(context)
                                                .size
                                                .width,
                                            height: MediaQuery
                                                .of(context)
                                                .size
                                                .height / 5,
                                            margin: const EdgeInsets.only(
                                                left: 10),
                                            color: Colors.blue[200],
                                          ),
                                          new Container(
                                            height: MediaQuery
                                                .of(context)
                                                .size
                                                .height / 5,
                                            width: 0.15 * MediaQuery
                                                .of(context)
                                                .size
                                                .width,
                                            child: new Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: <Widget>[
                                                new Text("\n"),
                                                new Text(messages[index % 4]),
                                                new Center(
                                                  child: new Container(
                                                    height: 3,
                                                    width: 0.15 * MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width,
                                                    color: Colors.blue[200],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          new Container(
                                            width: 0.8 * MediaQuery
                                                .of(context)
                                                .size
                                                .width,
                                            height: MediaQuery
                                                .of(context)
                                                .size
                                                .height / 5,
                                            child: new Card(
                                              elevation: 5.0,
                                              //shape: CircleBorder(),
                                              color: Colors.blue[200],
                                              child: new RaisedButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pushNamed("hole");
                                                  },
                                                  color: Colors.blue[200],
                                                  padding: const EdgeInsets.all(
                                                      0.0),
                                                  child: new Column(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    children: <Widget>[
                                                      Text(
                                                        message[0], maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: new TextStyle(
                                                            fontSize: 15,
                                                            fontFamily: "simkai"),),
                                                      Text(
                                                        message[1], maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: new TextStyle(
                                                            fontSize: 15,
                                                            fontFamily: "simkai"),),
                                                      Text(
                                                        message[2], maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: new TextStyle(
                                                            fontSize: 15,
                                                            fontFamily: "simkai"),),
                                                    ],

                                                  )
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                    else if (index % 4 == 2) {
                                      //print(product.tickets.length);
                                      List <String>message = [
                                        '', '', '', '', '', ''];
                                      for (int i = 0; i < 6; i++) {
                                        if (i % 2 == 0) {
                                          if (product.lectures.length > (i / 2))
                                            message[i] = ">" +
                                                product.lectures[(i / 2)
                                                    .toInt()].title;
                                          else if (i == 0)
                                            message[i] = '今天没有相关的新资讯哦';
                                          else
                                            message[i] = '';
                                        }
                                        else {
                                          if (product.lectures.length > (i / 2))
                                            message[i] = "---" +
                                                product.lectures[(i / 2)
                                                    .toInt()].date +
                                                product.lectures[(i / 2)
                                                    .toInt()].place;
                                          else
                                            message[i] = '';
                                        }
                                      }
                                      return new Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        children: <Widget>[
                                          new Container(
                                            width: 0.01 * MediaQuery
                                                .of(context)
                                                .size
                                                .width,
                                            height: MediaQuery
                                                .of(context)
                                                .size
                                                .height / 5,
                                            margin: const EdgeInsets.only(
                                                left: 10),
                                            color: Colors.blue[200],
                                          ),
                                          new Container(
                                            height: MediaQuery
                                                .of(context)
                                                .size
                                                .height / 5,
                                            width: 0.15 * MediaQuery
                                                .of(context)
                                                .size
                                                .width,
                                            child: new Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: <Widget>[
                                                new Text("\n"),
                                                new Text(messages[index % 4]),
                                                new Center(
                                                  child: new Container(
                                                    height: 3,
                                                    width: 0.15 * MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width,
                                                    color: Colors.blue[200],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          new Container(
                                            width: 0.8 * MediaQuery
                                                .of(context)
                                                .size
                                                .width,
                                            height: MediaQuery
                                                .of(context)
                                                .size
                                                .height / 5,
                                            child: new Card(
                                                elevation: 5.0,
                                                //shape: CircleBorder(),
                                                color: Colors.blue[200],
                                                child: new RaisedButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pushNamed("lecture");
                                                    },
                                                    color: Colors.blue[200],
                                                    padding: const EdgeInsets
                                                        .all(0.0),
                                                    child: new Column(
                                                      crossAxisAlignment: CrossAxisAlignment
                                                          .start,
                                                      children: <Widget>[
                                                        //Text("今天没有相关的新资讯哦"),
                                                        Text(message[0],
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: new TextStyle(
                                                            fontSize: 15,),),
                                                        Text(message[1],
                                                          style: new TextStyle(
                                                            fontSize: 15,),),
                                                        Text(message[2],
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: new TextStyle(
                                                            fontSize: 15,),),
                                                        Text(message[3],
                                                          style: new TextStyle(
                                                            fontSize: 15,),),
                                                        Text(message[4],
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: new TextStyle(
                                                            fontSize: 15,),),
                                                        Text(message[5],
                                                          style: new TextStyle(
                                                            fontSize: 15,),),
                                                        /*Text(">"+product.lectures[0].title,overflow: TextOverflow.ellipsis,style:  new TextStyle(fontSize: 13,fontFamily: "Bookman Old Style Bold Italic"),),
                                                    Text(">"+product.lectures[1].title,overflow: TextOverflow.ellipsis,style:  new TextStyle(fontSize: 13,fontFamily: "Bookman Old Style Bold Italic"),),
                                                    Text(">"+product.lectures[2].title,overflow: TextOverflow.ellipsis,style:  new TextStyle(fontSize: 13,fontFamily: "Bookman Old Style Bold Italic"),),*/
                                                      ],

                                                    )
                                                )
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                    else {
                                      List <String>message = [
                                        '', '', '', '', '', ''];
                                      for (int i = 0; i < 6; i++) {
                                        if (i % 2 == 0) {
                                          if (product.tickets.length > (i / 2))
                                            message[i] = "✼" +
                                                product.tickets[(i / 2).toInt()]
                                                    .title;
                                          else if (i == 0)
                                            message[i] = '今天没有相关的新资讯哦';
                                          else
                                            message[i] = '';
                                        }
                                        else {
                                          if (product.tickets.length > (i / 2))
                                            message[i] = "---" +
                                                product.tickets[(i / 2).toInt()]
                                                    .date +
                                                product.tickets[(i / 2).toInt()]
                                                    .time;
                                          else
                                            message[i] = '';
                                        }
                                      }
                                      return new Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        children: <Widget>[
                                          new Container(
                                            width: 0.01 * MediaQuery
                                                .of(context)
                                                .size
                                                .width,
                                            height: MediaQuery
                                                .of(context)
                                                .size
                                                .height / 5,
                                            margin: const EdgeInsets.only(
                                                left: 10),
                                            color: Colors.blue[200],
                                          ),
                                          new Container(
                                            height: MediaQuery
                                                .of(context)
                                                .size
                                                .height / 5,
                                            width: 0.15 * MediaQuery
                                                .of(context)
                                                .size
                                                .width,
                                            child: new Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: <Widget>[
                                                new Text("\n"),
                                                new Text(messages[index % 4]),
                                                new Center(
                                                  child: new Container(
                                                    height: 3,
                                                    width: 0.15 * MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width,
                                                    color: Colors.blue[200],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          new Container(
                                            width: 0.8 * MediaQuery
                                                .of(context)
                                                .size
                                                .width,
                                            height: MediaQuery
                                                .of(context)
                                                .size
                                                .height / 5,
                                            child: new Card(
                                                elevation: 5.0,
                                                //shape: CircleBorder(),
                                                color: Colors.blue[200],
                                                child: new RaisedButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pushNamed("ticket");
                                                    },
                                                    color: Colors.blue[200],
                                                    padding: const EdgeInsets
                                                        .all(0.0),
                                                    child: new Column(
                                                      //crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        //Text("今天没有相关的新资讯哦"),
                                                        Text(message[0],
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: new TextStyle(
                                                            fontSize: 15,),),
                                                        Text(message[1],
                                                          style: new TextStyle(
                                                            fontSize: 15,),),
                                                        Text(message[2],
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: new TextStyle(
                                                            fontSize: 15,),),
                                                        Text(message[3],
                                                          style: new TextStyle(
                                                            fontSize: 15,),),
                                                        Text(message[4],
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: new TextStyle(
                                                            fontSize: 15,),),
                                                        Text(message[5],
                                                          style: new TextStyle(
                                                            fontSize: 15,),),
                                                      ],
                                                    )
                                                )
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                  }
                              );
                          }
                          else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }
                          // By default, show a loading spinner
                          return Image.asset("images/ic_launcher.png");
                        }
                    )
                );
              }
            }
        )
    );
  }
}
