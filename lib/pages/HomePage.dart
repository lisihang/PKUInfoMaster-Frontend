import 'package:flutter/material.dart';
import 'package:flutter_app4/pages//SidebarPage.dart';
import 'package:flutter_app4/pages//BBSPage1.dart';
import 'package:flutter_app4/pages//SlideView.dart';
import 'package:flutter_app4/pages//TicketPage1.dart';
import 'package:flutter_app4/pages//TestPage.dart';
import 'package:flutter_app4/pages//AboutPage.dart';
//import 'package:flutter_app4/pages//EatingInfo_Page.dart';
import 'package:flutter_app4/pages//Canteen_indexPage.dart';
import 'package:flutter_app4/pages//LecturePage.dart';
import 'package:flutter_app4/pages//HolePage.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {

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

              ),  //用户邮箱
              /*currentAccountPicture: new GestureDetector( //用户头像
                onTap: () => print('current user'),
                child: new CircleAvatar(    //圆形图标控件
                  backgroundImage: new NetworkImage('https://upload.jianshu.io/users/upload_avatars/7700793/dbcf94ba-9e63-4fcf-aa77-361644dd5a87?imageMogr2/auto-orient/strip|imageView2/1/w/240/h/240'),//图片调取自网络
                ),
              ),*/
              decoration: new BoxDecoration(    //用一个BoxDecoration装饰器提供背景图片
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
                  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new TicketPage("票务")));
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
                  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new HolePage()));
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
                  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new Canteen_indexPage1('就餐指数')));
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
      body: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

          new Align(
            alignment: Alignment.topLeft,
            child: new  Container(
                  width:10,
                  height:1000,

                  margin: const EdgeInsets.only(left: 10),
                  child: new  ListView.builder(

                    //mainAxisAlignment: MainAxisAlignment.start,
                      itemCount: 80,
                      itemBuilder:(context,index) {
                        return new Container(
                          height:19,width: 10, color:  Colors.blue[200],
                        );
                      }

                  ),
                  //height: 1000,
                  /*child: new ListView.builder(

                //mainAxisAlignment: MainAxisAlignment.start,
                itemCount: 100,
                itemBuilder:(context,index) {
                  return new Container(
                    height:19,width: 5, child: new Image.asset('images/image.png',fit:BoxFit.fitHeight),
                  );
                }

              ),*/
                ),




          ),
          new Container(
            height:3000,
            width:60,
            child: Center(
              child: new ListView.builder(
                itemCount: 4,
                itemBuilder: (context,index){
                  return new Container(
                    width:60,
                    height: 152,
                    child: new Center(
                      child: new Container(
                        height:12,
                        width:60,
                        color: Colors.blue[200],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          new Align(
              alignment: Alignment.topLeft,
              child: new Container(
                  width:300,
                  height: 2000,
                  child: new ListView.builder(
                      itemCount: 4,
                      itemBuilder: (context, index){
                        if (index==0) return new Card(
                          color: Colors.blue[200],
                          child: new Container(
                            height:152,
                            child: Text('BBS'),
                          )
                        );
                        if (index==1) return new Card(
                            color: Colors.blue[200],
                            child: new Container(
                              height:152,
                              child: Text('树洞'),
                            )
                        );
                        if (index==2) return new Card(
                            color: Colors.blue[200],
                            child: new Container(
                              height:152,
                              child: Text('讲座'),
                            )
                        );
                        if (index==3) return new Card(
                            color: Colors.blue[200],
                            child: new Container(
                              height:152,
                              child: Text('票务'),
                            )
                        );
                      }
                  )
              )

          ),
        ],
        )

    );
  }
}