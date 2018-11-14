import 'package:flutter/material.dart';
import 'dart:convert';

import 'dart:async';


import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<List<Post>> fetchPost(http.Client client) async {
  final response =
  await http.get('https://jsonplaceholder.typicode.com/posts');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return compute(parsePost, response.body);
    /*Post.fromJson(json.decode(response.body));*/
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

List<Post> parsePost(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Post>((json) => Post.fromJson(json)).toList();
}

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'],
    );
  }
}
class BBSPage extends StatelessWidget {
  //final Future<Post> post;
  final String pageText;    //定义一个常量，用于保存跳转进来获取到的参数

  BBSPage(this.pageText);    //构造函数，获取参数

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
    return ListView.builder(

        itemCount: posts.length,
        itemBuilder: (context, index) {
          return new SizedBox(
              height: 150.0,
              child: new Card(
                color: Colors.white,
                //阴影大小-默认2.0
                elevation: 5.0,
                child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                 children: <Widget>[
                new Text("Userid: " + posts[index].userId.toString(),
                    style: new TextStyle(
                      color: Colors.black,
                      fontSize:15.0,
                      fontWeight: FontWeight.bold,

                    )
                ),
                new Text("id: " + posts[index].id.toString()),
                new Text("title: " + posts[index].title),
                new Text(
                    "body: " + posts[index].body),

                  ],
                ),
              )
          );
        }
    );
  }
}


/*
        child: new ListView(
          children:<Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children:<Widget>[
                new Text('1',
                    style: new TextStyle(
                      color: Colors.red,
                      fontSize:20.0,
                      fontWeight: FontWeight.bold,
                    )
                ),
                new Text(
                  '[鹊桥]',
                  style: new TextStyle(
                    color: Colors.red,
                    fontSize:20.0,
                  )
                ),
                new Text(
                  '带征女婿',
                    style: new TextStyle(
                      color: Colors.black,
                      fontSize:20.0,
                      fontWeight: FontWeight.bold,
                    )
                )
              ],
            ),
            new Divider(),
            new Text(
              '1[鹊桥]     带征女婿',
                style: new TextStyle(
                    color: Colors.green, // 或者用这种写法：const Color(0xFF6699FF) 必须使用AARRGGBB
                    fontSize: 20.0, // 字号
                    fontWeight: FontWeight.bold, // 字体加粗
                    //fontStyle: FontStyle.italic, // 斜体
                    //decoration: new TextDecoration.combine([TextDecoration.underline]) // 文本加下划线
                ),
            ),
            new Divider(),
            new Text(
                '2[三角地]  【法条+讨论】燕南119执法中的法律问题全直击',
                style: new TextStyle(
                    color: Colors.red, // 或者用这种写法：const Color(0xFF6699FF) 必须使用AARRGGBB
                    fontSize: 20.0, // 字号
                    fontWeight: FontWeight.bold, // 字体加粗
                    //fontStyle: FontStyle.italic, // 斜体
                    decoration: new TextDecoration.combine([TextDecoration.underline]) // 文本加下划线
                ),
            ),
            new Divider(),
            new Text(
                '3[笑口常开] 因为抓人事件和男朋友吵到了分手边缘',
              style: new TextStyle(
                  color: Colors.black, // 或者用这种写法：const Color(0xFF6699FF) 必须使用AARRGGBB
                  fontSize: 20.0, // 字号
                  fontWeight: FontWeight.bold, // 字体加粗
                  //fontStyle: FontStyle.italic, // 斜体
                  decoration: new TextDecoration.combine([TextDecoration.underline]) // 文本加下划线
              ),
            ),
          ],
        ),
 */

/*{"id": "1", "title":
"因为抓人事件和男朋友吵到了分手边缘", "board": "笑口常开(Joke)",
"author": "ALMonds", "link": "https://bdwm.net/v2/post-read.php?b
id=72&threadid=16774640"}*/
/*
        child: new FutureBuilder(
            future: DefaultAssetBundle
                .of(context)
                .loadString('data_repo/starwars_data.json'),

            builder: (context, snapshot) {
              // Decode the JSON
              var new_data = json.decode(snapshot.data.toString());

              return new ListView.builder(
                // Build the ListView
                itemBuilder: (BuildContext context, int index) {
                  return new Card(
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        new Text("id: " + new_data[index]['id']),
                        new Text("title: " + new_data[index]['title']),
                        new Text("author: " + new_data[index]['author']),
                        new Text(
                            "board: " + new_data[index]['board']),
                        new Text(
                            "link: " + new_data[index]['link']),
                        /*
                        new Text(
                            "Eye Color: " + new_data[index]['eye_color']),
                        new Text(
                            "Birth Year: " + new_data[index]['birth_year']),
                        new Text("Gender: " + new_data[index]['gender'])*/
                      ],
                    ),
                  );
                },
                itemCount: new_data == null ? 0 : new_data.length,
              );
            }),
 */