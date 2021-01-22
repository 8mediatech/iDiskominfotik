import 'package:diskominfotik_bengkalis/utils/resource/size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:diskominfotik_bengkalis/utils/resource/colors.dart';
import 'package:diskominfotik_bengkalis/utils/resource/string.dart';
import 'package:diskominfotik_bengkalis/utils/widget/widget.dart';
import '../../main.dart';

class Setting extends StatefulWidget {
  static String tag = '/Setting';
  @override
  SettingState createState() => SettingState();
}

class SettingState extends State<Setting> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    changeStatusColor(db6_colorPrimary);

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              floating: false,
              forceElevated: innerBoxIsScrolled,
              pinned: true,
              titleSpacing: 0,
              backgroundColor: innerBoxIsScrolled ? db6_colorPrimary : db6_colorPrimary,
              actionsIconTheme: IconThemeData(opacity: 0.0),
              title: Container(
                height: 60,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(15, 15, 0, 0),
                  child: Text(lbl_setting, style: boldTextStyle(color: db6_white, size: 24, fontFamily: fontBold)),
                ),

              ),
            )
          ];
        },

        body: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 8),
                      Container(
                        decoration: boxDecoration2(bgColor: appStore.scaffoldBackground, radius: 8, showShadow: true),
                        margin: EdgeInsets.only(bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: GestureDetector(
                                  onTap : () {
                                    Navigator.pushNamed(context, "/Tentang");
                                  },child: T8SettingOptionPattern1(Icons.person, lbl_tentang, lbl_subtentang)),
                            ),
                            Container(
                              child: T8SettingOptionPattern1(Icons.email, lbl_versi, lbl_subversi),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: boxDecoration2(bgColor: appStore.scaffoldBackground, radius: 8, showShadow: true),
                        margin: EdgeInsets.only(bottom: 20),
                        child: Column(
                          children: <Widget>[
                            T8SettingOptionPattern2(Icons.notifications, lbl_notifikasi),
                          ],
                        ),
                      ),
                      Container(
                        decoration: boxDecoration2(bgColor: appStore.scaffoldBackground, radius: 8, showShadow: true),
                        margin: EdgeInsets.only(bottom: 20),
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: GestureDetector(
                                  onTap : () {
                                    Navigator.pushNamed(context, "/Privacy");
                                  },child: T8SettingOptionPattern3(Icons.security, lbl_privacy)),
                            ),
                            Container(
                            child: GestureDetector(
                            onTap : () {
                Navigator.pushNamed(context, "/Kontak");
                },child: T8SettingOptionPattern3(Icons.chat_bubble, lbl_contact_us)),
    )],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),

    );
  }
}
// ignore: must_be_immutable, non_constant_identifier_names
Widget T8SettingOptionPattern1(var settingIcon, var heading, var info) {
  return Padding(
    padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(shape: BoxShape.circle, color: db7_dark_yellow),
              width: 45,
              height: 45,
              padding: EdgeInsets.all(4),
              child: Icon(settingIcon, color: db6_white),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                text(heading, textColor: appStore.textPrimaryColor),
                text(info, textColor: appStore.textSecondaryColor, fontSize: textSizeSMedium),
              ],
            ),
          ],
        ),
        Icon(Icons.keyboard_arrow_right, color: appStore.iconColor)
      ],
    ),
  );
}

// ignore: non_constant_identifier_names
Widget T8SettingOptionPattern2(var icon, var heading) {
  bool isSwitched1 = false;

  return Padding(
    padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(shape: BoxShape.circle, color: db7_dark_yellow),
              width: 45,
              height: 45,
              padding: EdgeInsets.all(4),
              child: Icon(icon, color: db6_white),
            ),
            SizedBox(width: 10),
            text(heading, textColor: appStore.textPrimaryColor),
          ],
        ),
        Switch(
          value: isSwitched1,
          onChanged: (value) {
            isSwitched1 = value;
          },
          activeTrackColor: t8_colorPrimary,
          activeColor: t8_view_color,
        )
      ],
    ),
  );
}

// ignore: non_constant_identifier_names
Widget T8SettingOptionPattern3(var icon, var heading) {
  return Padding(
    padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(shape: BoxShape.circle, color: db7_dark_yellow),
              width: 45,
              height: 45,
              padding: EdgeInsets.all(4),
              child: Icon(icon, color: db6_white),
            ),
            SizedBox(width: 10),
            text(heading,textColor: appStore.textPrimaryColor),
          ],
        ),
        Icon(
          Icons.keyboard_arrow_right,
          color: appStore.iconColor,
        )
      ],
    ),
  );
}
// ignore: must_be_immutable
