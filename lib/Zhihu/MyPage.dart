import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/utlis/PaddingUtlis.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';

import 'package:webview_flutter/webview_flutter.dart';

import '../DarkModeProvider.dart';
import '../r.dart';
import 'home.dart';

/// <pre>
///      @author : Lichengze
///     @e-mail : lcz3466601343@163.com
///     @time   : 2021/05/26
///     @desc   :
///     version : 1.0
/// </pre>

class MyPage extends StatefulWidget {
  const MyPage({Key key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with AutomaticKeepAliveClientMixin {
  bool _switchSelected; //维护单选开关状态
  int IsDark;

  SharedPreferences prefs;

  void getSp() async {
    _switchSelected = false;
    prefs = await SharedPreferences.getInstance();
    _switchSelected = prefs.getBool("ISDARK");
    setState(() {});
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [PaddingLeft(30), Text('关于作者')],
        ),
        actions: [
          Row(
            children: [
              Text('夜间模式'),
              Switch(
                value: _switchSelected, //当前状态
                onChanged: (value) {
                  if (value == true) {
                    Provider.of<DarkModeProvider>(context, listen: false)
                        .changeMode(1);
                    prefs.setBool("ISDARK", true);
                  } else {
                    Provider.of<DarkModeProvider>(context, listen: false)
                        .changeMode(2);
                    prefs.setBool("ISDARK", false);
                  }
                  //重新构建页面
                  setState(() {
                    _switchSelected = value;
                  });
                },
              ),
            ],
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                height: 200,
                child: Center(
                    child: ClipOval(
                  child: Image.asset(
                    R.assetsImagesIcon,
                    width: 150,
                    height: 150,
                  ),
                ))),
            PaddingBottom(10),
            Text(
              "李承泽",
              style: TextStyle(fontSize: 20),
            ),
            PaddingBottom(30),
            Text("简介：一个爱好开发的宅男"),
            GoToWeb("LiChengZe_Blog", "https://www.jianshu.com/u/ba458686bdbc",
                "简书：LiChengZe_Blog"),
            GoToWeb("LiChengZe_Blog", "https://blog.csdn.net/li1278086920",
                "CSDN：LiChengZe_Blog"),
            GoToWeb("LiChengZe_Blog", "https://juejin.cn/user/615324842477726",
                "掘金：LiChengZe_Blog"),
            GoToWeb("GitHub", "https://github.com/lcz112434",
                "GitHub:https://github.com/lcz112434"),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('当前版本 V1.0', style: TextStyle(fontSize: 11)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget GoToWeb(String title, String url, String name) {
    return TextButton(
        onPressed: () {
          Get.to(MyWebView(url, title));
        },
        child: Text(name));
  }

  @override
  bool get wantKeepAlive => true;
}

class MyWebView extends StatefulWidget {
  MyWebView(this.url, this.title);

  String url;
  String title;

  @override
  WebViewExampleState createState() => WebViewExampleState(url, title);
}

class WebViewExampleState extends State<MyWebView> {
  WebViewExampleState(this.url, this.title);

  String url;
  String title;

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
        ),
        body: WebView(
          initialUrl: url,
        ));
  }
}
