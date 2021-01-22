import 'package:diskominfotik_bengkalis/utils/resource/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:diskominfotik_bengkalis/utils/resource/colors.dart';
import 'package:diskominfotik_bengkalis/utils/widget/widget.dart';


import '../main.dart';

// ignore: must_be_immutable
class StatisDetail extends StatelessWidget {
  // Initial variable String
  String str = "";
  String permalink = "";
  String isi = "";

// Get Key Data
  StatisDetail({Key key, this.str,this.permalink,this.isi}): super(key: key);
  @override
  // Widget build(BuildContext context) {
  //   var width = MediaQuery.of(context).size.width;
  //   changeStatusColor(db6_colorPrimary);
  //   return Scaffold(
  //     body: NestedScrollView(
  //       headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
  //         return <Widget>[
  //           SliverAppBar(
  //             floating: false,
  //             forceElevated: innerBoxIsScrolled,
  //             pinned: true,
  //             titleSpacing: 0,
  //             backgroundColor: innerBoxIsScrolled ? db6_colorPrimary : db6_colorPrimary,
  //             actionsIconTheme: IconThemeData(opacity: 0.0),
  //             title: Container(
  //               height: 60,
  //               child: Padding(
  //                 padding: EdgeInsets.fromLTRB(15, 15, 0, 0),
  //                 child: Text(permalink, style: boldTextStyle(color: db6_white, size: 24, fontFamily: fontBold)),
  //               ),
  //
  //             ),
  //           )
  //         ];
  //       },
  //
  //       body: Column(
  //         children: <Widget>[
  //           Expanded(
  //             child: SingleChildScrollView(
  //               child: Container(
  //                 margin: EdgeInsets.all(20),
  //                 child: Container(
  //                   decoration: boxDecoration2(bgColor: appStore.scaffoldBackground, radius: 8, showShadow: true),
  //                   margin: EdgeInsets.only(bottom: 20),
  //                   padding: EdgeInsets.only(left: 15, right: 15,top: 10),
  //                   child: Column(
  //                     children: <Widget>[
  //                       SizedBox(height: 8),
  //                       Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         mainAxisSize: MainAxisSize.max,
  //                         children: <Widget>[
  //                           Text(str, style: boldTextStyle(size: 20,
  //                               color: appStore.textPrimaryColor))],
  //                       ),
  //                       SizedBox(height: 16),
  //                       Container(
  //                         padding: EdgeInsets.only(left: 0, right: 0),
  //                         child: Html(
  //                           data: isi,
  //                           style: {
  //                             "html": Style(
  //                               fontSize: FontSize(16.0),
  //                               textAlign:TextAlign.left,
  //                               margin: EdgeInsets.all(0),
  //                               border: Border.all(width: 1,style: BorderStyle.solid,color: t1_border),
  //                               backgroundColor: Colors.white,
  //
  //                             ),
  //                           },
  //                         ),
  //                       ),
  //                       SizedBox(height: 16),
  //                       Container(
  //                       padding: EdgeInsets.only(left: 0.0, right: 0.0),
  //                       alignment: Alignment.center,
  //                       child: MaterialButton(
  //                         elevation: 5.0,
  //                         height: 50.0,
  //                         minWidth: width,
  //                         color: t8_red,
  //                         textColor: Colors.white,
  //                         child: Icon(Icons.share),
  //                         onPressed: () {
  //                           Share.share(permalink);
  //                         },
  //                       ),
  //                     ),
  //                       SizedBox(height: 16),
  //
  //                     ],
  //                   ),
  //                 ),
  //
  //               ),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //
  //   );
  // }

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
                  child: Text(permalink, style: boldTextStyle(color: db6_white, size: 24, fontFamily: fontBold)),
                ),

              ),
            )
          ];
        },
        body: Observer(
          builder: (_) => Container(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[16.height,
                    Padding(
                      padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15),
                      child: RichText(
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        // TextOverflow.clip // TextOverflow.fade
                        text: TextSpan(
                          text: str,
                          style: TextStyle(fontWeight: FontWeight.normal,fontFamily: fontBold,
                              color: appStore.textPrimaryColor,fontSize: textSizeLarge),
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 7.0, right: 7.0, bottom: 10,top: 0),
                        child: Html(
                          data: isi,
                          style: {
                            "html": Style(
                              fontSize: FontSize(16.0),
                              textAlign:TextAlign.left,
                              margin: EdgeInsets.all(0),
                            ),
                          },
                        )
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Divider(height: 16),
                    ),



                  ],
                ),
              ),
            ),
          ),
        ),
      ),

    );
  }
}