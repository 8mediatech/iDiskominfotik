import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:diskominfotik_bengkalis/utils/constant.dart';
import 'package:diskominfotik_bengkalis/utils/resource/size.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:diskominfotik_bengkalis/utils/resource/colors.dart';
import 'package:diskominfotik_bengkalis/utils/widget/widget.dart';
import 'package:diskominfotik_bengkalis/utils/resource/string.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';

// ignore: must_be_immutable
class Struktur extends StatefulWidget {
  static String tag = '/Struktur';
  @override
  StrukturState createState() => StrukturState();
  String name;
  String totalChapter;
  String backgroundImages;
}

class StrukturState extends State<Struktur> {

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
    await http.get(mBaseUrl + "get_recent_pegawai");
    if (response.statusCode == 200) {
      data = response.body; //store response as string
      setState(() {
        Posts_Length = jsonDecode(data)['pegawai'];
      });
    } else {
      print(response.statusCode);
    }
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var width = MediaQuery.of(context).size.width;
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
                                            child: Text(lbl_pegawai, style: boldTextStyle(size: 24, color: Colors.white)),
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
                margin: EdgeInsets.only(top: 15, left: 0, right: 0),
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
                        return Container(
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
                                  alignment: Alignment.bottomLeft,
                                  children: <Widget>[
                                    CachedNetworkImage(
                                      placeholder: placeholderWidgetFn(),
                                      imageUrl: jsonDecode(data)['pegawai'][index]['gambar'],
                                      height: width * 1.2,
                                      fit: BoxFit.cover,
                                      width: width,
                                    ),
                                    Container(
                                      alignment: Alignment.bottomLeft,
                                      margin: EdgeInsets.only(left: spacing_middle, bottom: spacing_standard_new),
                                      child: Container(
                                        padding: EdgeInsets.fromLTRB(spacing_standard_new, spacing_control_half, spacing_standard_new, spacing_control_half),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: <Color>[db7_dark_yellow, db7_dark_yellow],
                                          ),
                                          borderRadius: BorderRadius.all(Radius.circular(80.0)),
                                        ),
                                        child: text(jsonDecode(data)['pegawai'][index]['jabatan'], textColor: db6_white, fontSize: 12.0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[text(jsonDecode(data)['pegawai'][index]['nama_pegawai'], fontFamily: fontMedium,textColor: appStore.textPrimaryColor)],
                                    ),
                                    SizedBox(
                                        height: 5
                                    ),
                                    Row(
                                      children: <Widget>[
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(text: jsonDecode(data)['pegawai'][index]['nip'], style: TextStyle(fontSize: textSizeSmall, color: t13_textColorSecondary)),
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