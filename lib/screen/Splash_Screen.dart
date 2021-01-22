import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:diskominfotik_bengkalis/utils/constant.dart';
import 'package:diskominfotik_bengkalis/utils/resource/colors.dart';
import 'package:diskominfotik_bengkalis/utils/resource/size.dart';
import 'package:diskominfotik_bengkalis/utils/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:diskominfotik_bengkalis/utils/resource/string.dart';
import '../main.dart';
import 'HomePage.dart';

class OPSplashScreen extends StatefulWidget {
  static String tag = '/OPSplashScreen';

  @override
  _OPSplashScreenState createState() => _OPSplashScreenState();
}

class _OPSplashScreenState extends State<OPSplashScreen> with SingleTickerProviderStateMixin {

  startTime() async {
    var _duration = Duration(seconds: 2);
    return Timer(_duration, navigationPage);
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  void navigationPage() {
    finish(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }

  Widget build(BuildContext context) {
    changeStatusColor(Colors.transparent);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: height,
          alignment: Alignment.center,
          color: appStore.scaffoldBackground,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CachedNetworkImage(placeholder: placeholderWidgetFn(), imageUrl: logo, width: width / 3.5, height: width / 3.5),
              text(lbl_app, textColor: appStore.textPrimaryColor, fontFamily: fontIntro, fontSize: 22.0),
              Padding(
                padding: EdgeInsets.only(left: 30, right: 30, top: 0, bottom: 16),
                child: text("Dinas Komunikasi Informatika dan Statistik Kabupaten Bengkalis", textColor: db6_textColorSecondary, fontFamily: fontMedium, fontSize: textSizeMedium, maxLine: 2, isCentered: true),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
