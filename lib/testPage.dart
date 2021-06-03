import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// <pre>
///      @author : Lichengze
///     @e-mail : lcz3466601343@163.com
///     @time   : 2021/05/28
///     @desc   :
///     version : 1.0
/// </pre>

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'package:flutterpoke/HomeData.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'Zhihu/data/LikeData.dart';

void main() {
  runApp(GetMaterialApp(home: MyApp(), debugShowCheckedModeBanner: false));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(360, 690),
        builder: () => MaterialApp(
              debugShowCheckedModeBanner: false,
              title: "Poke项目",
              home: MyHomePage(),
            ));
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  LikeData homeData;

  void getHttp() async {
    var uriResponse = await http.get(
        Uri.parse('https://www.wanandroid.com/project/list/1/json?cid=294'));
    var body = jsonDecode(uriResponse.body);
    print(body);
    homeData = LikeData.fromJson(body);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getHttp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Poke App"),
        ),
        body: homeData == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: homeData?.data?.datas?.length,
                itemBuilder: (BuildContext context, int index) {
                  return getWidgetList(homeData.data.datas[index]);
                },
              )
//          : GridView.count(
//              //水平子Widget之间间距
//              crossAxisSpacing: 10.0,
//              //垂直子Widget之间间距
//              mainAxisSpacing: 30.0,
//              //GridView内边距
//              padding: EdgeInsets.all(10.0),
//              //一行的Widget数量
//              crossAxisCount: 2,
//              //子Widget宽高比例
//              //子Widget列表
//              children: getWidgetList(),
//            ),
        );
  }

//
  Widget getWidgetList(DataElement data) {
    return GridviewBody(data);
  }

  Widget GridviewBody(DataElement item) {
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(10),
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 70.0,
                width: 50.0,
                child: Image.network(item.envelopePic, fit: BoxFit.cover),
              ),
            ),
            Padding(padding: EdgeInsets.all(5)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 20,
                  width: MediaQuery.of(context).size.width - 100,
                  child: Text(item.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width - 100,
                  child: Text(
                    item.desc,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
