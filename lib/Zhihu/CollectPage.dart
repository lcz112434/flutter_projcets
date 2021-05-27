import 'package:flutter/material.dart';

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

class _CollectPageState extends State<CollectPage>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    print("_CollectPageState");
    return Center(
      child: Text('收藏页面 开发中-'),
    );
  }
}
