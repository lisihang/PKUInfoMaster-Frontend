import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {

  final String pageText;    //定义一个常量，用于保存跳转进来获取到的参数
  var titles = ["   版本号","3.0   ",
                "   最后更新日期", "2019/1/2   ",
                "   开发者", "软件工程实习第三小组   ",
                "   指导人", "孙艳春老师及各位助教   ",
                "   团队成员", "李思航 吴睿海 张俊楠   ",
                "   联系我们", "1600012910@pku.edu.cn   "];
  AboutPage(this.pageText);    //构造函数，获取参数
  renderRow(i){
    if(i==0){
      return new Container(
          color: Colors.white,
          height:200,
          child: new Center(
              child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:<Widget>[
                    new Container(
                        width: 100,
                        height:100,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            color:Colors.transparent,
                            image: new DecorationImage(
                                image: new ExactAssetImage('images/splash.jpg'),
                                fit:BoxFit.cover
                            ),
                            border: new Border.all(
                                color:Colors.black45,
                                width:2.0
                            )
                        )
                    ),
                    new Text("PKU InfoMaster")
                  ]
              )
          )
      );
    }
    i--;
    if(i.isOdd){
      return new Divider();
    }
    i=i~/2;
    return new  Text(
        titles[i],
        style: new TextStyle(
          fontSize: 15.0
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text(pageText),),    //将参数当作页面标题
      body: new  ListView(
        children: <Widget>[
          new Container(
              color: Colors.white30,
              height:160,
              child: new Center(
                  child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:<Widget>[
                        new Container(
                            width: 80,
                            height:80,
                            decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                color:Colors.transparent,
                                image: new DecorationImage(
                                    image: new ExactAssetImage('images/splash.jpg'),
                                    fit:BoxFit.cover
                                ),
                                border: new Border.all(
                                    color:Colors.black45,
                                    width:2.0
                                )
                            )
                        ),
                        new Text("\nPKU InfoMaster",
                          style: new TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ]
                  )
              )
          ),
          new Padding(
              padding: new EdgeInsets.all(8.0),
              child:new Card(
                color: Colors.white,
                //阴影大小-默认2.0
                elevation: 2.0,
                child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Text(
                            titles[0],
                            style: new TextStyle(
                                height: 1.5,
                                fontSize: 12
                            ),
                          ),
                          new Text(
                            titles[1],
                            style: new TextStyle(
                                height: 1.5,
                                fontSize: 12
                            ),
                          ),
                        ],
                      ),
                      new Divider(),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Text(
                            titles[2],
                            style: new TextStyle(
                                height: 1.5,
                                fontSize: 12
                            ),
                          ),
                          new Text(
                            titles[3],
                            style: new TextStyle(
                                height: 1.5,
                                fontSize: 12
                            ),
                          ),
                        ],
                      ),
                      new Divider(),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Text(
                            titles[4],
                            style: new TextStyle(
                                height: 1.5,
                                fontSize: 12
                            ),
                          ),
                          new Text(
                            titles[5],
                            style: new TextStyle(
                                height: 1.5,
                                fontSize: 12
                            ),
                          ),
                        ],
                      ),
                      new Divider(),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Text(
                            titles[6],
                            style: new TextStyle(
                                height: 1.5,
                                fontSize: 12
                            ),
                          ),
                          new Text(
                            titles[7],
                            style: new TextStyle(
                                height: 1.5,
                                fontSize: 12
                            ),
                          ),
                        ],
                      ),
                      new Divider(),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Text(
                            titles[8],
                            style: new TextStyle(
                                height: 1.5,
                                fontSize: 12
                            ),
                          ),
                          new Text(
                            titles[9],
                            style: new TextStyle(
                                height: 1.5,
                                fontSize: 12
                            ),
                          ),
                        ],
                      ),
                      new Divider(),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Text(
                            titles[10],
                            style: new TextStyle(
                                height: 1.5,
                                fontSize: 12
                            ),
                          ),
                          new Text(
                            titles[11],
                            style: new TextStyle(
                                height: 1.5,
                                fontSize: 12
                            ),
                          ),
                        ],
                      )
                    ]
                )
            ),
          ),
          new Center(
            child:new Text("\n欢迎提出修改建议！",style: new TextStyle(fontSize: 12),)
          )
        ],
      )

    );
  }
}
