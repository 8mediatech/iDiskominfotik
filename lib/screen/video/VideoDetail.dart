import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:diskominfotik_bengkalis/utils/constant.dart';
import 'package:diskominfotik_bengkalis/utils/resource/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:indonesia/indonesia.dart';
import 'package:link_text/link_text.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:diskominfotik_bengkalis/utils/resource/colors.dart';
import 'package:diskominfotik_bengkalis/utils/widget/widget.dart';
import 'package:diskominfotik_bengkalis/utils/resource/images.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:share/share.dart';
import 'package:flutter/rendering.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../main.dart';

// ignore: must_be_immutable
class VideoDetail extends StatefulWidget {
  static String tag = '/VideoDetail';

  // Initial variable String
  // ignore: non_constant_identifier_names
  String id_video = "";
  // ignore: non_constant_identifier_names
  String judul_video = "";
  String isi= "";
  String tanggal = "";
  String waktu = "";
  String penulis = "";
  String gambar = "";
  String permalink= "";
  String url= "";
  String title = "";
  String foto = "";

  // ignore: non_constant_identifier_names
  VideoDetail({this.id_video,this.judul_video,this.isi,this.tanggal,this.waktu,
    this.penulis,this.gambar,this.permalink,this.url,this.title,this.foto});

  @override
  VideoDetailState createState() => VideoDetailState();
}

class VideoDetailState extends State<VideoDetail> with TickerProviderStateMixin<VideoDetail> {
  String data;
  // ignore: non_constant_identifier_names
  var Videolength;
  YoutubePlayerController _controller;
  @override
  void initState() {
    _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.url),
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: true,
        forceHD: false,
        enableCaption: false,
      ),
    );
    super.initState();
    getBerita(widget.id_video);
  }
  void getBerita(nilai) async {
    http.Response response =
    await http.get(mBaseUrl + "get_related_video&id=$nilai");
    if (response.statusCode == 200) {
      data = response.body; //store response as string
      setState(() {
        Videolength = jsonDecode(data)['video'];
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
                      padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15),
                      child: RichText(
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        // TextOverflow.clip // TextOverflow.fade
                        text: TextSpan(
                          text: widget.judul_video,
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
                          Text(widget.tanggal, style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14)),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    Container(
                      padding: EdgeInsets.only(left: 15.0, right: 15.0),
                      child: YoutubePlayer(
                        controller: _controller,
                        liveUIColor: Colors.amber,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Divider(height: 16),
                    ),
                    Center(
                      child: Padding(
                          padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10),
                          child: LinkText(
                            text: widget.url,
                            textAlign: TextAlign.left,
                          )
                      ),
                    ),
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
                                      text("Videografer", fontSize: textSizeMedium)
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
                      child: text("Video Lainnya", textColor: appStore.textPrimaryColor, fontFamily: fontBold, fontSize: textSizeNormal),
                    ),
                    Videolength== null ? Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: new Center( child: CircularProgressIndicator() ),
                    ) : ListView.builder(
                        padding: EdgeInsets.only(top: 0),
                        itemCount: Videolength == null ? 0 : Videolength.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap : () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => VideoDetail(
                                      id_video: jsonDecode(data)['video'][index]['id_video'].toString(),
                                      judul_video: jsonDecode(data)['video'][index]['judul_video'],
                                      isi: jsonDecode(data)['video'][index]['isi'],
                                      tanggal: tanggal(DateTime.parse(jsonDecode(data)['video'][index]['tanggal'])),
                                      waktu: jsonDecode(data)['video'][index]['waktu'],
                                      penulis: jsonDecode(data)['video'][index]['penulis'],
                                      gambar: jsonDecode(data)['video'][index]['gambar'],
                                      permalink: jsonDecode(data)['video'][index]['permalink'],
                                      url: jsonDecode(data)['video'][index]['url'],
                                      title: "Video",
                                      foto: jsonDecode(data)['video'][index]['fotoku'],
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
                                        imageUrl: jsonDecode(data)['video'][index]['gambar'],
                                        height: width * 0.5,
                                        fit: BoxFit.cover,
                                        width: width,
                                      ),
                                      Container(
                                        width: 50,
                                        height: 50,
                                        child: Icon(
                                          Icons.play_circle_outline_rounded,
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
                                          text: jsonDecode(data)['video'][index]['judul_video'],
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
                                                TextSpan(text: tanggal(DateTime.parse(jsonDecode(data)['video'][index]['tanggal'])), style: TextStyle(
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
                        })
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


