import 'dart:convert';
import 'package:diskominfotik_bengkalis/utils/constant.dart';
import 'package:diskominfotik_bengkalis/utils/resource/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
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

import '../../main.dart';

// ignore: must_be_immutable
class DownloadDetail extends StatefulWidget {
  static String tag = '/DownloadDetail';
  // ignore: non_constant_identifier_names
  String kode_download = "";
  // ignore: non_constant_identifier_names
  String download = "";
  // ignore: non_constant_identifier_names
  String file= "";
  // ignore: non_constant_identifier_names
  String counter = "";
  // ignore: non_constant_identifier_names
  String tanggal = "";
  // ignore: non_constant_identifier_names
  String permalink= "";
  String title = "";

  // ignore: non_constant_identifier_names
  DownloadDetail({this.kode_download,this.download,this.file,this.counter,this.tanggal,
    // ignore: non_constant_identifier_names
    this.permalink,this.title});

  @override
  DownloadDetailState createState() => DownloadDetailState();
}

class DownloadDetailState extends State<DownloadDetail> with TickerProviderStateMixin<DownloadDetail> {
  String data;
  // ignore: non_constant_identifier_names
  var Downloadlength;
  // ignore: non_constant_identifier_names

  @override
  void initState() {
    super.initState();
    getBerita(widget.kode_download);
  }
  void getBerita(nilai) async {
    http.Response response =
    await http.get(mBaseUrl + "get_single_download&id=$nilai");
    if (response.statusCode == 200) {
      data = response.body; //store response as string
      setState(() {
        Downloadlength = jsonDecode(data)['download'];
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
                  padding: EdgeInsets.fromLTRB(15, 15, 0, 0),
                  child: Text(widget.title, style: boldTextStyle(color: db6_white, size: 24, fontFamily: fontBold)),
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
                          Text(widget.tanggal, style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14)),
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
                          text: widget.download,
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
                                      text("Administrator", textColor: appStore.textPrimaryColor, fontSize: textSizeMedium, fontFamily: fontMedium),
                                      text("Tim Diskominfotik", fontSize: textSizeMedium)
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
                      padding: EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Divider(height: 16),
                    ),
                    Center(
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RaisedButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute<dynamic>(
                                builder: (context) => PDFViewerFromUrl(
                                  file : widget.file,
                                ),
                              ),
                            ),
                            color: db4_cat_5,
                            child: Padding(
                              padding: EdgeInsets.only(left: 5.0, right: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Baca',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Icon(
                                    Icons.read_more,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          RaisedButton(
                            onPressed: () {
                              launchURL(widget.file);
                            },
                            color: db4_cat_1,
                            child: Padding(
                              padding: EdgeInsets.only(left: 5.0, right: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Download',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Icon(
                                    Icons.add_to_drive,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Downloadlength== null ? Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: new Center( child: CircularProgressIndicator() ),
                    ) : ListView.builder(
                        itemCount: Downloadlength == null ? 0 : Downloadlength.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap : () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => DownloadDetail(
                                      kode_download: jsonDecode(data)['download'][index]['kode_download'].toString(),
                                      download: jsonDecode(data)['download'][index]['download'],
                                      file: jsonDecode(data)['download'][index]['file'],
                                      counter: jsonDecode(data)['download'][index]['counter'].toString(),
                                      tanggal: tanggal(DateTime.parse(jsonDecode(data)['download'][index]['tanggal'])),
                                      permalink: jsonDecode(data)['download'][index]['permalink'],
                                      title: "Info Publik",
                                    )));
                              },child : Container(
                            margin: EdgeInsets.only(left: 5, right: 5, top: 15),
                            color: appStore.scaffoldBackground,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  decoration: boxDecoration2(radius: 8, showShadow: true),
                                  margin: EdgeInsets.only(left: 15, right: 15),
                                  width: width / 7.2,
                                  height: width / 7.2,
                                  child: SvgPicture.asset(t5_download),
                                  padding: EdgeInsets.all(width / 40),
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
                                          text: jsonDecode(data)['download'][index]['download'],
                                          style: TextStyle(fontWeight: FontWeight.normal,fontFamily: fontBold,color: appStore.textPrimaryColor,fontSize: 15),
                                        ),
                                      ),
                                      text(tanggal(DateTime.parse(jsonDecode(data)['download'][index]['tanggal'])), fontSize: textSizeSmall)
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ));
                        }),
                    SizedBox(height: 15),


                ]),
              ),
            ),
          ),
        ),
      ),

    );
  }
}
class PDFViewerFromUrl extends StatelessWidget {
  const PDFViewerFromUrl({Key key, @required this.file}) : super(key: key);

  final String file;

  @override
  Widget build(BuildContext context) {
    changeStatusColor(db6_colorPrimary);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: db6_colorPrimary,
        title: Text("Baca Dokumen", style: boldTextStyle(color: db6_white, size: 24, fontFamily: fontBold)),
      ),
      body: const PDF().fromUrl(
        file,
        placeholder: (double progress) => Center(child: Text('$progress %')),
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ),
    );
  }
}
