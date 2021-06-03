import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/Zhihu/data/collectbean.dart';
import 'package:flutter_wanandroid/utlis/PaddingUtlis.dart';
import 'package:get/get.dart';

import '../Api.dart';
import '../data/TopData.dart';
import '../home.dart';

/// <pre>
///      @author : Lichengze
///     @e-mail : lcz3466601343@163.com
///     @time   : 2021/05/18
///     @desc   :
///     version : 1.0
/// </pre>

class TopPage extends StatefulWidget {
  TopPage({Key key}) : super(key: key);

  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> with AutomaticKeepAliveClientMixin {
  _TopPageState();

  @override
  void initState() {
    http();
    print("执行网络请求");
    super.initState();
  }

  http() async {
    String TopApi = Api.BaseApi + "project/list/3/json?cid=294";
    var TopRsponse = await Dio().get(TopApi);
    var TopjsonDecode = jsonDecode(TopRsponse.toString());

    _topData = TopData.fromJson(TopjsonDecode);
    setState(() {});
  }

  TopData _topData;
  TextStyle _textStyle = TextStyle(fontSize: 13);

  @override
  Widget build(BuildContext context) {
    super.build(context);

    // ignore: missing_return
    return RefreshIndicator(
        child: _topData == null
            ? Center(child:CircularProgressIndicator())
            : ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  var datas = _topData.data.datas[index];
                  var rng = new Random();
                  return GestureDetector(
                    onTap: () {
                      var collectData = CollectData(datas.id, datas.author, datas.title, datas.desc, datas.link,datas.envelopePic);
                      Get.to(WebViewExample(collectData));
                    },
                    child: Container(
                      height: 95,
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: <Widget>[
                          PaddingLeft(20),
                          Text(
                            '$index',
                            style:
                                TextStyle(fontSize: 15, color: randomColor()),
                          ),
                          PaddingRight(20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 220,
                                height: 45,
                                child: Text(
                                  datas.title,
                                  style: TextStyle(fontSize: 16),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              PaddingBottom(10),
                              Text(
                                '${rng.nextInt(1000)}万热度',
                                style: _textStyle,
                              ),
                            ],
                          ),
                          Expanded(
                            child: Text(''),
                          ),
                          Image.network(
                            datas.envelopePic,
                            width: 60,
                            height: 150,
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) => Divider(
                      height: 0,
                      color: Colors.white24,
                    ),
                itemCount: _topData.data.datas.length),
        onRefresh: _onRefresh);
  }

  /**
   * 下拉刷新方法,为list重新赋值
   */
  Future<Null> _onRefresh() async {
    http();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  int random(int min, int max) {
    final _random = new Random();
    return min + _random.nextInt(max - min + 1);
  }

  Color randomColor() {
    return Color.fromARGB(
        random(150, 255), random(0, 255), random(0, 255), random(0, 255));
  }
}
