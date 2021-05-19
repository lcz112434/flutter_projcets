import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_wanandroid/Zhihu/HomePage.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

/// <pre>
///     @author : Lichengze
///     @e-mail : lcz3466601343@163.com
///     @time   : 2021/05/17
///     @desc   :
///     version : 1.0
/// </pre>

void main() {
  runApp(GetMaterialApp(home:ZhiHuApp(),debugShowCheckedModeBanner:false));
}

class ZhiHuApp extends StatelessWidget {
  const ZhiHuApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(360, 690),
        builder: () => MaterialApp(
              title: "仿知乎项目",
              debugShowCheckedModeBanner: false,
              theme: ThemeData.dark(),
              home: HomePager(),
            ));
  }
}
