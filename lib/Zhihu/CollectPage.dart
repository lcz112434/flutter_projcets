import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/utlis/PaddingUtlis.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'data/collectbean.dart';
import 'home.dart';

/// <pre>
///      @author : Lichengze
///     @e-mail : lcz3466601343@163.com
///     @time   : 2021/05/26
///     @desc   :
///     version : 1.0
/// </pre>

class CollectPage extends StatefulWidget {
  const CollectPage({Key key}) : super(key: key);

  @override
  _CollectPageState createState() => _CollectPageState();
}

class _CollectPageState extends State<CollectPage> {
  List<Map> mlist;

  @override
  void initState() {
    super.initState();
    getdatas();
  }

  Future<void> DeleteDatabase(int id) async {
    var db = await openDatabase('my_db.db');
    var count = await db.delete('ZhiHu', where: 'id = ?', whereArgs: ['$id']);
    getdatas();
  }

  void putlike(String title, bool key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(title, key);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('收藏'),
        centerTitle: true,
      ),
      body: mlist == null
          ? Text('')
          : ListView.builder(
              itemCount: mlist.length,
              itemBuilder: (BuildContext context, int index) {
                var map = mlist[index];
                var id;
                var author;
                var title;
                var body;
                var link;
                var img;
                map.forEach((key, value) {
                  if (key == 'id') {
                    id = value;
                  }
                  if (key == 'author') {
                    author = value;
                  }
                  if (key == 'title') {
                    title = value;
                  }
                  if (key == 'body') {
                    body = value;
                  }
                  if (key == 'link') {
                    link = value;
                  }
                  if (key == 'img') {
                    img = value;
                  }
                });
                return GestureDetector(
                    onTap: () async {
                      var collectData =
                          new CollectData(id, author, title, body, link, img);

                      var result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return WebViewExample(
                                // 路由参数
                                collectData);
                          },
                        ),
                      );
                      if (result == 1) {
                        getdatas();
                      }
                    },
                    onLongPress: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('提示'),
                              content: Text('是否取消收藏'),
                              actions: [
                                FlatButton(onPressed: () {
                                  DeleteDatabase(int.parse(id.toString()));
                                  putlike(title,false);
                                  Navigator.of(context).pop();
                                }, child: Text('确定')),
                                FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('取消'),
                                )
                              ],
                            );
                          });
                    },
                    child: Container(
                      padding: EdgeInsets.all(6),
                      height: 140,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        child: Row(
                          children: [
                            PaddingLeft(5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                PaddingBottom(5),
                                ClipOval(
                                  child: Image.network(
                                    img.toString(),
                                    height: 80,
                                    width: 80,
                                  ),
                                ),
                                PaddingBottom(10),
                                Text(author.toString()),
                              ],
                            ),
                            PaddingLeft(10),
                            Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width - 130,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    flex: 1,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      body,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ));
              }),
    );
  }

  void getdatas() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'my_db.db');

    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // 创建数据库时创建表
    });
// Get the records
    mlist = await database.rawQuery('SELECT * FROM ZhiHu');
    setState(() {});
    for (var value in mlist) {
      // print(value.toString());
    }
  }
}
