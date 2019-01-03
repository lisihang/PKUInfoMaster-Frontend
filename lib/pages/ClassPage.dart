import 'package:flutter/material.dart';
import 'package:flutter/services.dart'show rootBundle;
import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
/*Future<Product> fetchPost(http.Client client) async {
  final response = await http.get('http://132.232.131.25:8888/CLASSROOM');
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
*/
Future<List<Post>> fetchPost() async {
  String jsonString = await _loadBBSAsset();
  return compute(parsePost,jsonString );
}

Future<String> _loadBBSAsset() async {
  return await rootBundle.loadString('asset/class_record.json');
}
List<Post> parsePost(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Post>((json) => Post.fromJson(json)).toList();
}
class Product{
  final List<Post> build1;
  final List<Post> build2;
  final List<Post> build3;
  final List<Post> build4;
  final List<Post> build5;
  final List<Post> build6;
  final List<Post> build7;
  final List<Post> build8;
  Product({this.build1, this.build2, this.build3,this.build4,this.build5,this.build6,this.build7,this.build8});
  factory Product.fromJson(List <dynamic> parsedJson){

    var list1 = parsedJson[0]['一教'] as List;
    List<Post> build1List = list1.map((i) => Post.fromJson(i)).toList();
    var list2 = parsedJson[0]['二教'] as List;
    List<Post> build2List = list2.map((i) => Post.fromJson(i)).toList();
    var list3 = parsedJson[0]['三教'] as List;
    List<Post> build3List = list3.map((i) => Post.fromJson(i)).toList();
    var list4 = parsedJson[0]['四教'] as List;
    List<Post> build4List = list4.map((i) => Post.fromJson(i)).toList();
    var list5 = parsedJson[0]['理教'] as List;
    List<Post> build5List = list5.map((i) => Post.fromJson(i)).toList();
    var list6 = parsedJson[0]['文史'] as List;
    List<Post> build6List = list6.map((i) => Post.fromJson(i)).toList();
    var list7 = parsedJson[0]['电教'] as List;
    List<Post> build7List = list7.map((i) => Post.fromJson(i)).toList();
    var list8 = parsedJson[0]['哲学'] as List;
    List<Post> build8List = list8.map((i) => Post.fromJson(i)).toList();

    return Product(
      build1: build1List,
      build2: build2List,
      build3: build3List,
      build4: build4List,
      build5: build5List,
      build6: build6List,
      build7: build7List,
      build8: build8List,
    );
  }
}
class Post {
  final String room;
  final String capacity;
  final String c1;
  final String c2;
  final String c3;
  final String c4;
  final String c5;
  final String c6;
  final String c7;
  final String c8;
  final String c9;
  final String c10;
  final String c11;
  final String c12;

  Post({this.room, this.capacity, this.c1,this.c2,this.c3,this.c4,this.c5,this.c6,this.c7,this.c8,this.c9,this.c10,this.c12,this.c11,});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      room: json['room'] as String,
      capacity: json['cap'] as String,
      c1: json['c1'] as String,
      c2: json['c2'] as String,
      c3: json['c3'] as String,
      c4: json['c4'] as String,
      c5: json['c5'] as String,
      c6: json['c6'] as String,
      c7: json['c7'] as String,
      c8: json['c8'] as String,
      c9: json['c9'] as String,
      c10: json['c10'] as String,
      c11: json['c11'] as String,
      c12: json['c12'] as String,
    );
  }
}
class ClassPage extends StatelessWidget {

  //final Future<Post> post;
  final String pageText;    //定义一个常量，用于保存跳转进来获取到的参数
  ClassPage(this.pageText);    //构造函数，获取参数
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      //appBar: new AppBar(title: new Text(pageText),),    //将参数当作页面标题
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
    return new Scaffold(
      /*appBar: new AppBar(title: new Text(pageText),),
        new Container(
          color: Colors.red[700],
          width : MediaQuery.of(context).size.width/4,
          height: MediaQuery.of(context).size.height/20,
          child: new Text(posts[index-3].total.toString()),
        ),*/
        body:  new GridView.builder(
          //padding: const EdgeInsets.all(5.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 14,
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0,
          ),
          itemCount: posts.length*14,
          itemBuilder: (BuildContext context, int index) {
            switch (index%14) {
              case 0:
                return new Container(
                  color: Colors.blue[100],
                  width: MediaQuery.of(context).size.width / 15,
                  height: MediaQuery.of(context).size.height/30,
                  child: new Text(posts[(index / 14).toInt()].room.toString(),style: new TextStyle(fontSize: 12),),
                );
                break;
              case 1:
                return new Container(
                  color: Colors.blue[100],
                  width: MediaQuery.of(context).size.width / 15,
                  height: MediaQuery.of(context).size.height/20,
                  child: new Text(posts[(index / 14).toInt()].capacity.toString(),style: new TextStyle(fontSize: 12),),
                );
                break;
              case 2:
                if(posts[(index / 14).toInt()].c1 =="")
                return new Container(
                  color: Colors.green[300],
                  width: MediaQuery.of(context).size.width / 15,
                  height: MediaQuery.of(context).size.height/20,
                  //child: new Text(posts[(index / 14).toInt()].c1.toString()),
                );
                else
                  return new Container(
                    color: Colors.grey[300],
                    width: MediaQuery.of(context).size.width / 15,
                    height: MediaQuery.of(context).size.height/20,
                    //child: new Text(posts[(index / 14).toInt()].c1.toString()),
                  );
                break;
              case 3:
                if(posts[(index / 14).toInt()].c2 =="")
                  return new Container(
                    color: Colors.green[300],
                    width: MediaQuery.of(context).size.width / 15,
                    height: MediaQuery.of(context).size.height/20,
                    //child: new Text(posts[(index / 14).toInt()].c1.toString()),
                  );
                else
                  return new Container(
                    color: Colors.grey[300],
                    width: MediaQuery.of(context).size.width / 15,
                    height: MediaQuery.of(context).size.height/20,
                    //child: new Text(posts[(index / 14).toInt()].c1.toString()),
                  );
                break;
              case 4:
                if(posts[(index / 14).toInt()].c3 =="")
                  return new Container(
                    color: Colors.green[300],
                    width: MediaQuery.of(context).size.width / 15,
                    height: MediaQuery.of(context).size.height/20,
                    //child: new Text(posts[(index / 14).toInt()].c1.toString()),
                  );
                else
                  return new Container(
                    color: Colors.grey[300],
                    width: MediaQuery.of(context).size.width / 15,
                    height: MediaQuery.of(context).size.height/20,
                    //child: new Text(posts[(index / 14).toInt()].c1.toString()),
                  );
                break;
              case 5:
                if(posts[(index / 14).toInt()].c4 =="")
                  return new Container(
                    color: Colors.green[300],
                    width: MediaQuery.of(context).size.width / 15,
                    height: MediaQuery.of(context).size.height/20,
                    //child: new Text(posts[(index / 14).toInt()].c1.toString()),
                  );
                else
                  return new Container(
                    color: Colors.grey[300],
                    width: MediaQuery.of(context).size.width / 15,
                    height: MediaQuery.of(context).size.height/20,
                    //child: new Text(posts[(index / 14).toInt()].c1.toString()),
                  );
                break;
              case 6:
                if(posts[(index / 14).toInt()].c5 =="")
                  return new Container(
                    color: Colors.green[300],
                    width: MediaQuery.of(context).size.width / 15,
                    height: MediaQuery.of(context).size.height/20,
                    //child: new Text(posts[(index / 14).toInt()].c1.toString()),
                  );
                else
                  return new Container(
                    color: Colors.grey[300],
                    width: MediaQuery.of(context).size.width / 15,
                    height: MediaQuery.of(context).size.height/20,
                    //child: new Text(posts[(index / 14).toInt()].c1.toString()),
                  );
                break;
              case 7:
                if(posts[(index / 14).toInt()].c6 =="")
                  return new Container(
                    color: Colors.green[300],
                    width: MediaQuery.of(context).size.width / 15,
                    height: MediaQuery.of(context).size.height/20,
                    //child: new Text(posts[(index / 14).toInt()].c1.toString()),
                  );
                else
                  return new Container(
                    color: Colors.grey[300],
                    width: MediaQuery.of(context).size.width / 15,
                    height: MediaQuery.of(context).size.height/20,
                    //child: new Text(posts[(index / 14).toInt()].c1.toString()),
                  );
                break;
              case 8:
                if(posts[(index / 14).toInt()].c7 =="")
                  return new Container(
                    color: Colors.green[300],
                    width: MediaQuery.of(context).size.width / 15,
                    height: MediaQuery.of(context).size.height/20,
                    //child: new Text(posts[(index / 14).toInt()].c1.toString()),
                  );
                else
                  return new Container(
                    color: Colors.grey[300],
                    width: MediaQuery.of(context).size.width / 15,
                    height: MediaQuery.of(context).size.height/20,
                    //child: new Text(posts[(index / 14).toInt()].c1.toString()),
                  );
                break;
              case 9:
                if(posts[(index / 14).toInt()].c8 =="")
                  return new Container(
                    color: Colors.green[300],
                    width: MediaQuery.of(context).size.width / 15,
                    height: MediaQuery.of(context).size.height/20,
                    //child: new Text(posts[(index / 14).toInt()].c1.toString()),
                  );
                else
                  return new Container(
                    color: Colors.grey[300],
                    width: MediaQuery.of(context).size.width / 15,
                    height: MediaQuery.of(context).size.height/20,
                    //child: new Text(posts[(index / 14).toInt()].c1.toString()),
                  );
                break;
              case 10:
                if(posts[(index / 14).toInt()].c9 =="")
                  return new Container(
                    color: Colors.green[300],
                    width: MediaQuery.of(context).size.width / 15,
                    height: MediaQuery.of(context).size.height/20,
                    //child: new Text(posts[(index / 14).toInt()].c1.toString()),
                  );
                else
                  return new Container(
                    color: Colors.grey[300],
                    width: MediaQuery.of(context).size.width / 15,
                    height: MediaQuery.of(context).size.height/20,
                    //child: new Text(posts[(index / 14).toInt()].c1.toString()),
                  );
                break;
              case 11:
                if(posts[(index / 14).toInt()].c10 =="")
                  return new Container(
                    color: Colors.green[300],
                    width: MediaQuery.of(context).size.width / 15,
                    height: MediaQuery.of(context).size.height/20,
                    //child: new Text(posts[(index / 14).toInt()].c1.toString()),
                  );
                else
                  return new Container(
                    color: Colors.grey[300],
                    width: MediaQuery.of(context).size.width / 15,
                    height: MediaQuery.of(context).size.height/20,
                    //child: new Text(posts[(index / 14).toInt()].c1.toString()),
                  );
                break;
              case 12:
                if(posts[(index / 14).toInt()].c11 =="")
                  return new Container(
                    color: Colors.green[300],
                    width: MediaQuery.of(context).size.width / 15,
                    height: MediaQuery.of(context).size.height/20,
                    //child: new Text(posts[(index / 14).toInt()].c1.toString()),
                  );
                else
                  return new Container(
                    color: Colors.grey[300],
                    width: MediaQuery.of(context).size.width / 15,
                    height: MediaQuery.of(context).size.height/20,
                    //child: new Text(posts[(index / 14).toInt()].c1.toString()),
                  );
                break;
              case 13:
                if(posts[(index / 14).toInt()].c12 =="")
                  return new Container(
                    color: Colors.green[300],
                    width: MediaQuery.of(context).size.width / 15,
                    height: MediaQuery.of(context).size.height/20,
                    //child: new Text(posts[(index / 14).toInt()].c1.toString()),
                  );
                else
                  return new Container(
                    color: Colors.grey[300],
                    width: MediaQuery.of(context).size.width / 15,
                    height: MediaQuery.of(context).size.height/20,
                    //child: new Text(posts[(index / 14).toInt()].c1.toString()),
                  );
                break;

             }
          },

        )
    );
  }
}
