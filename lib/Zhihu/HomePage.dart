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
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sp_util/sp_util.dart';

import '../DarkModeProvider.dart';
import 'SearchPage.dart';
import 'data/LikeData.dart';

import 'data/RecommendData.dart';
import 'data/TopData.dart';
import 'home/LikePage.dart';
import 'home/RecommendPage.dart';

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
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  final List<Tab> _tabs = <Tab>[
    new Tab(text: '关注'),
    new Tab(text: '推荐'),
    new Tab(text: '热榜'),
  ];
  var _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: _tabs.length);
    super.initState();
  }


  int IsDark;

  SharedPreferences prefs;

  void getSp() async {
    prefs = await SharedPreferences.getInstance();
    IsDark = prefs.getInt("DARKMODE");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.app_blocking_sharp),
        // backgroundColor: Colors.cyan,
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
                GestureDetector(
                    onTap: () {
                      getSp();
                      Get.to(SecarhPage(IsDark));
                      Log.d("message");
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.zoom_out_outlined,
                          color: Colors.amber,
                        ),
                        PaddingRight(10),
                        Text(
                          '坚果R1摄像头损坏',
                          // style: _textStyle,
                        ),
                        PaddingRight(30),
                        Text(
                          '|',
                          style: TextStyle(
                            fontSize: 16.0,
                            // color: Colors.white70
                          ),
                        ),
                        PaddingRight(15),
                        Row(
                          children: [
                            Icon(Icons.auto_fix_off,
                                // color: Colors.white70,
                                size: 15.0),
                            PaddingRight(5),
                            Text(
                              '提问',
                              // style: _textStyle
                            ),
                          ],
                        ),
                      ],
                    ))
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
      body:  TabBarView(controller: _tabController, children: [
              Likepage(),
              RecommendPage(),
              TopPage()
            ]),
    );
  }
}
