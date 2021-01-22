import 'dart:convert';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:diskominfotik_bengkalis/utils/constant.dart';
import 'package:diskominfotik_bengkalis/utils/resource/size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:diskominfotik_bengkalis/utils/resource/colors.dart';
import 'package:diskominfotik_bengkalis/utils/widget/widget.dart';
import 'package:diskominfotik_bengkalis/utils/resource/string.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';
import 'package:diskominfotik_bengkalis/screen/StatisDetail.dart';
// ignore: must_be_immutable
class Sekretariat extends StatefulWidget {
  static String tag = '/Sekretariat';
  @override
  SekretariatState createState() => SekretariatState();
  String name;
  String totalChapter;
  String backgroundImages;
}

class SekretariatState extends State<Sekretariat> {

  String data;
  // ignore: non_constant_identifier_names
  var Posts_Length;

  @override
  void initState() {
    super.initState();
    getBerita();
  }
  void getBerita() async {
    http.Response response =
    await http.get(mBaseUrl + "get_statis_index&id=4");
    if (response.statusCode == 200) {
      data = response.body; //store response as string
      setState(() {
        Posts_Length = jsonDecode(data)['datastatis'];
      });
    } else {
      print(response.statusCode);
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: 180,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: widget.backgroundImages == null
                              ? NetworkImage(backdrop)
                              : NetworkImage(widget.backgroundImages),
                          fit: BoxFit.cover),
                    ),
                    child: ClipRRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                        child: Container(
                          padding: EdgeInsets.only(top: 22, left: 5),
                          width: size.width,
                          color: Colors.grey.withOpacity(0.1),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(top: 90),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Stack(
                                        children: <Widget>[
                                          CachedNetworkImage(
                                            imageUrl: logo,
                                            imageBuilder: (context, imageProvider) => Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                            //placeholder: (context, url) => placeholder,
                                            //errorWidget: (context, url, error) => errorWidget,
                                          )
                                        ],
                                      ),
                                      SizedBox(width: 5),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(top: 0),
                                            child: Text(lbl_sekre, style: boldTextStyle(size: 24, color: Colors.white)),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 1),
                                            child: Text(lbl_instansi, style: secondaryTextStyle(size: 16, color: Colors.white)),
                                          ),
                                        ],
                                      )
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 35, left: 15, right: 15),
                width: size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Posts_Length == null ? Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: new Center( child: CircularProgressIndicator() ),
                    ) :ListView.builder(
                      itemCount: Posts_Length == null ? 0 : Posts_Length.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap : () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => StatisDetail(
                                    str: jsonDecode(data)['datastatis'][index]['judul_statis'],
                                    permalink: lbl_sekre,
                                    isi: jsonDecode(data)['datastatis'][index]['content'],
                                  )));
                            },child : Container(
                          decoration: boxDecoration2(bgColor: appStore.scaffoldBackground, radius: 8, showShadow: true),
                          margin: EdgeInsets.only(bottom: 20),
                          child: Padding(
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
                                      child: Icon(Icons.star, color: db6_white),
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        RichText(
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          // TextOverflow.clip // TextOverflow.fade
                                          text: TextSpan(
                                            text: jsonDecode(data)['datastatis'][index]['judul_statis'],
                                            style: TextStyle(fontWeight: FontWeight.normal,fontFamily: fontMedium,color: appStore.textPrimaryColor,fontSize: 18),
                                          ),
                                        ),
                                        text(jsonDecode(data)['datastatis'][index]['judul_statis'], textColor: appStore.textSecondaryColor, fontSize: textSizeSMedium),
                                      ],
                                    ),
                                  ],
                                ),
                                Icon(Icons.keyboard_arrow_right, color: appStore.iconColor)
                              ],
                            ),
                          ),
                        )
                        );
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
// ignore: must_be_immutable
// ignore: must_be_immutable