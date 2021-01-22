

import 'package:diskominfotik_bengkalis/utils/resource/size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:diskominfotik_bengkalis/utils/resource/colors.dart';
import 'package:diskominfotik_bengkalis/models/ModelUtils.dart';
import 'package:diskominfotik_bengkalis/utils/dummy.dart';
import 'package:diskominfotik_bengkalis/utils/resource/string.dart';
import 'package:diskominfotik_bengkalis/utils/widget/widget.dart';

import '../../main.dart';

class Kontak extends StatefulWidget {
  static String tag = '/Kontak';
  @override
  KontakState createState() => KontakState();
}

class KontakState extends State<Kontak> {
  List<KontakModel> mListings;
  String data;
  // ignore: non_constant_identifier_names
  var Posts_Length;

  @override
  void initState() {
    super.initState();
    mListings = getListData();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
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
                  child: Text(lbl_kontak, style: boldTextStyle(color: db6_white, size: 24, fontFamily: fontBold)),
                ),

              ),
            )
          ];
        },

        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(color: db4_LayoutBackgroundWhite),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(boxShadow: defaultBoxShadow(),color: white),
                  child: Padding(
                    padding: EdgeInsets.only(left: 0, right: 0,bottom: 0,top: 0),
                    child: ListView.builder(
                        padding: EdgeInsets.only(top: 10),
                        scrollDirection: Axis.vertical,
                        itemCount: mListings.length,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 5, bottom: 15),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      decoration: boxDecoration2(radius: 8, showShadow: true),
                                      margin: EdgeInsets.only(left: 16, right: 16),
                                      width: width / 7.2,
                                      height: width / 7.2,
                                      child: SvgPicture.asset(mListings[index].icon),
                                      padding: EdgeInsets.all(width / 30),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              text(mListings[index].name, textColor: appStore.textPrimaryColor, fontSize: textSizeMedium, fontFamily: fontSemibold)
                                            ],
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          ),
                                          text(mListings[index].day, fontSize: textSizeSmall)
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Divider(height: 0.5, color: t5ViewColor)
                            ],
                          );
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
}
