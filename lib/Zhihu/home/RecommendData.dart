import 'package:flutter/material.dart';

import '../RecommendData.dart';

/// <pre>
///      @author : Lichengze
///     @e-mail : lcz3466601343@163.com
///     @time   : 2021/05/18
///     @desc   :
///     version : 1.0
/// </pre>


class RecommendPage extends StatefulWidget {
    RecommendPage(this._recommendData,{Key key}) : super(key: key);

  RecommendData _recommendData;
  @override
  _RecommendPageState createState() => _RecommendPageState(_recommendData);
}

class _RecommendPageState extends State<RecommendPage>
    with AutomaticKeepAliveClientMixin {
  _RecommendPageState(this._recommendData);
  RecommendData _recommendData;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
