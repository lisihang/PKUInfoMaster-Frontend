import 'package:flutter/material.dart';
import 'package:flutter/services.dart'show rootBundle;
import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;


/*
Future<List<Post>> fetchPost(http.Client client) async {
  final response = await http.get('http://192.168.191.1:8888/CANTEEN');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return compute(parsePost, response.body);
    /*Post.fromJson(json.decode(response.body));*/
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}*/

Future<List<Post>> fetchPost() async {
  String jsonString = await _loadCanteenAsset();
  return compute(parsePost,jsonString );
}
Future<String> _loadCanteenAsset() async {
  return await rootBundle.loadString('asset/canteen_record.json');
}

List<Post> parsePost(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Post>((json) => Post.fromJson(json)).toList();
}

class Post {
  final int id;
  final String name;
  final int total;
  final int now;
  //bool selected = false;

  Post({this.id, this.name, this.total, this.now});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json['id'] as int,
        name: json['name'] as String,
        total: json['total'] as int,
        now: json['now'] as int,
    );
  }
}

class Canteen_indexPage1 extends StatelessWidget {
  //final Future<Post> post;
  final String pageText;    //定义一个常量，用于保存跳转进来获取到的参数

  Canteen_indexPage1(this.pageText);    //构造函数，获取参数

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text(pageText),),    //将参数当作页面标题
      body: new Center(
        child: FutureBuilder<List<Post>>(
          future: fetchPost(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              //MyTable table = MyTable(snapshot.data);
              return PostsList(posts: snapshot.data);
              //return ShowTable(table);
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

/*class ShowTable extends StatelessWidget{
  final MyTable table;
  ShowTable(this.table);
  Widget build(BuildContext context){

  }
}*/
List getcanteen(){
  return [];
}

class GreenBoard extends StatelessWidget {
  const GreenBoard({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
        color: const Color(0xFF2DBD3A)
    );
  }
}
class PostsList extends StatelessWidget {
  final List<Post> posts;

  PostsList({Key key, this.posts}) : super(key: key);
  DataRow getRow(int index){
    final Post post = posts[index];
    return DataRow.byIndex(

        cells: [
          DataCell(Text('${post.id}',style: new TextStyle(fontWeight: FontWeight.bold),),),
          DataCell(Text(post.name)),
          DataCell(Text('${post.total}')),
          DataCell(Text('${post.now}')),
        ],
        index: index,

        );
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        //appBar: new AppBar(title: new Text(pageText),),
        body: new Center(
            child: new DataTable(
              columns: <DataColumn>[
                DataColumn(
                    label:Text('id',style: new TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)
                ),
                DataColumn(
                    label:Text('食堂',style: new TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)
                ),
                DataColumn(

                    label:Text('总容量',style: new TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)
                ),
                DataColumn(
                    label:Text('当前人数',style: new TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)
                ),
              ],
              rows: <DataRow>[
                getRow(0),
                getRow(1),
                getRow(2),
                getRow(3),
                getRow(4),
                getRow(5),
                getRow(6),
                getRow(7),
                getRow(8),

                /*DataRow(
                    cells: [
                      DataCell(
                          Text("燕南园")
                      ),
                      DataCell(
                          Text("139")
                      )
                    ]
                ),
                DataRow(
                    cells: [
                      DataCell(
                          Text("学一")
                      ),
                      DataCell(
                          Text("88")
                      )
                    ]
                ),
                DataRow(
                    cells: [
                      DataCell(
                          Text("学五")
                      ),
                      DataCell(
                          Text("79")
                      )
                    ]
                ),*/
              ],
            )
        )
    );
    /*return ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return new SizedBox(
              height: 40.0,
              child: new Card(
                color: Colors.white,
                //阴影大小-默认2.0
                elevation: 5.0,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text(
                          posts[index].id.toString() ,
                          style: new TextStyle(
                              height: 1.5,
                              fontSize: 12
                          ),
                        ),
                        new Text(
                          posts[index].name.toString(),
                          style: new TextStyle(
                              height: 1.5,
                              fontSize: 12
                          ),
                        ),
                        new Text(
                          posts[index].total.toString(),
                          style: new TextStyle(
                              height: 1.5,
                              fontSize: 12
                          ),
                        ),
                        new Text(
                          posts[index].now.toString(),
                          style: new TextStyle(
                              height: 1.5,
                              fontSize: 12
                          ),
                        ),
                      ],
                    ),
                    /*new Text(
                        "热度排名: " + posts[index].id.toString() + "\n",
                        style: new TextStyle(
                          fontSize:13.0,
                          fontWeight: FontWeight.bold,
                        )
                    ),// 热度排名*/
                    //链接
                  ],
                ),
              )
          );
        }
    );*/
  }
}
/*class MyTable extends DataTableSource{

  List _canteens=[
    Canteen('燕南',139),
    Canteen('学一',88),
    Canteen('学五',79),
    Canteen('农园',56),
    Canteen('佟园',47),
    Canteen('艺园',40),
    Canteen('勺园',37),
    Canteen('畅春园',36),
    Canteen('万柳',8),
  ];
  int _selectCount=0;//当前选中的行数
  bool _isRowCountApproximate = false;//行数确定
  @override
  DataRow getRow(int index) {
    if(index >= _canteens.length || index <0)
      throw FlutterError('数据取错啦');
    final Canteen canteen = _canteens[index];
    return DataRow.byIndex(
        cells: [
          DataCell(Text(canteen.name)),
          DataCell(Text('${canteen.index}')),
        ],
        selected: canteen.selected,
        index: index,
        onSelectChanged: (isSelected) {
          selectOne(index, isSelected);
        });

    //根据索引获取内容行
  }
  @override//是否行数不确定
  bool get isRowCountApproximate => _isRowCountApproximate;

  @override//有多少行
  int get rowCount => _canteens.length;

  @override//选中的行数
  int get selectedRowCount => _selectCount;

  //选中单个
  void selectOne(int index,bool isSelected){
    Canteen canteen=_canteens[index];
    if (canteen.selected != isSelected) {
      //如果选中就选中数量加一，否则减一
      _selectCount = _selectCount += isSelected ? 1 : -1;
      canteen.selected = isSelected;
      //更新
      notifyListeners();
    }
  }
  //选中全部
  void selectAll(bool checked) {
    for (Canteen _shop in _canteens) {
      _shop.selected = checked;
    }
    _selectCount = checked ? _canteens.length : 0;
    notifyListeners(); //通知监听器去刷新
  }
}*/

class Canteen{
  final int id;
  final String name;
  final int total;
  final int now;
  bool selected = false;
  Canteen({this.id, this.name, this.total, this.now});
}

/*
class Canteen_indexPage2 extends StatelessWidget{
  final String pageText;
  Canteen_indexPage2(this.pageText);
  Widget build(BuildContext context){
    return new Scaffold(
        appBar: new AppBar(title: new Text(pageText),),
        body: new Center(
            child: new DataTable(
              columns: <DataColumn>[
                DataColumn(
                    label:Text('食堂')
                ),
                DataColumn(
                    label:Text('就餐指数')
                )
              ],
              rows: <DataRow>[

                table.getRow(4),
                DataRow(
                    cells: [
                      DataCell(
                          Text("燕南园")
                      ),
                      DataCell(
                          Text("139")
                      )
                    ]
                ),
                DataRow(
                    cells: [
                      DataCell(
                          Text("学一")
                      ),
                      DataCell(
                          Text("88")
                      )
                    ]
                ),
                DataRow(
                    cells: [
                      DataCell(
                          Text("学五")
                      ),
                      DataCell(
                          Text("79")
                      )
                    ]
                ),
              ],
            )
        )
    );
  }
}*/

