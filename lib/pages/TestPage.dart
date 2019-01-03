import 'package:flutter/material.dart';
import 'package:flutter_app4/pages/SlideView.dart';
import 'package:flutter_app4/pages/LecturePage.dart';


// 资讯列表页面
class TestPage extends StatelessWidget {

  // 轮播图的数据
  var slideData = [];
  TestPage() {
    // 这里做数据初始化，加入一些测试数据
    for (int i = 0; i < 3; i++) {
      Map map = new Map();
      // 轮播图的资讯标题
      map['title'] = 'Python 之父透露退位隐情，与核心开发团队产生隔阂';
      // 轮播图的详情URL
      map['detailUrl'] = 'https://www.oschina.net/news/98455/guido-van-rossum-resigns';
      // 轮播图的图片URL
      map['imgUrl'] = 'https://static.oschina.net/uploads/img/201807/30113144_1SRR.png';
      slideData.add(map);
    }
  }
  @override
  Widget build(BuildContext context) {

              return new Container(
                height: 180.0,
                child: new SlideView(slideData),
              );


  }

  // 渲染列表item
  /*Widget renderRow(i) {
    // i为0时渲染轮播图
    if (i == 0) {
      return new Container(
        height: 180.0,
        child: new SlideView(slideData),
      );
    }
    // 用InkWell包裹row，让row可以点击
    return new InkWell(
      child: new LecturePage("讲座"),
      onTap: () {
      },
    );
  }*/
}