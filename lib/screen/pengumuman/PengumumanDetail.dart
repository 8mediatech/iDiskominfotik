import 'dart:convert';

import 'package:diskominfotik_bengkalis/utils/constant.dart';
import 'package:diskominfotik_bengkalis/utils/resource/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:link_text/link_text.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:diskominfotik_bengkalis/utils/resource/colors.dart';
import 'package:diskominfotik_bengkalis/utils/widget/widget.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';
// ignore: must_be_immutable
class PengumumanDetail extends StatefulWidget {
  static String tag = '/PengumumanDetail';

  // Initial variable String
  // ignore: non_constant_identifier_names
  String id_pengumuman = "";
  String str = "";
  // ignore: non_constant_identifier_names
  String permalink = "";
  String isi= "";
  // ignore: non_constant_identifier_names
  String tgl = "";
  String urlku = "";
  String file = "";

  // ignore: non_constant_identifier_names
  PengumumanDetail({this.id_pengumuman,this.str,this.permalink,this.isi,this.tgl,
    this.urlku,this.file});

  @override
  PengumumanDetailState createState() => PengumumanDetailState();
}
class PengumumanDetailState extends State<PengumumanDetail> with TickerProviderStateMixin<PengumumanDetail> {
  // Initial variable String
  String str = "";
  String permalink = "";
  String isi = "";
  String tgl = "";
  String urlku = "";
  String file = "";

// Get Key Data
  String data;
  // ignore: non_constant_identifier_names
  var Semuafotolength;

  @override
  void initState() {
    super.initState();
    getFoto(widget.id_pengumuman);
  }
  void getFoto(nilai) async {
    http.Response response =
    await http.get(mBaseUrl + "get_related_pengumuman&id=76");

    if (response.statusCode == 200) {
      data = response.body; //store response as string

      setState(() {
        Semuafotolength = jsonDecode(data)['lampiran'];
      });
    } else {
      print(response.statusCode);
    }
  }
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
                  child: Text(widget.permalink, style: boldTextStyle(color: db6_white, size: 24, fontFamily: fontBold)),
                ),

              ),
            )
          ];
        },
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                16.height,
                Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15),
                  child: RichText(
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    // TextOverflow.clip // TextOverflow.fade
                    text: TextSpan(
                      text: widget.str,
                      style: TextStyle(fontWeight: FontWeight.normal,fontFamily: fontBold,
                          color: appStore.textPrimaryColor,fontSize: textSizeLarge),
                    ),
                  ),

                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.date_range, size: 14, color: db7_dark_yellow),
                      SizedBox(width: 2),
                      Text(widget.tgl, style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14)),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 7.0, right: 7.0, bottom: 10),
                    child: Html(
                      data: widget.isi,
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
                Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 0),
                  child: text("Lampiran", textColor: appStore.textPrimaryColor, fontFamily: fontBold, fontSize: textSizeNormal),
                ),
                StreamBuilder<Object>(
                    stream: null,
                    builder: (context, snapshot) {
                      return ListView.builder(
                        padding: EdgeInsets.only(top: 0),
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: Semuafotolength == null ? 0 : Semuafotolength.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                                onTap: (){
                                  launchURL(jsonDecode(data)['lampiran'][index]['gambar']);
                                },child: LinkText(text: jsonDecode(data)['lampiran'][index]['gambar'], textAlign: TextAlign.center),
                            ),
                          );
                        },
                        //itemCount: mFavouriteList.length,
                      );
                    }
                ),
                SizedBox(height: 16),
                Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Divider(height: 16),
                ),
                SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}