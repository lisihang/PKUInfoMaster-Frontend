import 'package:flutter/material.dart';
import 'package:flutter/services.dart'show rootBundle;
import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_app4/pages/SlideView.dart';
import 'package:http/http.dart' as http;

/*
Future<List<Post>> fetchPost() async {
  String jsonString = await _loadBBSAsset();
  return compute(parsePost,jsonString );
}
*/
Future<String> _loadBBSAsset() async {
  return await rootBundle.loadString('asset/ticket_record.json');
}


Future<List<Post>> fetchPost(http.Client client,String date) async {
  String url;
  if(date=='')
     url='http://132.232.131.25:8888/TICKET';
  else
     url = 'http://132.232.131.25:8888/TICKET'+'/'+date;
  final response = await http.get(url);
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return compute(parsePost, response.body);
    /*Post.fromJson(json.decode(response.body));*/
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}
var slideData = [];
Future<List<dynamic>> fetchPicture(http.Client client) async {
  var url = 'http://132.232.131.25:8888/TICKET/PICTURE';
  final response = await http.get(url);
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    List<dynamic> url = json.decode(response.body);
    //Data();
    return url;
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
  final String date;
  final String time;
  final String place;
  final String title;
  final String price;
  final String status;
  final String link;

  Post({this.date, this.time, this.place, this.title,this.price,this.status,this.link});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      date: json['date'] as String,
      time: json['time'] as String,
      place: json['place'] as String,
      title: json['title']as String ,
      price: json['price']as String,
      status: json['status'] as String,
      link: json['link']as String,
    );
  }
}
class TicketPage1 extends StatelessWidget {
  //final Future<Post> post;

  final List<Post> posts;

  TicketPage1({Key key, this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Data();
    return  new Center(
        child: FutureBuilder<List<dynamic>>(
          future: fetchPicture(http.Client()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              for (int i = 0; i <3; i++) {
                Map map = new Map();
                // 轮播图的资讯标题
                map['title'] = '';
                // 轮播图的详情URL
                //map['detailUrl'] = 'https://www.oschina.net/news/98455/guido-van-rossum-resigns';
                // 轮播图的图片URL
                map['imgUrl'] =snapshot.data[i];
                //map['title'] = 'Python 之父透露退位隐情，与核心开发团队产生隔阂';
                // 轮播图的详情URL
                //map['detailUrl'] = 'https://www.oschina.net/news/98455/guido-van-rossum-resigns';
                //map['imgUrl'] = 'https://static.oschina.net/uploads/img/201807/30113144_1SRR.png';
                slideData.add(map);
              }
              return PostsList(posts: posts,data:slideData);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default, show a loading spinner
            return CircularProgressIndicator();
          },
        ),

    );
  }
}
class TicketPage extends StatelessWidget{
  final String pageText;    //定义一个常量，用于保存跳转进来获取到的参数
  TicketPage(this.pageText);    //构造函数，获取参数
  @override
  Widget build(BuildContext context) {
    //Data();
    return new Scaffold(
      appBar: new AppBar(title: new Text("票务信息"),),    //将参数当作页面标题
      body: new Center(
        child: FutureBuilder<List<Post>>(
          future: fetchPost(http.Client(),pageText),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return TicketPage1(posts: snapshot.data);
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
Data() async{
  List links = await fetchPicture(http.Client());
  // 这里做数据初始化，加入一些测试数据
  print("准备死循环");
  while(links.length<3){}
  print("没有死循环！");
  for (int i = 0; i <3; i++) {
    Map map = new Map();
    // 轮播图的资讯标题
    map['title'] = '';
    // 轮播图的详情URL
    //map['detailUrl'] = 'https://www.oschina.net/news/98455/guido-van-rossum-resigns';
    // 轮播图的图片URL
    map['imgUrl'] =links[i];
    //map['title'] = 'Python 之父透露退位隐情，与核心开发团队产生隔阂';
    // 轮播图的详情URL
    //map['detailUrl'] = 'https://www.oschina.net/news/98455/guido-van-rossum-resigns';
    //map['imgUrl'] = 'https://static.oschina.net/uploads/img/201807/30113144_1SRR.png';
    slideData.add(map);
  }
}
class PostsList extends StatelessWidget {
  final List<Post> posts;
  final List<dynamic>data;

  PostsList({Key key, this.posts,this.data}) : super(key: key);

  @override
  Widget build(BuildContext context)  {

    /*Data();

    for(int i=0;i<3;i++){
      print(slideData[i].toString());
    }*/
   // Data();

    return  ListView.builder(
        itemCount: posts.length+1,
        itemBuilder: (context, index) {
          if (index == 0) {

            return new Container(
              height: 180.0,
              child: new SlideView(data),
            );
          }
          return new Card(
            color: Colors.blue[50],
            shape: RoundedRectangleBorder(borderRadius: const BorderRadius.all(const Radius.circular(25.0))),
            //阴影大小-默认2.0
            elevation: 5.0,

            child: new Container(
              margin: const EdgeInsets.all(5.0),
              child: new Row(
                children: <Widget>[
                  new Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width/7,
                      margin: const EdgeInsets.only(top:10,bottom: 10),
                      child: new Center(
                          child: new Image.network(posts[index-1].link,fit: BoxFit.fill,)
                      )
                  ),
                  new Container(
                    width:3*MediaQuery.of(context).size.width/4,
                    margin: const EdgeInsets.only(left: 5),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            new Text(
                                "日期:  ",
                                style: new TextStyle(
                                    fontSize:12.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black
                                )
                            ),
                            new Text(
                                posts[index-1].date.toString() ,style: new TextStyle(fontSize: 14.0)
                            ),
                            new Text(
                                "  时间:  ",
                                style: new TextStyle(
                                    fontSize:12.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black
                                )
                            ),
                            new Text(
                                posts[index-1].time.toString() ,style: new TextStyle(fontSize: 14.0)
                            ),
                          ],
                        ),
                        /*new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[

                          ],
                        ),*/
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            new Text(
                                "地点:  ",
                                style: new TextStyle(
                                    fontSize:12.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black
                                )
                            ),
                            new Text(
                                posts[index-1].place.toString() ,style: new TextStyle(fontSize: 14.0)
                            ),
                          ],
                        ),
                        new Text(posts[index-1].title,style: new TextStyle(
                          color: Colors.black,
                          fontSize:15.0,
                          //fontWeight: FontWeight.bold,
                        ) ),
                        //new Text("\n",style: new TextStyle(fontSize:8.0,)),

                        new Text("票价: "+ posts[index-1].price.toString()+"   售票情况:   "+posts[index-1].status.toString(),
                            style: new TextStyle(
                              fontSize:12.0,
                              fontWeight: FontWeight.bold,
                            )
                        ),
                        new Divider(),//分割线
                      ],
                    ),
                  )
                ],
              )


            ),
          );
        }
    );
  }
}
