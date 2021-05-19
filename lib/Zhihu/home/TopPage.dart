import 'package:flutter/material.dart';

import '../TopData.dart';

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

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
