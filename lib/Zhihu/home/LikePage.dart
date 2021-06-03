import 'dart:convert';
import 'dart:core';
import 'dart:core';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/Zhihu/data/collectbean.dart';
import 'package:flutter_wanandroid/utlis/PaddingUtlis.dart';
import 'package:get/get.dart';
import '../Api.dart';
import '../data/LikeData.dart';
import '../home.dart';

/// <pre>
///      @author : Lichengze
///     @e-mail : lcz3466601343@163.com
///     @time   : 2021/05/18
///     @desc   :
///     version : 1.0
/// </pre>

class Likepage extends StatefulWidget {
  Likepage({Key key}) : super(key: key);

  @override
  _LikepageState createState() => _LikepageState();
}

class _LikepageState extends State<Likepage>
    with AutomaticKeepAliveClientMixin {
  ScrollController _scrollController = ScrollController(); //listview的控制器
  _LikepageState();

  List<DataElement> datalist = List();

  @override
  void initState() {
    super.initState();
    http();
    print("执行网络请求");
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('滑动到了最底部');
        _getMore();
      }
    });
  }

  bool isLoading = false;

  Future _getMore() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      setState(() {
        _page++;
        http();
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  int _page = 1;

  http() async {
    String LikeApi = Api.BaseApi + "project/list/$_page/json?cid=294";

    var LikeRsponse = await Dio().get(LikeApi);
    var LikejsonDecode = jsonDecode(LikeRsponse.toString());

    _likeData = LikeData.fromJson(LikejsonDecode);
    datalist.addAll(_likeData.data.datas);
    print('${datalist.length}');
    setState(() {});
  }

  LikeData _likeData;
  TextStyle _textStyle = TextStyle(fontSize: 13);

  Widget wordCard(DataElement data) {
    Widget markWight;
    if (data.envelopePic.isEmpty) {
      markWight = Container(
          height: 70,
          width: MediaQuery
              .of(context)
              .size
              .width,
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
        width: MediaQuery
            .of(context)
            .size
            .width,
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
        displacement: 40.0,
        child: _likeData == null
            ? Center(child: CircularProgressIndicator())
            : ListView.separated(
            controller: _scrollController,
            itemBuilder: (context, index) {
              var data = datalist[index];
              var rng = new Random();

              return
                GestureDetector(
                  onTap: () {
                    var collectData = CollectData(data.id, data.author, data.title, data.desc, data.link,data.envelopePic);
                    Get.to(WebViewExample(collectData));
                  },
                  child: Container(
                    height: 190,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    padding: EdgeInsets.all(10),
                    // color: Colors.black38,
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
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              data.title,
                              style: TextStyle(
                                fontSize: 17,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )),
                        wordCard(data),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${rng.nextInt(50)} 个赞同',
                            ),
                            PaddingRight(3),
                            Text(
                              '${rng.nextInt(50)} 个评论',
                            ),
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
            separatorBuilder: (BuildContext context, int index) =>
                Divider(
                  height: 0,
                  color: Colors.white24,
                ),
            itemCount: datalist.length ),
        onRefresh: _onRefresh);
  }

  Widget _getMoreWidget() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '加载中...',
              style: TextStyle(fontSize: 16.0),
            ),
            CircularProgressIndicator(
              strokeWidth: 1.0,
            )
          ],
        ),
      ),
    );
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
