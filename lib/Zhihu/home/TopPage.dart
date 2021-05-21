import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/utlis/PaddingUtlis.dart';
import 'package:get/get.dart';

import '../TopData.dart';
import '../home.dart';

/// <pre>
///      @author : Lichengze
///     @e-mail : lcz3466601343@163.com
///     @time   : 2021/05/18
///     @desc   :
///     version : 1.0
/// </pre>

class TopPage extends StatefulWidget {
  TopPage(this._topData, {Key key}) : super(key: key);

  TopData _topData;

  @override
  _TopPageState createState() => _TopPageState(_topData);
}

class _TopPageState extends State<TopPage> with AutomaticKeepAliveClientMixin {
  _TopPageState(this._topData);

  TopData _topData;
  TextStyle _textStyle = TextStyle(color: Colors.grey, fontSize: 13);

  @override
  Widget build(BuildContext context) {
    super.build(context);

    // ignore: missing_return
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          var datas = _topData.data.datas[index];
          var rng=new Random();
          return GestureDetector(
            onTap: () {Get.to(WebViewExample(datas.link,datas.title));},
            child: Container(
              color: Colors.black38,
              height: 95,
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              child: Row(

                children: <Widget>[
                  PaddingLeft(20),
                  Text(
                    '$index',
                    style: TextStyle(fontSize: 15, color: randomColor()),
                  ),
                  PaddingRight(20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width:220,
                        height:45,
                        child: Text(
                          datas.title,
                          style: TextStyle(fontSize: 16, color: Colors.white70),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      PaddingBottom(10),
                      Text('${rng.nextInt(1000)}万热度',style: _textStyle,),
                    ],
                  ),
                  Expanded(child: Text(''),),
                  Image.network(datas.envelopePic,width: 60,height:150,),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => Divider(
              height: 0,
              color: Colors.white24,
            ),
        itemCount: _topData.data.datas.length);
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
