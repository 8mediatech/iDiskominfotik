import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:diskominfotik_bengkalis/utils/constant.dart';
import 'package:diskominfotik_bengkalis/utils/resource/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:indonesia/indonesia.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:diskominfotik_bengkalis/utils/resource/colors.dart';
import 'package:diskominfotik_bengkalis/utils/widget/widget.dart';
import 'package:diskominfotik_bengkalis/utils/resource/images.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:share/share.dart';

import '../../main.dart';
import 'BeritaDetail.dart';

// ignore: must_be_immutable
class BeritaDetailPush extends StatefulWidget {
  static String tag = '/BeritaDetailPush';
  // ignore: non_constant_identifier_names
  String id_berita = "";


  // ignore: non_constant_identifier_names
  BeritaDetailPush({this.id_berita});

  @override
  BeritaDetailPushState createState() => BeritaDetailPushState();
}

class BeritaDetailPushState extends State<BeritaDetailPush> with TickerProviderStateMixin<BeritaDetailPush> {
  String data;
  // ignore: non_constant_identifier_names
  var Beritalength;
  // ignore: non_constant_identifier_names
  var BeritaPopulerlength;
  @override
  void initState() {
    super.initState();
    getBerita(widget.id_berita);
  }

  void getBerita(nilai) async {
    http.Response response =
    await http.get(mBaseUrl + "get_related_posts&id=$nilai");
    if (response.statusCode == 200) {
      data = response.body; //store response as string
      setState(() {
        Beritalength = jsonDecode(data)['posts'];
        BeritaPopulerlength = jsonDecode(data)['popular'];
      });
    } else {
      print(response.statusCode);
    }
  }
  String link= 'https://medium.com/@suryadevsingh24032000';
  String subject = 'follow me';
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
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
                  child: Text("Judul", style: boldTextStyle(color: db6_white, size: 24, fontFamily: fontBold)),
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
                  children: <Widget>[
                    16.height,
                    Padding(
                      padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 5),
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: 2),
                          Icon(Icons.date_range, size: 14, color: db7_dark_yellow),
                          SizedBox(width: 2),
                          Text("Tanggal", style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14)),
                          SizedBox(width: 2),
                          SizedBox(width: 2),
                          Text("-", style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14)),
                          SizedBox(width: 2),
                          Text("waktu", style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14)),
                          SizedBox(width: 2),
                          Text("WIB", style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15),
                      child: RichText(
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        // TextOverflow.clip // TextOverflow.fade
                        text: TextSpan(
                          text: "Judul Berita",
                          style: TextStyle(fontWeight: FontWeight.normal,fontFamily: fontBold,
                              color: appStore.textPrimaryColor,fontSize: textSizeLarge),
                        ),
                      ),

                    ),
                    Container(
                      margin: EdgeInsets.only(top: 0, bottom: 12, left: 16, right: 16),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SvgPicture.asset(t_user, height: 48, width: 48,
                                  color: db7_dark_yellow),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      text("Reporter", textColor: appStore.textPrimaryColor, fontSize: textSizeMedium, fontFamily: fontMedium),
                                      text("Reporter", fontSize: textSizeMedium)
                                    ],
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    Row(
                      children: <Widget>[
                        SizedBox(width: 16),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: CachedNetworkImage(
                            placeholder: placeholderWidgetFn(),
                            imageUrl: "Gambar",
                            width: (width - 32) * 1,
                            height: height * 0.3,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 16),
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 7.0, right: 7.0, bottom: 10),
                        child: Html(
                          data: "isi",
                          style: {
                            "html": Style(
                              fontSize: FontSize(16.0),
                              textAlign:TextAlign.left,
                              margin: EdgeInsets.all(0),
                            ),
                          },
                        )
                    ),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     color: t8_red,
                    //     borderRadius: BorderRadius.only(bottomRight: Radius.circular(16.0), topRight: Radius.circular(16.0)),
                    //   ),
                    //   padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                    //   child: Text(widget.kategori, style: primaryTextStyle(color: white, size: 12)),
                    // ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Divider(height: 16),
                    ),
                    SizedBox(height: 5),
                    Container(
                      padding: EdgeInsets.only(left: 15.0, right: 15.0),
                      alignment: Alignment.center,
                      child: MaterialButton(
                        elevation: 5.0,
                        height: 50.0,
                        minWidth: width,
                        color: t8_red,
                        textColor: Colors.white,
                        child: Icon(Icons.share),
                        onPressed: () {
                          Share.share("permalink");
                        },
                      ),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Divider(height: 16),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 12, bottom: 12, left: 16, right: 16),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SvgPicture.asset(t_user, height: 48, width: 48,
                                    color: db7_dark_yellow),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      text("Affandy", textColor: appStore.textPrimaryColor, fontSize: textSizeMedium, fontFamily: fontMedium),
                                      text("Editor", fontSize: textSizeMedium)
                                    ],
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 12, bottom: 12, left: 16, right: 16),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SvgPicture.asset(t_user, height: 48, width: 48,
                                    color: db7_dark_yellow),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      text("Delvi Adri", textColor: appStore.textPrimaryColor, fontSize: textSizeMedium, fontFamily: fontMedium),
                                      text("Fotografer", fontSize: textSizeMedium)
                                    ],
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15),
                      child: text("Berita Lainnya", textColor: appStore.textPrimaryColor, fontFamily: fontBold, fontSize: textSizeNormal),
                    ),
                    Beritalength== null ? Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: new Center( child: CircularProgressIndicator() ),
                    ) : ListView.builder(
                        padding: EdgeInsets.only(top: 0),
                        itemCount: Beritalength == null ? 0 : Beritalength.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap : () {
                                Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => BeritaDetail(
                                      id_berita: jsonDecode(data)['posts'][index]['id_berita'].toString(),
                                      judul_berita: jsonDecode(data)['posts'][index]['judul_berita'],
                                      isi: jsonDecode(data)['posts'][index]['isi'],
                                      tanggal: tanggal(DateTime.parse(jsonDecode(data)['posts'][index]['tanggal'])),
                                      waktu: jsonDecode(data)['posts'][index]['waktu'],
                                      url_gambar: jsonDecode(data)['posts'][index]['url_gambar'],
                                      gambar: jsonDecode(data)['posts'][index]['gambar'],
                                      permalink: jsonDecode(data)['posts'][index]['permalink'],
                                      kategori: jsonDecode(data)['posts'][index]['title'],
                                      editor: jsonDecode(data)['posts'][index]['editor'],
                                      reporter: jsonDecode(data)['posts'][index]['reporter'],
                                      fotografer: jsonDecode(data)['posts'][index]['fotografer'],
                                      title: "Berita",
                                    )));
                              },child : Padding(
                            padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                            child: Container(
                              decoration: BoxDecoration(color: appStore.scaffoldBackground,borderRadius: BorderRadius.circular(10), boxShadow: defaultBoxShadow()),
                              child: Card(
                                semanticContainer: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                color: appStore.scaffoldBackground,
                                child: Row(
                                  children: <Widget>[
                                    CachedNetworkImage(placeholder: placeholderWidgetFn(), imageUrl: jsonDecode(data)['posts'][index]['gambar'],
                                        width: width / 3.5, height: width / 4, fit: BoxFit.fill),
                                    Container(
                                      width: width - (width / 3.5) - 35,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: index % 2 == 0 ? t8_red : t8_colorPrimary,
                                                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(16.0), topRight: Radius.circular(16.0)),
                                                ),
                                                padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                                                child: Text(index % 2 == 0 ? jsonDecode(data)['posts'][index]['title'] : jsonDecode(data)['posts'][index]['title'], style: primaryTextStyle(color: white, size: 12)),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 2),
                                          Padding(
                                            padding: EdgeInsets.only(left: 7.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(jsonDecode(data)['posts'][index]['judul_berita'],
                                                    style: primaryTextStyle(color: appStore.textPrimaryColor, size: 16,fontFamily: fontBold)),
                                                SizedBox(height: 4),
                                                Row(
                                                  children: <Widget>[
                                                    Icon(Icons.date_range, size: 14, color: db7_dark_yellow),
                                                    SizedBox(width: 2),
                                                    Text(tanggal(DateTime.parse(jsonDecode(data)['posts'][index]['tanggal'])), style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12)),
                                                  ],
                                                ),
                                                SizedBox(height: 4),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                elevation: 0,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                margin: EdgeInsets.all(0),
                              ),
                            ),
                          ));
                        }),
                    SizedBox(height: 15),
                    Padding(
                      padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15),
                      child: text("Berita Terpopuler", textColor: appStore.textPrimaryColor, fontFamily: fontBold, fontSize: textSizeNormal),
                    ),
                    Beritalength== null ? Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: new Center( child: CircularProgressIndicator() ),
                    ) : ListView.builder(
                        padding: EdgeInsets.only(top: 0),
                        itemCount: BeritaPopulerlength == null ? 0 : BeritaPopulerlength.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap : () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => BeritaDetail(
                                      id_berita: jsonDecode(data)['popular'][index]['id_berita'].toString(),
                                      judul_berita: jsonDecode(data)['popular'][index]['judul_berita'],
                                      isi: jsonDecode(data)['popular'][index]['isi'],
                                      tanggal: tanggal(DateTime.parse(jsonDecode(data)['popular'][index]['tanggal'])),
                                      waktu: jsonDecode(data)['popular'][index]['waktu'],
                                      url_gambar: jsonDecode(data)['popular'][index]['url_gambar'],
                                      gambar: jsonDecode(data)['popular'][index]['gambar'],
                                      permalink: jsonDecode(data)['popular'][index]['permalink'],
                                      kategori: jsonDecode(data)['popular'][index]['title'],
                                      editor: jsonDecode(data)['popular'][index]['editor'],
                                      reporter: jsonDecode(data)['popular'][index]['reporter'],
                                      fotografer: jsonDecode(data)['popular'][index]['fotografer'],
                                      title: "Berita",
                                    )));
                              },child : Padding(
                            padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                            child: Container(
                              decoration: BoxDecoration(color: appStore.scaffoldBackground,borderRadius: BorderRadius.circular(10),
                                  boxShadow: defaultBoxShadow()),
                              child: Card(
                                semanticContainer: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                color: appStore.scaffoldBackground,
                                child: Row(
                                  children: <Widget>[
                                    CachedNetworkImage(placeholder: placeholderWidgetFn(), imageUrl: jsonDecode(data)['popular'][index]['gambar'],
                                        width: width / 3.5, height: width / 4, fit: BoxFit.fill),
                                    Container(
                                      width: width - (width / 3.5) - 35,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: index % 2 == 0 ? t8_red : t8_colorPrimary,
                                                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(16.0), topRight: Radius.circular(16.0)),
                                                ),
                                                padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                                                child: Text(index % 2 == 0 ? jsonDecode(data)['popular'][index]['title'] : jsonDecode(data)['popular'][index]['title'], style: primaryTextStyle(color: white, size: 12)),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 2),
                                          Padding(
                                            padding: EdgeInsets.only(left: 7.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(jsonDecode(data)['popular'][index]['judul_berita'],
                                                    style: primaryTextStyle(color: appStore.textPrimaryColor, size: 16,fontFamily: fontBold)),
                                                SizedBox(height: 4),
                                                Row(
                                                  children: <Widget>[
                                                    Icon(Icons.date_range, size: 14, color: db7_dark_yellow),
                                                    SizedBox(width: 2),
                                                    Text(tanggal(DateTime.parse(jsonDecode(data)['popular'][index]['tanggal'])),
                                                        style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12)),
                                                  ],
                                                ),
                                                SizedBox(height: 4),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                elevation: 0,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                margin: EdgeInsets.all(0),
                              ),
                            ),
                          ));
                        }),
                    SizedBox(height: 15),
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