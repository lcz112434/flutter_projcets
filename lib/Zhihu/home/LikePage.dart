import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/utlis/PaddingUtlis.dart';

import '../LikeData.dart';

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

  Widget wordCard(DataElement data){
    Widget markWight;
    if(data.envelopePic.isEmpty){
      markWight=  Container(
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
          )
      );
    }else{
      markWight= Container(
        height:70,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            
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
          return Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(10),
            color: ThemeData.dark().tabBarTheme.labelColor,
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

              ],
            ),
          );
        },
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.only(bottom: 20),
        physics: BouncingScrollPhysics(),
        separatorBuilder: (BuildContext context, int index) => Divider(
              height: 10,
              color: Colors.black26,
            ),
        itemCount: _likeData.data.datas.length);
  }

  @override
  bool get wantKeepAlive => true;
}
