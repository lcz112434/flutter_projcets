import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_wanandroid/r.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'DatailsPage.dart';
import 'HomeData.dart';
import 'ImageWidget.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(360, 690),
        builder: () => MaterialApp(
              debugShowCheckedModeBanner: false,
              title: "WanAndroid项目",
              home: HomePage(),
            ));
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var url = Uri.parse(
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json");

  var name = "";
  HomeData homeData;

  getbody() async {
    var uriResponse = await http.get(Uri.parse(
        'https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json'));

    var body = jsonDecode(uriResponse.body);
    homeData = HomeData.fromJson(body);
    print(homeData.toJson());
    print(homeData.toString());
    print(homeData.pokemon.length);
    name = homeData.pokemon[0].name;
    Fluttertoast.showToast(msg: "${homeData.pokemon[0].name}");
    setState(() {});
  }

  @override
  void initState() {
    getbody();
  }

  List<Widget> getWidgetlist() {
    return homeData.pokemon.map((e) => GridviewBody(e)).toList();
  }

  Widget GridviewBody(Pokemon item) {
    return Card(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          GestureDetector(
            onTap: () {
              Fluttertoast.showToast(msg: "Hello,我是${item.name}");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return DetailsBody(
                      // 路由参数
                      homeData: item,
                    );
                  },
                ),
              );
            },
            child: FadeInImage.assetNetwork(
              placeholder: R.assetsImagesBack,
              image: item.img,
            ),
          ),
          Padding(padding: EdgeInsets.all(3.0)),
          Text(item.name)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child:Container(
            alignment: Alignment.center,
            child: Text('我是Drawer',style: TextStyle(fontSize: 30),),
          )),
      appBar: AppBar(
          title: Text("Poke App"),
          centerTitle: true,
          backgroundColor: Colors.cyan,

          leading: IconButton(
              icon: Icon(Icons.apps),
              onPressed: () {
                Fluttertoast.showToast(msg: "点击了侧边栏按钮");
              })),
      body: homeData == null
          ? Center(
              child: CircularProgressIndicator(),
            ): GridView.count(
              //水平子Widget之间间距
              crossAxisSpacing: 10.0,
              //垂直子Widget之间间距
              mainAxisSpacing: 30.0,
              //GridView内边距
              padding: EdgeInsets.all(10.0),
              //一行的Widget数量
              crossAxisCount: 2,
              //子Widget宽高比例

              //子Widget列表
              children: getWidgetlist(),
            ),
    );
  }
}


