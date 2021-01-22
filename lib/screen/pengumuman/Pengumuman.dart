import 'dart:convert';

import 'package:diskominfotik_bengkalis/utils/constant.dart';
import 'package:diskominfotik_bengkalis/utils/resource/size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:indonesia/indonesia.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:diskominfotik_bengkalis/utils/resource/colors.dart';
import 'package:diskominfotik_bengkalis/utils/resource/images.dart';
import 'package:diskominfotik_bengkalis/utils/resource/string.dart';
import 'package:diskominfotik_bengkalis/utils/widget/widget.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';
import 'PengumumanDetail.dart';

class Pengumuman extends StatefulWidget {
  static String tag = '/Pengumuman';
  @override
  PengumumanState createState() => PengumumanState();
}

class PengumumanState extends State<Pengumuman> {

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
    await http.get(mBaseUrl + "get_recent_pengumuman");

    if (response.statusCode == 200) {
      data = response.body; //store response as string

      setState(() {
        Posts_Length = jsonDecode(
            data)['pengumuman'];
      });
    } else {
      print(response.statusCode);
    }
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
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: Text(lbl_pengumuman, style: boldTextStyle(color: db6_white, size: 24, fontFamily: fontBold)),
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
                Posts_Length == null ? Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: new Center( child: CircularProgressIndicator() ),
                ) : ListView.builder(
                  padding: EdgeInsets.only(top: 15),
                  physics: NeverScrollableScrollPhysics(),
                  //scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: Posts_Length == null ? 0 : Posts_Length.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap : () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => PengumumanDetail(
                            id_pengumuman: jsonDecode(data)['pengumuman'][index]['id_pengumuman'].toString(),
                            str: jsonDecode(data)['pengumuman'][index]['judul_pengumuman'],
                            permalink: "Pengumuman",
                            isi: jsonDecode(data)['pengumuman'][index]['isi'],
                            tgl: tanggal(DateTime.parse(jsonDecode(data)['pengumuman'][index]['tanggal'])),
                            urlku: jsonDecode(data)['pengumuman'][index]['permalink'],
                            file: jsonDecode(data)['pengumuman'][index]['permalink'],
                          )));
                    }, child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 18, bottom: 18),
                          padding: EdgeInsets.only(left: 20.0, right: 20),
                          child: Row(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  text(jsonDecode(data)['pengumuman'][index]['tgl_mulai2'], fontSize: textSizeSMedium),
                                  text(jsonDecode(data)['pengumuman'][index]['tgl_mulai']?.toString(),
                                      fontSize: textSizeLargeMedium, textColor: appStore.textSecondaryColor),
                                ],
                              ),
                              Container(
                                decoration: boxDecoration2(radius: 8, showShadow: true),
                                margin: EdgeInsets.only(left: 10, right: 10),
                                width: width / 7.2,
                                height: width / 7.2,
                                child: SvgPicture.asset(db4_pengumuman),
                                padding: EdgeInsets.all(width / 30),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    RichText(
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      // TextOverflow.clip // TextOverflow.fade
                                      text: TextSpan(
                                        text: jsonDecode(data)['pengumuman'][index]['judul_pengumuman'],
                                        style: TextStyle(fontWeight: FontWeight.normal,fontFamily: fontBold,color: appStore.textPrimaryColor,fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Divider(height: 0.5, color: t5ViewColor)
                      ],
                    ));
                  },
                  //itemCount: mFavouriteList.length,
                )
              ],
            ),
          ),
        ),
      ),

    );
  }
}
