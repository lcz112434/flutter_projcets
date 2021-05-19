import 'package:flutter/material.dart';

/// <pre>
///      @author : Lichengze
///     @e-mail : lcz3466601343@163.com
///     @time   : 2021/05/17
///     @desc   :
///     version : 1.0
/// </pre>
///

Padding PaddingAll(double padding) {
  return new Padding(
    padding: EdgeInsets.all(padding),
  );
}

Padding PaddingLeft(double padding) {
  return new Padding(
    padding: EdgeInsets.only(left: padding),
  );
}

Padding PaddingRight(double padding) {
  return new Padding(
    padding: EdgeInsets.only(right: padding),
  );
}

Padding PaddingTop(double padding) {
  return new Padding(
    padding: EdgeInsets.only(top: padding),
  );
}

Padding PaddingBottom(double padding) {
  return new Padding(
    padding: EdgeInsets.only(bottom: padding),
  );
}
