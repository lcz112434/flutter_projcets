import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/Zhihu/data/RecommendData.dart';
import 'package:flutter_wanandroid/Zhihu/data/collectbean.dart';
import 'package:flutter_wanandroid/utlis/PaddingUtlis.dart';
import 'package:get/get.dart';

import '../Api.dart';
import '../home.dart';

/// <pre>
///      @author : Lichengze
///     @e-mail : lcz3466601343@163.com
///     @time   : 2021/05/18
///     @desc   :
///     version : 1.0
/// </pre>

class RecommendPage extends StatefulWidget {
  RecommendPage({Key key}) : super(key: key);

  @override
  _RecommendPageState createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage>
    with AutomaticKeepAliveClientMixin {
  _RecommendPageState();

  @override
  void initState() {
    http();
    print("执行网络请求");
    super.initState();
  }

  http() async {
    String RecommendApi = Api.BaseApi + "project/list/2/json?cid=294";
    var RecommendRsponse = await Dio().get(RecommendApi);
    var RecommendDecode = jsonDecode(RecommendRsponse.toString());

    _recommendData = RecommendData.fromJson(RecommendDecode);

    setState(() {});
  }

  RecommendData _recommendData;
  TextStyle _textStyle = TextStyle(fontSize: 13);

  Widget wordCard(DataElement data) {
    Widget markWight;
    if (data.envelopePic.isEmpty) {
      markWight = Container(
          height: 70,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                data.desc,
                style: _textStyle,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ));
    } else {
      markWight = Container(
        height: 70,
        width: MediaQuery.of(context).size.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                data.desc,
                style: _textStyle,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            PaddingRight(10),
            Image.network(data.envelopePic, height: 60, width: 30),
            PaddingRight(10),
          ],
        ),
      );
    }
    return markWight;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
        child: _recommendData == null
            ? Center(child: CircularProgressIndicator())
            : ListView.separated(
                itemBuilder: (context, index) {
                  var data = _recommendData.data.datas[index];
                  var rng = new Random();
                  return GestureDetector(
                    onTap: () {
                      var collectData = CollectData(data.id, data.author, data.title, data.desc, data.link,data.envelopePic);
                      Get.to(WebViewExample(collectData));
                    },
                    child: Container(
                      height: 190,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            data.author + "赞同了回答·${rng.nextInt(24)}小时前",
                            style: _textStyle,
                          ),
                          PaddingBottom(5),
                          Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                data.title,
                                style: TextStyle(fontSize: 17),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              )),
                          wordCard(data),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${rng.nextInt(50)} 个赞同',
                                style: _textStyle,
                              ),
                              PaddingRight(3),
                              Text('${rng.nextInt(50)} 个评论', style: _textStyle),
                              Expanded(
                                child: Text(''), // 中间用Expanded控件
                              ),
                              Text(
                                '···',
                                style: TextStyle(fontSize: 20),
                              ),
                              PaddingRight(20),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.only(bottom: 0),
                physics: BouncingScrollPhysics(),
                separatorBuilder: (BuildContext context, int index) => Divider(
                      height: 0,
                      color: Colors.white24,
                    ),
                itemCount: _recommendData.data.datas.length),
        onRefresh: _onRefresh);
  }

  /**
   * 下拉刷新方法,为list重新赋值
   */
  Future<Null> _onRefresh() async {
    http();
  }

  @override
  bool get wantKeepAlive => true;
}
