import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/utlis/PaddingUtlis.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../WebView.dart';
import '../LikeData.dart';
import '../home.dart';

/// <pre>
///      @author : Lichengze
///     @e-mail : lcz3466601343@163.com
///     @time   : 2021/05/18
///     @desc   :
///     version : 1.0
/// </pre>

class Likepage extends StatefulWidget {
  Likepage(this._likeData, {Key key}) : super(key: key);

  LikeData _likeData;

  @override
  _LikepageState createState() => _LikepageState(_likeData);
}

class _LikepageState extends State<Likepage>
    with AutomaticKeepAliveClientMixin {
  _LikepageState(this._likeData);

  LikeData _likeData;
  TextStyle _textStyle = TextStyle(color: Colors.grey, fontSize: 13);

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
    return ListView.separated(
        itemBuilder: (context, index) {
          var data = _likeData.data.datas[index];
          var rng = new Random();
          return GestureDetector(
            onTap:(){Get.to(WebViewExample(data.link,data.title));},
            child: Container(
              height: 190,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              color: Colors.black38,
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
                        style: TextStyle(fontSize: 17, color: Colors.white70),
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
                      Text('···',style: TextStyle(color: Colors.grey, fontSize: 20),),
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
        itemCount: _likeData.data.datas.length);
  }

  @override
  bool get wantKeepAlive => true;
}
