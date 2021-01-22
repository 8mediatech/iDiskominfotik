import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:diskominfotik_bengkalis/utils/constant.dart';
import 'package:diskominfotik_bengkalis/utils/resource/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_signin_button/button_builder.dart';
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

// ignore: must_be_immutable
class GaleriDetail extends StatefulWidget {
  static String tag = '/VideoDetail';

  // Initial variable String
  // ignore: non_constant_identifier_names
  String id_album = "";
  // ignore: non_constant_identifier_names
  String nama_album = "";
  String keterangan= "";
  // ignore: non_constant_identifier_names
  String tanggal_album = "";
  String penulis = "";
  String gambar = "";
  String permalink= "";
  String title = "";
  String foto = "";

  // ignore: non_constant_identifier_names
  GaleriDetail({this.id_album,this.nama_album,this.keterangan,this.tanggal_album,
    this.penulis,this.gambar,this.permalink,this.title,this.foto});

  @override
  GaleriDetailState createState() => GaleriDetailState();
}

class GaleriDetailState extends State<GaleriDetail> with TickerProviderStateMixin<GaleriDetail> {
  String data;
  // ignore: non_constant_identifier_names
  var Galerifotolength;
  // ignore: non_constant_identifier_names
  var Semuafotolength;

  @override
  void initState() {
    super.initState();
    getFoto(widget.id_album);
    getBerita(widget.id_album);
  }
  void getBerita(nilai) async {
    http.Response response =
    await http.get(mBaseUrl + "get_related_galeri&id=$nilai");
    if (response.statusCode == 200) {
      data = response.body; //store response as string
      setState(() {
        Galerifotolength = jsonDecode(data)['galerifoto'];
      });
    } else {
      print(response.statusCode);
    }
  }
  void getFoto(nilai) async {
    http.Response response =
    await http.get(mBaseUrl + "get_related_galeri&id=$nilai");

    if (response.statusCode == 200) {
      data = response.body; //store response as string

      setState(() {
        Semuafotolength = jsonDecode(data)['foto'];
      });
    } else {
      print(response.statusCode);
    }
  }
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
                  child: Text(widget.title, style: boldTextStyle(color: db6_white, size: 24, fontFamily: fontBold)),
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
                          text: widget.nama_album,
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
                          Text(widget.tanggal_album, style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14)),
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
                            imageUrl: widget.gambar,
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
                          data: widget.keterangan,
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
                    SizedBox(width: 16),
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
                              padding: EdgeInsets.only(left: 15.0, right: 15.0,bottom: 15),
                              child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: CachedNetworkImage(
                              placeholder: placeholderWidgetFn(),
                              imageUrl: jsonDecode(data)['foto'][index]['gambar'],
                              width: (width - 32) * 1,
                              height: height * 0.3,
                              fit: BoxFit.contain,
                              ),
                              ),
                            );
                          },
                          //itemCount: mFavouriteList.length,
                        );
                      }
                    ),
                    SizedBox(height: 16),
                    SizedBox(height: 15),
                    Padding(
                      padding: EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Divider(height: 16),
                    ),
                    SizedBox(height: 5),
                    Container(
                      padding: EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Center(
                        child: SignInButtonBuilder(
                          icon: Icons.mobile_screen_share,
                          text: "Share ke Sosial Media",
                          onPressed: () {
                            Share.share(widget.permalink);
                          },
                          backgroundColor: Colors.redAccent,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      margin: EdgeInsets.only(top: 12, bottom: 12, left: 16, right: 16),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[

                                ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: CachedNetworkImage(
                                    placeholder: placeholderWidgetFn(),
                                    imageUrl: widget.foto,
                                    width: 48,
                                    height: 48,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      text(widget.penulis, textColor: appStore.textPrimaryColor, fontSize: textSizeMedium, fontFamily: fontMedium),
                                      text("Fotografer", fontSize: textSizeMedium)
                                    ],
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                  ),
                                )
                              ],
                            ),
                          ),
                          T4Button(
                            textContent: "Index",
                            isStroked: true,
                            height: 40,
                            onPressed: () => Navigator.of(context).pop(true),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15),
                      child: text("Galeri Lainnya", textColor: appStore.textPrimaryColor, fontFamily: fontBold, fontSize: textSizeNormal),
                    ),
                    Container(
                      child: Galerifotolength== null ? Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: new Center( child: CircularProgressIndicator() ),
                      ) : ListView.builder(
                        padding: EdgeInsets.only(top: 0),
                        physics: NeverScrollableScrollPhysics(),
                        //scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: Galerifotolength == null ? 0 : Galerifotolength.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                              onTap : () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => GaleriDetail(
                                      id_album: jsonDecode(data)['galerifoto'][index]['id_album'].toString(),
                                      nama_album: jsonDecode(data)['galerifoto'][index]['nama_album'],
                                      keterangan: jsonDecode(data)['galerifoto'][index]['keterangan'],
                                      tanggal_album: tanggal(DateTime.parse(jsonDecode(data)['galerifoto'][index]['tanggal_album'])),
                                      penulis: jsonDecode(data)['galerifoto'][index]['penulis'],
                                      gambar: jsonDecode(data)['galerifoto'][index]['gambar'],
                                      permalink: jsonDecode(data)['galerifoto'][index]['permalink'],
                                      title: "Galeri Foto",
                                      foto: jsonDecode(data)['galerifoto'][index]['fotoku'],
                                    )));
                              },child : Container(
                            width: width * 0.7,
                            decoration: boxDecoration2(
                              showShadow: true,
                            ),
                            margin: EdgeInsets.only(left: spacing_standard_new, bottom: spacing_standard_new, right: spacing_standard_new),
                            child: Column(
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(spacing_middle), topRight: Radius.circular(spacing_middle)),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: <Widget>[
                                      CachedNetworkImage(
                                        placeholder: placeholderWidgetFn(),
                                        imageUrl: jsonDecode(data)['galerifoto'][index]['gambar'],
                                        height: width * 0.5,
                                        fit: BoxFit.cover,
                                        width: width,
                                      ),
                                      Container(
                                        width: 50,
                                        height: 50,
                                        child: Icon(
                                          Icons.camera_alt,
                                          color: db6_white,
                                          size: 30,
                                        ),
                                        decoration: BoxDecoration(shape: BoxShape.circle, color: db7_dark_yellow),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(16),
                                  child: Column(
                                    children: <Widget>[
                                      RichText(
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        // TextOverflow.clip // TextOverflow.fade
                                        text: TextSpan(
                                          text: jsonDecode(data)['galerifoto'][index]['nama_album'],
                                          style: TextStyle(fontWeight: FontWeight.normal,fontFamily: fontBold,color: appStore.textPrimaryColor,fontSize: textSizeLargeMedium),
                                        ),
                                      ),
                                      SizedBox(
                                          height: 5
                                      ),
                                      Row(
                                        children: <Widget>[
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                WidgetSpan(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(right: spacing_control),
                                                    child: SvgPicture.asset(
                                                      db6_ic_pin,
                                                      color: db7_dark_yellow,
                                                      width: 18,
                                                      height: 18,
                                                    ),
                                                  ),
                                                ),
                                                TextSpan(text: tanggal(DateTime.parse(jsonDecode(data)['galerifoto'][index]['tanggal_album'])), style: TextStyle(
                                                    fontSize: textSizeMedium, color: t13_textColorSecondary)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ));
                        },
                        //itemCount: mFavouriteList.length,
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