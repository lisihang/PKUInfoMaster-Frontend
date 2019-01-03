/*import 'package:flutter/material.dart';
import 'package:flutter_app4/pages//SidebarPage.dart';
import 'package:flutter_app4/pages//BBSPage.dart';
import 'package:flutter_app4/pages//BBSPage1.dart';
import 'package:flutter_app4/pages//SlideView.dart';
import 'package:flutter_app4/pages//TicketPage.dart';
import 'package:flutter_app4/pages//TestPage.dart';
import 'package:flutter_app4/pages//TicketPage1.dart';
import 'package:flutter_app4/pages//AboutPage.dart';
import 'package:flutter_app4/pages//AboutPage1.dart';
import 'package:flutter_app4/pages//Canteen_indexPage.dart';
import 'package:flutter_app4/pages//Canteen_indexPage2.dart';
import 'package:flutter_app4/pages//LecturePage.dart';
import 'package:flutter_app4/pages//HolePage.dart';
class HomePage1 extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
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

class _HomePageState extends State<HomePage1> {
  final posts;
  _HomePageState(this.posts);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(title: new Text("PKUInfoMaster"), backgroundColor: Colors.blueAccent,),  //头部的标题AppBar
        drawer: new Drawer(     //侧边栏按钮Drawer
          child: new ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(   //Material内置控件
                accountName: new Text(
                    'Alice',
                    style: new TextStyle(
                      color: Colors.black45,
                      fontSize:15.0,
                      fontWeight: FontWeight.bold,
                    )
                ), //用户名
                accountEmail: new Text(
                  '你若安好，便是晴天',
                  style: new TextStyle(
                    color: Colors.black45,
                    fontSize: 15.0, // 字号
                    fontWeight: FontWeight.bold, // 字体加粗
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
              new ListTile(   //第一个功能项
                  leading: new Icon(
                    Icons.account_balance,
                    color: Colors.blue[500],
                  ),
                  title: new Text('讲座资讯'),
                  trailing: new Icon(Icons.arrow_right),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new LecturePage('讲座资讯')));
                  }
              ),//讲座资讯
              new Divider(),
              new ListTile(   //票务界面
                  leading: new Icon(
                    Icons.movie,
                    color: Colors.blue[500],
                  ),
                  title: new Text('票务信息'),
                  trailing: new Icon(Icons.arrow_right),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new TicketPage1("票务")));
                  }
              ),//票务界面
              new Divider(),
              new ListTile(   //树洞热点界面
                  leading: new Icon(
                    Icons.favorite_border,
                    color: Colors.blue[500],
                  ),
                  title: new Text('树洞热点'),
                  trailing: new Icon(Icons.arrow_right),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new HolePage('树洞热点')));
                  }
              ),
              new Divider(),    //分割线控件
              new ListTile(   //BBS界面
                  leading: new Icon(
                    Icons.comment,
                    color: Colors.blue[500],
                  ),
                  title: new Text('BBS十大'),
                  trailing: new Icon(Icons.arrow_right),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new BBSPage1('BBS')));
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
                    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new Canteen_indexPage2('就餐指数')));
                  }
              ),
              new Divider(),
              new ListTile(   //设置界面
                  title: new Text('设置'),
                  leading: new Icon(
                    Icons.filter_vintage,
                    color: Colors.blue[500],
                  ),
                  trailing: new Icon(Icons.arrow_right),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new SidebarPage('设置')));
                  }
              ),
              new Divider(),
              new ListTile(   //关于界面
                  leading: new Icon(
                    Icons.help,
                    color: Colors.blue[500],
                  ),
                  title: new Text('关于'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new AboutPage('关于')));
                  }
              ),
            ],
          ),
        ),
        body:new Center(
          child: FutureBuilder<List<Post>>(
            future: fetchPost(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Message(posts: snapshot.data);
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

class Message extends StatelessWidget{
  List messages=["BBS","树洞","讲座","票务"];
  var date = "2018/12/";
  @override
  Widget build(BuildContext context){
    return new ListView.builder(
        itemCount: 20,
        itemBuilder: (context,index){
          if (index%4==0)
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Container(
                  width:0.01*MediaQuery.of(context).size.width,
                  height:MediaQuery.of(context).size.height/5,
                  margin: const EdgeInsets.only(left: 10),
                  color: Colors.blue[200],
                ),
                new Container(
                  height:MediaQuery.of(context).size.height/5,
                  width:0.15*MediaQuery.of(context).size.width,
                  child:new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:<Widget>[
                      new Text(date+(index%4+6).toString()+'\n',style: new TextStyle(fontWeight: FontWeight.bold),),
                      new Text(messages[index%4]),
                      new Center(
                        child: new Container(
                          height:3,
                          width:0.15*MediaQuery.of(context).size.width,
                          color: Colors.blue[200],
                        ),
                      ),
                    ],
                  ),
                ),
                new Container(
                  width:0.8*MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/5,
                  child: new Card(
                      elevation: 5.0,
//shape: CircleBorder(),
                      color: Colors.blue[200],
                      child: new Container(
                        child: Text(messages[index%4]),
                      )
                  ),
                ),
              ],
            );
          else
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Container(
                  width:0.01*MediaQuery.of(context).size.width,
                  height:MediaQuery.of(context).size.height/5,
                  margin: const EdgeInsets.only(left: 10),
                  color: Colors.blue[200],
                ),
                new Container(
                  height:MediaQuery.of(context).size.height/5,
                  width:0.15*MediaQuery.of(context).size.width,
                  child:new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:<Widget>[
                      new Text("\n"),
                      new Text(messages[index%4]),
                      new Center(
                        child: new Container(
                          height:3,
                          width:0.15*MediaQuery.of(context).size.width,
                          color: Colors.blue[200],
                        ),
                      ),
                    ],
                  ),
                ),
                new Container(
                  width:0.8*MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/5,
                  child: new Card(
                      elevation: 5.0,
//shape: CircleBorder(),
                      color: Colors.blue[200],
                      child: new Container(
                        child: Text(messages[index%4]),
                      )
                  ),
                ),
              ],
            );
        }
    );
  }
}*/

