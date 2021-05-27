import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// <pre>
///      @author : Lichengze
///     @e-mail : lcz3466601343@163.com
///     @time   : 2021/05/25
///     @desc   :
///     version : 1.0
/// </pre>

class SerchWeb extends StatefulWidget {
  SerchWeb(this.title, {Key key}) : super(key: key);

  String title;

  @override
  _SerchWebState createState() => _SerchWebState(title);
}

class _SerchWebState extends State<SerchWeb> {
  _SerchWebState(this.title);

  String title;

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    print(title);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_outlined),
            onPressed: () {
              Navigator.of(context).pop();
            }
          ),
          title: Text(title),
          centerTitle: true,
        ),
        body: WebView(
          initialUrl:
          "https://cn.bing.com/search?q=$title",
        ),
      ),
    );
  }
}
