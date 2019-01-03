import 'package:flutter/material.dart';
import 'package:flutter/services.dart'show rootBundle;
import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

/*
Future<List<Hole>> fetchHole() async {
  String jsonString = await _loadBBSAsset();
  return compute(parseHole,jsonString );
}
*/
Future<String> _loadBBSAsset() async {
  return await rootBundle.loadString('asset/hole_record.json');
}


Future<List<Hole_Comment>> fetchHole_Comment(http.Client client,String pid) async {
  String url;
  if(pid=='')
    url='http://132.232.131.25:8888/HOLE';
  else
    url = 'http://132.232.131.25:8888/HOLE'+'/'+pid;
  final response = await http.get(url);
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return compute(parseHole_comment, response.body);
    /*Hole.fromJson(json.decode(response.body));*/
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load hole_comment');
  }
}

List<Hole_Comment> parseHole_comment(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Hole_Comment>((json) => Hole_Comment.fromJson(json)).toList();
}

class Hole_Comment {
  //final int id;
  final int pid;
  final String text;
  final String name;

  Hole_Comment({this.pid, this.text, this.name});

  factory Hole_Comment.fromJson(Map<String, dynamic> json) {
    return Hole_Comment(
      //id: json['id'] as int,
      pid: json['pid'] as int,
      text: json['text'] as String,
      name: json['name']as String,
    );
  }
}
class Hole_CommentPage extends StatefulWidget{
  final String pid;
  final String text;
  Hole_CommentPage(this.pid,this.text);
  @override
  _Hole_CommentPageState  createState() => new _Hole_CommentPageState(pid,text);
}
class _Hole_CommentPageState extends State<Hole_CommentPage>{
  final String pid;
  final String text;
  _Hole_CommentPageState(this.pid,this.text);
  List<Hole_Comment> holes_comment;
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
        if(numbers.length==holes_comment.length) loadNothing();
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
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
        if((numbers.length+8)>holes_comment.length) numbers.addAll(List.generate(holes_comment.length-numbers.length, (i) => i + from));
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
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    print("pid:"+pid);
    print("text:"+text);
    return new Scaffold(
      appBar: new AppBar(title: new Text("树洞详情"),),    //将参数当作页面标题
      body: new Center(
        child: FutureBuilder<List<Hole_Comment>>(
          future: fetchHole_Comment(http.Client(),pid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              holes_comment = snapshot.data;
              return FutureBuilder<List<Hole_Comment>>(
                future: fetchHole_Comment(http.Client(),pid),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    holes_comment = snapshot.data;
                    return
                    ListView.builder(
                  itemCount: holes_comment.length+3,
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    if(index==0)
                      return Text("\n原文\n",style: new TextStyle(fontSize: 15,fontFamily: "simkai",fontWeight: FontWeight.bold,),);
                    else if(index==1)
                      return new Container(
                        //color: Colors.blue[200],
                        padding: EdgeInsets.only(left: 8,right: 8),
                        child: new RaisedButton(
                          onPressed: () {
                            //Navigator.of(context).pushNamed("bbs");
                          },
                          color:  Colors.blue[100],
                          padding: const EdgeInsets.all(5.0),
                          child: new Container(
                            margin: const EdgeInsets.all(10.0),
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Text(text,style: new TextStyle(
                                  color: Colors.black,
                                  fontSize:15.0,
                                  //fontWeight: FontWeight.bold,
                                ) ),
                                new Divider(),//分割线
                              ],
                            ),

                          ),
                        ),
                      );

                      //return Text(text+"\n评论\n",style: new TextStyle(fontSize: 15,fontFamily: "simkai"),);
                    else if(index==2)
                      return Text("\n评论\n",style: new TextStyle(fontSize: 15,fontFamily: "simkai",fontWeight: FontWeight.bold,),);
                    else
                      return Container(
                        padding: EdgeInsets.only(left:5,right:5),
                        child:new Card(
                            color: Colors.blue[50],
                            shape: RoundedRectangleBorder(borderRadius: const BorderRadius.all(const Radius.circular(25.0))),
                            //阴影大小-默认2.0
                            elevation: 5.0,
                            child: new RaisedButton(
                              onPressed: () {
                                //Navigator.of(context).pushNamed("bbs");
                              },
                              color:  Colors.blue[100],
                              padding: const EdgeInsets.all(0.0),
                              child: new Container(
                                margin: const EdgeInsets.all(10.0),
                                child: new Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    /*new Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    new Text(
                                        "#:  ",
                                        style: new TextStyle(
                                            fontSize:12.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black
                                        )9
                                    ),
                                  ],
                                ),*/
                                    new Text(holes_comment[index-3].text,style: new TextStyle(
                                      color: Colors.black,
                                      fontSize:15.0,
                                      //fontWeight: FontWeight.bold,
                                    ) ),
                                    new Divider(),//分割线
                                  ],
                                ),

                              ),
                            )
                        ),
                      );

                  }
              );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  // By default, show a loading spinner
                  return CircularProgressIndicator();
                },
              );
              /*ListView.builder(
                  itemCount: numbers.length+1,
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    if (index == numbers.length) {
                      if(numbers.length==holes_comment.length)
                      {
                        return Center(
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
                      else  return Center(
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
                    if(index==0)
                      return Text("评论\n",style: new TextStyle(fontSize: 15,fontFamily: "simkai"),);
                    else
                    return new Card(
                        color: Colors.blue[50],
                        shape: RoundedRectangleBorder(borderRadius: const BorderRadius.all(const Radius.circular(25.0))),
                        //阴影大小-默认2.0
                        elevation: 5.0,
                        child: new RaisedButton(
                          onPressed: () {
                            //Navigator.of(context).pushNamed("bbs");
                          },
                          color:  Colors.blue[100],
                          padding: const EdgeInsets.all(0.0),
                          child: new Container(
                            margin: const EdgeInsets.all(10.0),
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                /*new Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    new Text(
                                        "#:  ",
                                        style: new TextStyle(
                                            fontSize:12.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black
                                        )
                                    ),

                                  ],
                                ),*/
                                //new Text("\n",style: new TextStyle(fontSize:3.0,)),
                                new Text(holes_comment[index-1].text,style: new TextStyle(
                                  color: Colors.black,
                                  fontSize:15.0,
                                  fontWeight: FontWeight.bold,
                                ) ),
                                new Divider(),//分割线
                              ],
                            ),

                          ),
                        )
                    );
                  }
              );*/
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
