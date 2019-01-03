import 'package:flutter/material.dart';
import 'package:flutter/services.dart'show rootBundle;
import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter_app4/pages//HoleComment.dart';
/*
Future<List<Hole>> fetchHole() async {
  String jsonString = await _loadBBSAsset();
  return compute(parseHole,jsonString );
}
*/
Future<String> _loadBBSAsset() async {
  return await rootBundle.loadString('asset/hole_record.json');
}


Future<List<Hole>> fetchHole(http.Client client,String word) async {
  String url;
  if(word=='')
    url='http://132.232.131.25:8888/HOLE';
  else
    url = 'http://132.232.131.25:8888/HOLE'+'/SEARCH/'+word;
  final response = await http.get(url);
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return compute(parseHole, response.body);
    /*Hole.fromJson(json.decode(response.body));*/
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load hole');
  }
}

List<Hole> parseHole(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Hole>((json) => Hole.fromJson(json)).toList();
}

class Hole {
  //final int id;
  final int pid;
  final String text;
  final int reply;
  final int likenum;

  Hole({this.pid, this.text, this.reply,this.likenum});

  factory Hole.fromJson(Map<String, dynamic> json) {
    return Hole(
      //id: json['id'] as int,
      pid: json['pid'] as int,
      text: json['text'] as String,
      reply: json['reply']as int ,
      likenum: json['likenum']as int,
    );
  }
}
class HoleSearch extends StatefulWidget{
  final words;
  HoleSearch(this.words);
  @override
  _HoleSearchState  createState() => new _HoleSearchState(words);
}
class _HoleSearchState extends State<HoleSearch>{
  final words;
  _HoleSearchState(this.words);
  List<Hole> holes;
  static var now = new DateTime.now();
  static var formatter = new DateFormat('yyyy/MM/dd');


  String date = formatter.format(now);
  final _scrollController = ScrollController();
  // 生成数组
  final numbers = List.generate(8, (i) => i);
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // 监听现在的位置是否下滑到了底部
    _scrollController.addListener(() {
      if (_scrollController.offset ==
          _scrollController.position.maxScrollExtent) {
        // 加载更多数据
        if(numbers.length==holes.length) loadNothing();
        else loadMore(numbers.length);
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
        if((numbers.length+8)>holes.length) numbers.addAll(List.generate(holes.length-numbers.length, (i) => i + from));
        else numbers.addAll(List.generate(8, (i) => i + from));
      });
    }
    );
  }
  loadNothing()async{
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
    }
    await Future.delayed(Duration(seconds: 0), () {
      setState(() {
        isLoading = false;
      });
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("搜索结果"),
      ),    //将参数当作页面标题
      body: new Center(
        child: FutureBuilder<List<Hole>>(
          future: fetchHole(http.Client(),words),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              holes = snapshot.data;
              if(holes.length!=0)
              return ListView.builder(
                  itemCount: numbers.length+1,
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    if (index == numbers.length) {
                      if(numbers.length==holes.length)
                      { return new Center(
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("无新内容"),
                              Opacity(
                                opacity: isLoading ? 1.0 : 0.0,
                                child: CircularProgressIndicator(),
                              ),
                            ],
                          )
                      );
                      }
                      else
                        return new Center(
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("加载中…"),
                                Opacity(
                                  opacity: isLoading ? 1.0 : 0.0,
                                  child: CircularProgressIndicator(),
                                ),
                              ],
                            )

                        );
                    }
                    return new Card(
                        color: Colors.blue[50],
                        shape: RoundedRectangleBorder(borderRadius: const BorderRadius.all(const Radius.circular(25.0))),
                        //阴影大小-默认2.0
                        elevation: 5.0,
                        child: new RaisedButton(
                          onPressed: () {
                            Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
                              return new Hole_CommentPage(holes[index].pid.toString(), holes[index].text);
                            }
                            )
                            );
                          },
                          color:  Colors.blue[100],
                          padding: const EdgeInsets.all(0.0),
                          child: new Container(
                            margin: const EdgeInsets.all(10.0),
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                new Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    new Text(
                                        "热度排名:  ",
                                        style: new TextStyle(
                                            fontSize:12.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black
                                        )
                                    ),
                                    new Text(
                                        (index+1).toString() ,style: new TextStyle(fontSize: 14.0)
                                    ),
                                  ],
                                ),
                                new Text("\n",style: new TextStyle(fontSize:3.0,)),
                                new Text(holes[index].text,style: new TextStyle(
                                  color: Colors.black,
                                  fontSize:18.0,
                                  //fontWeight: FontWeight.bold,
                                ) ),
                                new Text("\n",style: new TextStyle(fontSize:8.0,)),
                                new Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    new Text("树洞号:    " ,
                                        style: new TextStyle(
                                          fontSize:12.0,
                                          fontWeight: FontWeight.bold,
                                        )
                                    ),
                                    new Text(holes[index].pid.toString(),style: new TextStyle(fontSize: 12.0)),
                                  ],
                                ),
                                new Divider(),//分割线
                                new Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    new Text(
                                        "回复数:   "  ,
                                        style: new TextStyle(
                                          fontSize:12.0,
                                          fontWeight: FontWeight.bold,
                                        )
                                    ),
                                    new Text(holes[index].reply.toString() ,style: new TextStyle(fontSize: 12.0)),
                                    new Text(
                                        "  关注数: "  ,
                                        style: new TextStyle(
                                          fontSize:12.0,
                                          fontWeight: FontWeight.bold,
                                        )
                                    ),
                                    new Text(holes[index].likenum.toString() ,style: new TextStyle(fontSize: 12.0))
                                  ],
                                ),
                                /*new Text(
                                    "想看详情，戳这里！" ,
                                    style: new TextStyle(
                                      color: Colors.blue,
                                      fontSize:10.0,
                                      fontWeight: FontWeight.bold,
                                    )
                                ),*///链接
                              ],
                            ),

                          ),
                        )
                    );
                  }
              );
              else return new Text("没有相关内容");
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default, show a loading spinner
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
/*class HolePage extends StatelessWidget {
  //final Future<Hole> hole;
  final String pageText;    //定义一个常量，用于保存跳转进来获取到的参数
  HolePage(this.pageText);    //构造函数，获取参数

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text(pageText),),    //将参数当作页面标题
      body: new Center(
        child: FutureBuilder<List<Hole>>(

          future: fetchHole(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return HolesList(holes: snapshot.data);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default, show a loading spinner
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}*/
class HolesList extends StatelessWidget {
  final List<Hole> holes;

  HolesList({Key key, this.holes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: holes.length,
        itemBuilder: (context, index) {
          return new Card(
            color: Colors.blue[50],
            shape: RoundedRectangleBorder(borderRadius: const BorderRadius.all(const Radius.circular(25.0))),
            //阴影大小-默认2.0
            elevation: 5.0,

            child: new Container(
              margin: const EdgeInsets.all(10.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                          "热度排名:  ",
                          style: new TextStyle(
                              fontSize:12.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                          )
                      ),
                      new Text(
                          index.toString() ,style: new TextStyle(fontSize: 14.0)
                      ),
                    ],
                  ),
                  new Text("\n",style: new TextStyle(fontSize:3.0,)),
                  new Text(holes[index].text,style: new TextStyle(
                    color: Colors.black,
                    fontSize:18.0,
                    //fontWeight: FontWeight.bold,
                  ) ),
                  new Text("\n",style: new TextStyle(fontSize:8.0,)),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Text("树洞号:    " ,
                          style: new TextStyle(
                            fontSize:12.0,
                            fontWeight: FontWeight.bold,
                          )
                      ),
                      new Text(holes[index].pid.toString(),style: new TextStyle(fontSize: 12.0)),
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                          "回复数:   "  ,
                          style: new TextStyle(
                            fontSize:12.0,
                            fontWeight: FontWeight.bold,
                          )
                      ),
                      new Text(holes[index].reply.toString() ,style: new TextStyle(fontSize: 12.0)),
                      new Text(
                          "  关注数: "  ,
                          style: new TextStyle(
                            fontSize:12.0,
                            fontWeight: FontWeight.bold,
                          )
                      ),
                      new Text(holes[index].likenum.toString() ,style: new TextStyle(fontSize: 12.0))
                    ],
                  ),
                  new Divider(),//分割线
                  new Text(
                      "想看详情，戳这里！" ,
                      style: new TextStyle(
                        color: Colors.blue,
                        fontSize:10.0,
                        fontWeight: FontWeight.bold,
                      )
                  ),//链接
                ],
              ),

            ),
          );
        }
    );
  }
}
