import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import 'dart:async';


import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<List<Post>> fetchPost() async {
    String jsonString = await _loadAStudentAsset();
    return compute(parsePost,jsonString );
}

Future<String> _loadAStudentAsset() async {
  return await rootBundle.loadString('assert/record.json');
}

List<Post> parsePost(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Post>((json) => Post.fromJson(json)).toList();
}

class Post {
  final String author;
  final int id;
  final String title;
  final String board;
  final String link;

  Post({this.author, this.id, this.title, this.board,this.link});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      author: json['author'] as String,
      id: json['id'] as int,
      title: json['title'] as String,
      board: json['board'],
      link: json['link']
    );
  }
}
class BBSPage1 extends StatelessWidget {
  //final Future<Post> post;
  final String pageText;    //定义一个常量，用于保存跳转进来获取到的参数

  BBSPage1(this.pageText);    //构造函数，获取参数

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text(pageText),),    //将参数当作页面标题
      body: new Center(
        child: FutureBuilder<List<Post>>(

          future: fetchPost(),
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
    return ListView.builder(

        itemCount: posts.length,
        itemBuilder: (context, index) {
          return new SizedBox(
              height: 140.0,
              child: new Card(
                color: Colors.white,
                //阴影大小-默认2.0
                elevation: 5.0,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    new Text(
                        "热度排名: " + posts[index].id.toString() + "\n",
                        style: new TextStyle(
                          fontSize:13.0,
                          fontWeight: FontWeight.bold,
                        )
                    ),
                    new Text(
                        "标题: " + posts[index].title + "\n",
                        style: new TextStyle(
                          color: Colors.black,
                          fontSize:15.0,
                          fontWeight: FontWeight.bold,

                        )
                    ),
                    new Text("作者:  " + posts[index].author.toString(),
                        style: new TextStyle(
                          fontSize:13.0,
                          fontWeight: FontWeight.bold,
                        )
                    ),
                    new Text(
                        "版面: 【" + posts[index].board + "】",
                        style: new TextStyle(
                          fontSize:13.0,
                          fontWeight: FontWeight.bold,
                        )
                    ),
                    new Divider(),
                    new Text(
                      "传送门在这里，点我哟！" ,
                        style: new TextStyle(
                          color: Colors.blue,
                          fontSize:10.0,
                          fontWeight: FontWeight.bold,
                        )
                    )

                  ],
                ),
              )
          );
        }
    );
  }
}
