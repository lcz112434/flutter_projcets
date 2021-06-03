import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_wanandroid/DarkModeProvider.dart';
import 'package:flutter_wanandroid/Zhihu/CollectPage.dart';
import 'package:flutter_wanandroid/Zhihu/HomePage.dart';
import 'package:flutter_wanandroid/Zhihu/Log.dart';
import 'package:flutter_wanandroid/r.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flustars/flustars.dart';

import 'MyPage.dart';
import 'data/collectbean.dart';

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

class ZhiHuApp extends StatefulWidget {
  const ZhiHuApp({Key key}) : super(key: key);

  @override
  _ZhiHuAppState createState() => _ZhiHuAppState();
}

class _ZhiHuAppState extends State<ZhiHuApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdatas();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(360, 690),
        builder: () => MultiProvider(
              providers: [
                ChangeNotifierProvider.value(value: DarkModeProvider()),
              ],
              child: Consumer<DarkModeProvider>(
                builder: (context, darkModeProvider, _) {
                  return darkModeProvider.darkMode == 2
                      ? MaterialApp(
                          debugShowCheckedModeBanner: false,
                          title: 'Flutter Demo',
                          theme: ThemeData(
                            primarySwatch: Colors.blue,
                          ),
                          darkTheme: ThemeData.dark(),
                          home: ZhihuHomePage(),
                        )
                      : MaterialApp(
                          debugShowCheckedModeBanner: false,
                          title: 'Flutter Demo',
                          theme: darkModeProvider.darkMode == 1
                              ? ThemeData.dark()
                              : ThemeData(
                                  primarySwatch: Colors.blue,
                                ),
                          home: ZhihuHomePage(),
                        );
                },
              ),
            ));
  }

  void getdatas() async {
    var db = await openDatabase('my_db.db');
    await db.execute(
        'CREATE TABLE ZhiHu (id INTEGER, author TEXT, img TEXT, title TEXT, body TEXT,link TEXT)');
  }
}

class ZhihuHomePage extends StatefulWidget {
  const ZhihuHomePage({Key key}) : super(key: key);

  @override
  _ZhihuHomePageState createState() => _ZhihuHomePageState();
}

class _ZhihuHomePageState extends State<ZhihuHomePage> {
  final pages = [new HomePager(), new CollectPage(), new MyPage()];
  int currentIndex;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
    this._pageController =
        PageController(initialPage: this.currentIndex, keepPage: true);
  }

  final List<BottomNavigationBarItem> bottomNavItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "首页",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.wallet_travel),
      label: "收藏",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: "我的",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              currentIndex = index;
              _pageController.jumpToPage(index);
            });
          },
          items: bottomNavItems,
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
        ),
        body: PageView.builder(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          itemBuilder: (context, index) => pages[index],
          itemCount: pages.length,
        ));
  }
}

class WebViewExample extends StatefulWidget {
  WebViewExample(this.collectData, {Key key}) : super(key: key);
  CollectData collectData;

  @override
  WebViewExampleState createState() => WebViewExampleState(collectData);
}

class WebViewExampleState extends State<WebViewExample> {
  WebViewExampleState(this.collectData);

  CollectData collectData;
  bool islike;

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    getlike(collectData.title);
    // print(islike);
  }

  void getlike(String title) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    islike = prefs.getBool(title);
    if (islike == null) {
      islike = false;
    }
    setState(() {});
  }

  void putlike(String title, bool key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(title, key);
  }

  Future<void> InsetDatabase(CollectData data) async {
    var db = await openDatabase('my_db.db');

    int recordId = await db.insert('ZhiHu', {
      'id': '${data.id}',
      'author': '${data.author}',
      'title': '${data.title}',
      'body': '${data.body}',
      'img': '${data.img}',
      'link': '${data.link}'
    });
    print(recordId);
    print(db);
  }

  Future<void> DeleteDatabase(int id) async {
    var db = await openDatabase('my_db.db');
    var count = await db.delete('ZhiHu', where: 'id = ?', whereArgs: ['$id']);
    print(count);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: Scaffold(
          appBar: AppBar(
            actions: [
              FlatButton(
                onPressed: () {
                  if (islike) {
                    islike = false;
                    putlike(collectData.title, false);
                    DeleteDatabase(collectData.id);
                    setState(() {});
                  } else {
                    islike = true;
                    putlike(collectData.title, true);
                    setState(() {});
                    InsetDatabase(collectData);
                  }
                },
                child: islike == false
                    ? Image.asset(R.assetsImagesNoLike, width: 30, height: 30)
                    : Image.asset(R.assetsImagesLike, width: 30, height: 30),
              )
            ],
            title: Container(
              alignment: Alignment.topLeft,
              width: 200,
              child: Text(
                collectData.title,
                style: TextStyle(fontSize: 17),
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_outlined),
              onPressed: () {
                int a=1;
                Navigator.of(context).pop(1);

              },
            ),
          ),
          body: WebView(
            initialUrl: collectData.link, //JS执行模式 是否允许JS执行
            javascriptMode: JavascriptMode.disabled,
          ),
        ));
  }
}
