import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_wanandroid/Zhihu/HomePage.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// <pre>
///     @author : Lichengze
///     @e-mail : lcz3466601343@163.com
///     @time   : 2021/05/17
///     @desc   :
///     version : 1.0
/// </pre>

void main() {
  runApp(GetMaterialApp(home: ZhiHuApp(), debugShowCheckedModeBanner: false));
}

class ZhiHuApp extends StatelessWidget {
  const ZhiHuApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(360, 690),
        builder: () => MaterialApp(
              title: "仿知乎项目",
              debugShowCheckedModeBanner: false,
              theme: ThemeData.dark(),
              home: HomePager(),
            ));
  }
}

class WebViewExample extends StatefulWidget {
  WebViewExample(this.url, this.title, {Key key}) : super(key: key);
  String url;
  String title;

  @override
  WebViewExampleState createState() => WebViewExampleState(url, title);
}

class WebViewExampleState extends State<WebViewExample> {
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
    print(url);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_outlined),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: WebView(
          initialUrl: url, //JS执行模式 是否允许JS执行
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
