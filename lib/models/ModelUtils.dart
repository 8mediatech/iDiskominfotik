import 'dart:ui';
import 'package:flutter/material.dart';
class SliderBanner {
  var image = "";
  var balance = "";
  var accountNo = "";
}
class Category {
  var name = "";
  Color color;
  var permalink;
  var icon = "";
}
class KontakModel {
  var name;
  var day;
  var icon;
}

class Message {
  final String title;
  final String body;

  const Message({
    @required this.title,
    @required this.body,
  });
}