import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/Poke/main.dart';
import 'package:flutter_wanandroid/Zhihu/Log.dart';
import 'package:flutter_wanandroid/Zhihu/home/TopPage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:flutter_wanandroid/Zhihu/Api.dart';
import 'package:flutter_wanandroid/utlis/PaddingUtlis.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'LikeData.dart';
import 'RecommendData.dart';
import 'TopData.dart';
import 'home/LikePage.dart';
import 'home/RecommendData.dart';

/// <pre>
///      @author : Lichengze
///     @e-mail : lcz3466601343@163.com
///     @time   : 2021/05/17
///     @desc   :
///     version : 1.0
/// </pre>
///

class HomePager extends StatefulWidget {
  const HomePager({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePager>
    with SingleTickerProviderStateMixin {
  TextStyle _textStyle = TextStyle(color: Colors.white70);
  final List<Tab> _tabs = <Tab>[
    new Tab(text: '关注'),
    new Tab(text: '推荐'),
    new Tab(text: '热榜'),
  ];
  var _tabController;
  LikeData _likeData;
  RecommendData _recommendData;
  TopData _topData;

  @override
  void initState() {
    http();
    _tabController = TabController(vsync: this, length: _tabs.length);
    super.initState();
  }

  http() async {
    String LikeApi = Api.BaseApi + "project/list/1/json?cid=294";
    String RecommendApi = Api.BaseApi + "project/list/2/json?cid=294";
    String TopApi = Api.BaseApi + "project/list/3/json?cid=294";

    var LikeRsponse = await Dio().get(LikeApi);
    var LikejsonDecode = jsonDecode(LikeRsponse.toString());
    var RecommendRsponse = await Dio().get(RecommendApi);
    var RecommendDecode = jsonDecode(RecommendRsponse.toString());
    var TopRsponse = await Dio().get(TopApi);
    var TopjsonDecode = jsonDecode(TopRsponse.toString());

    _likeData = LikeData.fromJson(LikejsonDecode);
    _recommendData = RecommendData.fromJson(RecommendDecode);
    _topData = TopData.fromJson(TopjsonDecode);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.app_blocking_sharp),
        backgroundColor: Colors.cyan,
        onPressed: () {
          Get.offAll(Myapp());
        },
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          padding: EdgeInsets.all(15.0),
          width: MediaQuery.of(context).size.width,
          height: 80,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.zoom_out_outlined,
                  color: Colors.white70,
                ),
                PaddingRight(10),
                Text(
                  '坚果R1摄像头损坏',
                  style: _textStyle,
                ),
                PaddingRight(30),
                Text(
                  '|',
                  style: TextStyle(fontSize: 16.0, color: Colors.white70),
                ),
                PaddingRight(15),
                GestureDetector(
                  onTap: () {
                    Fluttertoast.showToast(msg: "提问");
                  },
                  child: Row(
                    children: [
                      Icon(Icons.auto_fix_off,
                          color: Colors.white70, size: 15.0),
                      PaddingRight(5),
                      Text('提问', style: _textStyle),
                    ],
                  ),
                )
              ],
            )),
          ),
        ),
        bottom: TabBar(
          labelColor: Colors.white70,
          // 选中的Widget颜色
          indicatorColor: Colors.indigoAccent,
          // 选中的指示器颜色
          labelStyle: new TextStyle(fontSize: 15.0),
          // 必须设置，设置 color 没用的，因为 labelColor 已经设置了
          unselectedLabelColor: Colors.white,
          unselectedLabelStyle: new TextStyle(fontSize: 15.0),
          // 设置 color 没用的，因为unselectedLabelColor已经设置了
          controller: _tabController,
          // tabbar 必须设置 controller 否则报错
          indicatorSize: TabBarIndicatorSize.tab,
          // 有 tab 和 label 两种
          tabs: _tabs,
        ),
      ),
      body: _likeData == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : TabBarView(controller: _tabController, children: [
              Likepage(_likeData),
              RecommendPage(_recommendData),
              TopPage(_topData)
            ]),
    );
  }
}
