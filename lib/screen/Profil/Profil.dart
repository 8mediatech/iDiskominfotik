import 'dart:convert';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:diskominfotik_bengkalis/screen/StatisDetail.dart';
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

// ignore: must_be_immutable
class Profil extends StatefulWidget {
  static String tag = '/Profil';
  @override
  ProfilState createState() => ProfilState();
  String name;
  String totalChapter;
  String backgroundImages;
  Profil({Key key, this.title}) : super(key: key);
  final String title;
}
class ProfilState extends State<Profil> {

  String data;
  // ignore: non_constant_identifier_names
  var Posts_Length;
  var permalink;
  String lblValue = "permalink";

  @override
  void initState() {
    super.initState();
    getBerita();
  }
  void getBerita() async {
    http.Response response =
    await http.get(mBaseUrl + "get_statis_index&id=3");
    if (response.statusCode == 200) {
      data = response.body; //store response as string
      setState(() {
        Posts_Length = jsonDecode(data)['datastatis']; //get all the data from json string superheros// just printed length of data
      });
    } else {
      print(response.statusCode);
    }
  }

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
                                            child: Text(lbl_profil, style: boldTextStyle(size: 24, color: Colors.white)),
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
                    if (Posts_Length == null) Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: new Center( child: CircularProgressIndicator() ),
                    ) else ListView.builder(
                      itemCount: Posts_Length == null ? 0 : Posts_Length.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap : () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => StatisDetail(
                                    str: jsonDecode(data)['datastatis'][index]['judul_statis'],
                                    permalink: "Profil",
                                    isi: jsonDecode(data)['datastatis'][index]['content'],
                                  )));
                            },child :  Container(
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
                                        text(jsonDecode(data)['datastatis'][index]['judul_statis'], textColor: appStore.textPrimaryColor),
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