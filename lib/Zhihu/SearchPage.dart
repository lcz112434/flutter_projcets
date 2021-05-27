import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/utlis/PaddingUtlis.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SearchWebview.dart';

/// <pre>
///      @author : Lichengze
///     @e-mail : lcz3466601343@163.com
///     @time   : 2021/05/25
///     @desc   :
///     version : 1.0
/// </pre>

class SecarhPage extends StatefulWidget {
  SecarhPage(this.isDark, {Key key}) : super(key: key);

  int isDark;

  @override
  _SecarhPageState createState() => _SecarhPageState();
}

class _SecarhPageState extends State<SecarhPage> {
  TextStyle _textStyle = TextStyle(fontSize: 15);

  List<String> mlist = new List();

  int isDark;

  void SetList(mlist) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList("SecarhList", mlist);
  }

  void GetList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var mlist = prefs.getStringList("SecarhList");
    isDark = prefs.getInt("DARKMODE");
    if(mlist==null){
      List<String> mlist = new List();
      mlist.add("百度");
      prefs.setStringList("SecarhList", mlist);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    GetList();
  }

  @override
  Widget build(BuildContext context) {
    GetList();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "搜索页面",
      theme: isDark==1?ThemeData.dark():ThemeData.light(),
      home: Scaffold(
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_outlined,
                      color: Colors.red,
                      size: 20,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  PaddingRight(10),
                  Expanded(
                      child: TextField(
                    onSubmitted: (value) {
                      Get.to(SerchWeb(value));
                      mlist.add(value);
                      SetList(mlist);
                    },
                    // autofocus: true,
                    showCursor: false,
                    decoration: InputDecoration(
                        hintText: "搜索知乎内容",
                        hintStyle: _textStyle,
                        border: InputBorder.none),
                  ))
                ],
              ),
            ),
          ),
        ),
        body: SearchBody(),
      ),
    );
  }
}

class SearchBody extends StatefulWidget {
  SearchBody({Key key}) : super(key: key);

  @override
  _SearchBodyState createState() => _SearchBodyState();
}

class _SearchBodyState extends State<SearchBody> {
  List<String> mlist = [];

  void GetList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    mlist = prefs.getStringList("SecarhList");
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    GetList();
  }

  @override
  Widget build(BuildContext context) {
    GetList();
    return Container(
      padding: EdgeInsets.all(15),
      child: mlist == null
          ? Text('搜索历史')
          : Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '知乎热搜',
                  style: TextStyle(fontSize: 17),
                ),
                buildWrap(),
                PaddingBottom(10),
                Text(
                  '搜索历史',
                  style: TextStyle(fontSize: 17),
                ),
                PaddingBottom(5),
                Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return Container(
                              padding: EdgeInsets.all(10),
                              width: 50,
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(SerchWeb(mlist[index]));
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      size: 17,
                                    ),
                                    PaddingRight(10),
                                    Text(mlist[index]),
                                    Expanded(child: Text('')),
                                    GestureDetector(
                                        child: Text('x',
                                            style: TextStyle(fontSize: 15)),
                                        onTap: () {
                                          mlist.remove(mlist[index]);
                                          SetList(mlist);
                                          setState(() {});
                                        })
                                  ],
                                ),
                              ));
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(
                              height: 0,
                              color: Colors.blue,
                            ),
                        itemCount: mlist.length))
              ],
            ),
    );
  }

  Wrap buildWrap() {
    return Wrap(
      spacing: 12.0, // 主轴(水平)方向间距
      runSpacing: 4.0, // 纵轴（垂直）方向间距
      children: [
        GestureDetector(
            onTap: () {
              addlist("GitHub");
              Get.to(SerchWeb("GitHub"));
            },
            child: Chip(
              label: new Text('GitHub'),
            )),
        GestureDetector(
            onTap: () {
              addlist("Flutter");
              Get.to(SerchWeb("Flutter"));
            },
            child: Chip(
              label: new Text('Flutter'),
            )),
        GestureDetector(
            onTap: () {
              addlist("华为开发者大会");
              Get.to(SerchWeb("华为开发者大会"));
            },
            child: Chip(
              label: new Text('华为开发者大会'),
            )),
        GestureDetector(
            onTap: () {
              addlist("小米");
              Get.to(SerchWeb("小米"));
            },
            child: Chip(
              label: new Text('小米'),
            )),
        GestureDetector(
            onTap: () {
              addlist("掘金");
              Get.to(SerchWeb("掘金"));
            },
            child: Chip(
              label: new Text('掘金'),
            )),
        GestureDetector(
            onTap: () {
              addlist("简书");
              Get.to(SerchWeb("简书"));
            },
            child: Chip(
              label: new Text('简书'),
            )),
        GestureDetector(
            onTap: () {
              addlist("CSDN");
              Get.to(SerchWeb("CSDN"));
            },
            child: Chip(
              label: new Text('CSDN'),
            )),
      ],
    );
  }

  void addlist(String name) {
    mlist.add(name);
    SetList(mlist);
    setState(() {});
  }

  void SetList(mlist) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList("SecarhList", mlist);
  }
}
