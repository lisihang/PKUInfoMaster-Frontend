import 'package:flutter/material.dart';
import 'package:flutter/services.dart'show rootBundle;
import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_app4/pages//BBS_Search.dart';

Future<List<Post>> fetchPost(http.Client client,String date) async {
  //final response = await http.get('http://132.232.131.25:8888/BBS' + '/'+date);
  String url;
  if(date=='')
    url='http://132.232.131.25:8888/BBS';
  else
    url = 'http://132.232.131.25:8888/BBS'+'/'+date;
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
/*Future<List<Post>> fetchPost() async {
  String jsonString = await _loadBBSAsset();
  return compute(parsePost,jsonString );
}*/

Future<String> _loadBBSAsset() async {
  return await rootBundle.loadString('asset/bbs_record.json');
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
class BBS_ALLInfoPage extends StatelessWidget {
  //final Future<Post> post;
  final String pageText;    //定义一个常量，用于保存跳转进来获取到的参数
  BBS_ALLInfoPage(this.pageText);
  TextEditingController searchController = TextEditingController();//构造函数，获取参数
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("BBS"),
        actions: <Widget>[
          Container(
              padding: const EdgeInsets.all(5),
              height: 2*kToolbarHeight/3,
              width:MediaQuery.of(context).size.width/2,
              child: new Container(
                //color: Colors.white,
                  child:new  TextField(
                    controller: searchController,
                    //onSubmitted: _textsubmitted,
                    //maxLength: 5,
                    //keyboardType: TextInputType.number,
                  )

              )

          ),
          IconButton(
            icon: Icon(Icons.search),
            //tooltip: 'Air it',
            onPressed: (){
              Navigator.of(context).push(new MaterialPageRoute(builder: (_)
              {return new BBS_Search(searchController.text);}
              ));
            },
          ),
        ],
      ),    //将参数当作页面标题
      body: new Center(
        child: FutureBuilder<List<Post>>(
          future: fetchPost(http.Client(),""),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return  PostsList(posts: snapshot.data);
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
  //var link;
  PostsList({Key key, this.posts}) : super(key: key);
  _launchURL(String link) async {
    String url = link;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return new Container(
      //color: Colors.blue[50],
      child: new ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            //link = posts[index].link;
            return new Card(
              color: Colors.blue[50],
              shape: RoundedRectangleBorder(borderRadius: const BorderRadius.all(const Radius.circular(25.0))),
              //阴影大小-默认2.0
              elevation: 3.0,
              child:new RaisedButton (
                color: Colors.blue[200],
                onPressed : (){_launchURL(posts[index].link);},
                child:  new Container(
                  margin: const EdgeInsets.only(left:10.0,right:10,top:10,bottom: 10),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Text(
                              "#",
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
                      /*new Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              //spacing: 2.0, // 水平方向上两个子组件的间距
                              //runSpacing: 20.0,
                              children: <Widget>[
                                new Text(
                                    "标题: " ,
                                    style: new TextStyle(
                                      color: Colors.black,
                                      fontSize:18.0,
                                      fontWeight: FontWeight.bold,
                                    )
                                ),

                              ],
                            ),*/
                      new Text(posts[index].title,style: new TextStyle(
                        color: Colors.black,
                        fontSize:18.0,
                        fontWeight: FontWeight.bold,
                        //fontWeight: FontWeight.bold,
                      ) ),
                      //new Text("\n",style: new TextStyle(fontSize:3.0,)),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Text("作者:    " ,
                              style: new TextStyle(
                                fontSize:12.0,
                                fontWeight: FontWeight.bold,
                              )
                          ),
                          new Text(posts[index].author.toString(),style: new TextStyle(fontSize: 12.0)),
                        ],
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Text(
                              "版面: "  ,
                              style: new TextStyle(
                                fontSize:12.0,
                                fontWeight: FontWeight.bold,
                              )
                          ),
                          new Text("【"+ posts[index].board + "】",style: new TextStyle(fontSize: 12.0))
                        ],
                      ),
                      // 热度排名
                      // 标题
                      //作者
                      //版面
                      new Divider(),//分割线

                      //链接
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

