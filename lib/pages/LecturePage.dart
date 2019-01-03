import 'package:flutter/material.dart';
import 'package:flutter/services.dart'show rootBundle;
import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_app4/pages//TestPage.dart';
import 'package:http/http.dart' as http;


Future<List<Post>> fetchPost(http.Client client) async {
  final response = await http.get('http://132.232.131.25:8888/LECTURE');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return compute(parsePost, response.body);
    /*Post.fromJson(json.decode(response.body));*/
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

/*
Future<List<Post>> fetchPost() async {
  String jsonString = await _loadBBSAsset();
  return compute(parsePost,jsonString );
}
*/
Future<String> _loadBBSAsset() async {
  return await rootBundle.loadString('asset/lecture_record.json');
}

List<Post> parsePost(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Post>((json) => Post.fromJson(json)).toList();
}

class Post {
  //final int id;
  final String title;
  final String speaker;
  final String time;
  final String place;
  final String date;

  Post({this.title, this.speaker,this.time,this.place,this.date});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        speaker: json['speaker'] as String,
        //id: json['id'] as int,
        title: json['title'] as String,
        time: json['time'],
        place: json['place'],
        date: json['date']
    );
  }
}
class LecturePage extends StatelessWidget {
  //final Future<Post> post;
  final String pageText;    //定义一个常量，用于保存跳转进来获取到的参数

  LecturePage(this.pageText);    //构造函数，获取参数

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text(pageText),),    //将参数当作页面标题
      body: new Center(
        child: FutureBuilder<List<Post>>(

          future: fetchPost(http.Client()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return PostsList(posts: snapshot.data);
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
class PostsList extends StatelessWidget {
  final List<Post> posts;
  PostsList({Key key, this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.blue[50],
        child: new ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              //if(index==0) return new TestPage();
              return new Container(
                //color: Colors.blue[200],
                padding: const EdgeInsets.all(8),
                child: new RaisedButton(
                  onPressed: () {
                    //Navigator.of(context).pushNamed("bbs");
                  },
                  color:  Colors.blue[200],
                  padding: const EdgeInsets.all(0.0),
                  child: new Container(
                      //height:135,
                      margin: const EdgeInsets.all(5.0),
                      child: new Row(
                        //crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          new Container(
                              height: 70,
                              width: MediaQuery.of(context).size.width/7,
                              margin: const EdgeInsets.only(top:10,bottom: 10),
                              child: new Center(
                                  child: new Image.asset('images/lecture.png')
                              )
                          ),
                          new Container(
                            //height:150,
                            width: 3*MediaQuery.of(context).size.width/4,
                            margin: const EdgeInsets.only(left: 10),
                            child:new Center(
                              child: new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  new Text(posts[index].title,style: new TextStyle(fontSize: 15),),
                                  new Text("\n",style: new TextStyle(fontSize:3.0,)),
                                  new Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      new Text("主讲人: " ,
                                          style: new TextStyle(
                                            fontSize:14.0,
                                            fontWeight: FontWeight.bold,
                                          )
                                      ),
                                      new Text(posts[index].speaker.toString(),style: new TextStyle(fontSize: 14.0)),
                                    ],
                                  ),
                                  new Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      new Text(
                                          "时间:   "  ,
                                          style: new TextStyle(
                                            fontSize:14.0,
                                            fontWeight: FontWeight.bold,
                                          )
                                      ),
                                      new Text( posts[index].date+'  ' +posts[index].time,style: new TextStyle(fontSize: 14.0))
                                    ],
                                  ),
                                  new Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      new Text(
                                          "地点:   "  ,
                                          style: new TextStyle(
                                            fontSize:14.0,
                                            fontWeight: FontWeight.bold,
                                          )
                                      ),
                                      new Text( posts[index].place,style: new TextStyle(fontSize: 14.0))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
              );


            }
        ),
    );
  }
}

/*new Container(
                height:150,
              decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  color:Colors.transparent,
                  image: new DecorationImage(
                      image: new ExactAssetImage('images/lecture.jpg'),
                      fit:BoxFit.cover
                  ),
                  border: new Border.all(
                      color:Colors.black45,
                      width:1.0
                  )
              )

              ),*/
