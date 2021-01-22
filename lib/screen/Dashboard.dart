import 'dart:async';
import 'dart:math' as math; // import this
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:diskominfotik_bengkalis/screen/more/More.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;
import 'package:diskominfotik_bengkalis/models/ModelUtils.dart';
import 'package:diskominfotik_bengkalis/utils/constant.dart';
import 'package:diskominfotik_bengkalis/utils/notification/notification_bloc.dart';
import 'package:diskominfotik_bengkalis/utils/notification/notification_service.dart';
import 'package:diskominfotik_bengkalis/utils/resource/size.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:diskominfotik_bengkalis/utils/resource/colors.dart';
import 'package:diskominfotik_bengkalis/utils/resource/images.dart';
import 'package:diskominfotik_bengkalis/utils/resource/string.dart';
import 'package:diskominfotik_bengkalis/utils/widget/widget.dart';
import 'package:diskominfotik_bengkalis/utils/dummy.dart';
import 'package:indonesia/indonesia.dart';
import 'package:diskominfotik_bengkalis/screen/video/VideoDetail.dart';
import 'package:diskominfotik_bengkalis/screen/agenda/AgendaDetail.dart';
import 'package:diskominfotik_bengkalis/screen/pengumuman/PengumumanDetail.dart';
import 'package:diskominfotik_bengkalis/screen/berita/Berita.dart';
import 'package:diskominfotik_bengkalis/screen/berita/BeritaDetail.dart';
import 'package:diskominfotik_bengkalis/screen/download/DownloadDetail.dart';
import 'package:diskominfotik_bengkalis/screen/foto/FotoDetail.dart';
import 'package:diskominfotik_bengkalis/screen/galeri/GaleriDetail.dart';
import '../main.dart';

class Dashboard extends StatefulWidget {
  static String tag = '/Dashboard';
  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  // ignore: non_constant_identifier_names
  Widget LabelLink(var text, var permalink) {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(text,
              style: TextStyle(
                  fontSize: 18,
                  color: db6_black,
                  fontFamily: fontIntro,
                  fontWeight: FontWeight.w500)),
          new GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, permalink);
            },
            child: Text(lbl_semua,
                style: TextStyle(fontSize: 14, color: db6_textColorSecondary)),
          )
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget LabelBiasa(var text) {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(text,
              style: TextStyle(
                  fontSize: 18,
                  color: db6_black,
                  fontFamily: fontIntro,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  var gradientColor2 = <Color>[
    Color(0XFFFF727B),
    Color(0XFF439AF8),
    Color(0XFF72D4A1),
    Color(0XFFFFC358),
    Color(0XFFA89DF6)
  ];
  var gradientColor1 = <Color>[
    Color(0XFFFF727B),
    Color(0XFF439AF8),
    Color(0XFF72D4A1),
    Color(0XFFFFC358),
    Color(0XFFA89DF6)
  ];
  List<SliderBanner> mSliderList;
  List<Category> mFavouriteList;
  List<KontakModel> mListings;
  DateTime date = DateTime.now(); // 12 April 1996
  String data;
  // ignore: non_constant_identifier_names
  var Posts_Length;
  // ignore: non_constant_identifier_names
  // ignore: non_constant_identifier_names
  var Videolength;
  // ignore: non_constant_identifier_names
  var Covidlength;
  // ignore: non_constant_identifier_names
  var Galerifotolength;
  // ignore: non_constant_identifier_names
  var Beritafotolength;
  // ignore: non_constant_identifier_names
  var Downloadlength;
  // ignore: non_constant_identifier_names
  var Agendalength;
  // ignore: non_constant_identifier_names
  var Pengumumanlength;
  // ignore: non_constant_identifier_names
  var BannerLength;
  // ignore: non_constant_identifier_names
  var Banner2Length;
  // ignore: non_constant_identifier_names
  var Banner3Length;
  // ignore: non_constant_identifier_names
  var Kategorilength;
  StreamSubscription<Map> _notificationSubscription;
  @override
  void initState() {
    super.initState();
    NotificationService.instance.start();
    _notificationSubscription = NotificationsBloc.instance.notificationStream
        .listen(_performActionOnNotification);
    mSliderList = GetSliders();
    mFavouriteList = GetCategoryItems();
    mListings = getListData();
    getBanner();
  }

  _performActionOnNotification(Map<String, dynamic> message) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Berita(),
      ),
    );
  }

  @override
  void dispose() {
    _notificationSubscription.cancel();
    super.dispose();
  }

  void getBanner() async {
    http.Response response = await http.get(mBaseUrl + "get_recent_dashboard");
    if (response.statusCode == 200) {
      data = response.body; //store response as string
      setState(() {
        BannerLength = jsonDecode(data)['slider'];
        Kategorilength = jsonDecode(data)['kategori'];
        Banner2Length = jsonDecode(data)['slider2'];
        Banner3Length = jsonDecode(data)['slider3'];
        Posts_Length = jsonDecode(data)['posts'];
        Videolength = jsonDecode(data)['video'];
        Covidlength = jsonDecode(data)['covid'];
        Galerifotolength = jsonDecode(data)['galerifoto'];
        Beritafotolength = jsonDecode(data)['beritafoto'];
        Downloadlength = jsonDecode(data)['download'];
        Agendalength = jsonDecode(data)['agenda'];
        Pengumumanlength = jsonDecode(data)['pengumuman'];
      });
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness:
          Brightness.dark, // this will change the brightness of the icons
      statusBarColor: db6_colorPrimary, // or any color you want
    ));
    //changeStatusColor(db6_colorPrimary);
    var width = MediaQuery.of(context).size.width;
    var w = MediaQuery.of(context).size.width;
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 275,
                        child: CustomPaint(painter: _MyPainter()),
                      ),
                      Banner(mSliderList),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.sort, color: white),
                                  onPressed: () {
                                    finish(context);
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.notification_important,
                                      color: white),
                                  onPressed: () {
                                    finish(context);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        transform: Matrix4.translationValues(0.0, 200.0, 0.0),
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Container(
                            margin:
                                EdgeInsets.only(left: 0, right: 0, bottom: 16),
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                                color: appStore.scaffoldBackground,
                                border: Border.all(
                                  color: iconColorSecondary.withOpacity(0.2),
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => More()));
                              },
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 12, left: 0),
                                    child: Icon(Icons.search),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Masukan Katakunci...",
                                      maxLines: 1,
                                      softWrap: false,
                                      overflow: TextOverflow.fade,
                                      //style: Get.textTheme.caption,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => More()));
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          right: 10,
                                          left: 10,
                                          top: 10,
                                          bottom: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                        color:
                                            iconColorSecondary.withOpacity(0.1),
                                      ),
                                      child: Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        spacing: 4,
                                        children: [
                                          Text("Filter"),
                                          Icon(
                                            Icons.filter_list,
                                            size: 21,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    alignment: Alignment.centerRight,
                    children: <Widget>[
                      SizedBox(
                        height: 295,
                        child: Menu(mFavouriteList),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ListView.builder(
                        itemCount: Pengumumanlength == null
                            ? 0
                            : Pengumumanlength.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PengumumanDetail(
                                          id_pengumuman: jsonDecode(data)['pengumuman'][index]['id_pengumumann'],
                                          str:
                                          jsonDecode(data)['pengumuman']
                                          [index]
                                          ['judul_pengumuman'],
                                          permalink: "Pengumuman",
                                          isi:
                                          jsonDecode(data)['pengumuman']
                                          [index]['isi'],
                                          tgl: tanggal(DateTime.parse(
                                              jsonDecode(data)['pengumuman']
                                              [index]['tanggal'])),
                                          urlku:
                                          jsonDecode(data)['pengumuman']
                                          [index]['permalink'],
                                          file:
                                          jsonDecode(data)['pengumuman']
                                          [index]['permalink'],
                                        )));
                              },
                              child: VerifyCards(
                                size: size,
                                title: 'Pengumuman',
                                subtitle: jsonDecode(data)['pengumuman'][index]
                                ['judul_pengumuman'],
                                image: 'images/dashboard/opvideocall.png',
                                color: Color(0xFFf35459),
                              ));
                        }),
                  ),
                  SizedBox(height: 15),
                  LabelLink(lbl_video2, lbl_permalinkvideo2),
                  SizedBox(height: 3),
                  Container(
                    margin: EdgeInsets.only(left: 16, right: 16),
                    child: Text('Informasi Perkembangan Covid-19',
                        style: secondaryTextStyle(size: 14)),
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                    height: 300,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: Covidlength == null ? 0 : Covidlength.length,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VideoDetail(
                                          id_video:
                                          jsonDecode(data)['covid']
                                          [index]['id_video']
                                              .toString(),
                                          judul_video:
                                          jsonDecode(data)['covid']
                                          [index]['judul_video'],
                                          isi: jsonDecode(data)['covid']
                                          [index]['isi'],
                                          tanggal: tanggal(DateTime.parse(
                                              jsonDecode(data)['covid']
                                              [index]['tanggal'])),
                                          waktu: jsonDecode(data)['covid']
                                          [index]['waktu'],
                                          penulis: jsonDecode(data)['covid']
                                          [index]['penulis'],
                                          gambar: jsonDecode(data)['covid']
                                          [index]['gambar'],
                                          permalink:
                                          jsonDecode(data)['covid']
                                          [index]['permalink'],
                                          url: jsonDecode(data)['covid']
                                          [index]['url'],
                                          title: "Video",
                                          foto: jsonDecode(data)['covid'][index]['fotoku'],
                                        )));
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 15),
                                width: MediaQuery.of(context).size.width * 0.75,
                                decoration: boxDecoration2(
                                    radius: 5,
                                    showShadow: true,
                                    bgColor: db6_white),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Stack(
                                      alignment: Alignment.center,
                                      children: <Widget>[
                                        ClipRRect(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(8.0),
                                              topRight: Radius.circular(5.0)),
                                          child: CachedNetworkImage(
                                              placeholder:
                                              placeholderWidgetFn(),
                                              imageUrl:
                                              jsonDecode(data)['covid']
                                              [index]['gambar'],
                                              height: w * 0.45,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.95,
                                              fit: BoxFit.fill),
                                        ),
                                        Container(
                                          width: 50,
                                          height: 50,
                                          child: Icon(
                                            Icons.play_arrow,
                                            color: db6_white,
                                            size: 30,
                                          ),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: db7_dark_yellow),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Icon(Icons.date_range,
                                                  size: 14,
                                                  color: db7_dark_yellow),
                                              SizedBox(width: 2),
                                              Text(
                                                  tanggal(DateTime.parse(
                                                      jsonDecode(data)['covid']
                                                      [index]['tanggal'])),
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w400,
                                                      fontSize: 12)),
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          RichText(
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            // TextOverflow.clip // TextOverflow.fade
                                            text: TextSpan(
                                              text: jsonDecode(data)['covid']
                                              [index]['judul_video'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: fontRoboto,
                                                  color:
                                                  appStore.textPrimaryColor,
                                                  fontSize: 14),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ));
                        }),
                  ),
                  SizedBox(height: 15),

                  LabelLink(lbl_beritaterkini, lbl_permalinkberita),
                  SizedBox(height: 3),
                  Container(
                    margin: EdgeInsets.only(left: 16, right: 16),
                    child: Text('Anti-Hoak dengan berita terpercaya',
                        style: secondaryTextStyle(size: 14)),
                  ),
                  if (Posts_Length == null)
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: new Center(child: CircularProgressIndicator()),
                    )
                  else
                    ListView.builder(
                      padding: EdgeInsets.only(top: 15),
                      physics: NeverScrollableScrollPhysics(),
                      //scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: Posts_Length == null ? 0 : Posts_Length.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BeritaDetail(
                                            id_berita: jsonDecode(data)['posts']
                                                    [index]['id_berita']
                                                .toString(),
                                            judul_berita:
                                                jsonDecode(data)['posts'][index]
                                                    ['judul_berita'],
                                            isi: jsonDecode(data)['posts']
                                                [index]['isi'],
                                            tanggal: tanggal(DateTime.parse(
                                                jsonDecode(data)['posts'][index]
                                                    ['tanggal'])),
                                            waktu: jsonDecode(data)['posts']
                                                [index]['waktu'],
                                            url_gambar:
                                                jsonDecode(data)['posts'][index]
                                                    ['url_gambar'],
                                            gambar: jsonDecode(data)['posts']
                                                [index]['gambar'],
                                            permalink: jsonDecode(data)['posts']
                                                [index]['permalink'],
                        kategori: jsonDecode(data)['posts'][index]['title'],
                        editor: jsonDecode(data)['posts'][index]['editor'],
                        reporter: jsonDecode(data)['posts'][index]['reporter'],
                        fotografer: jsonDecode(data)['posts'][index]['fotografer'],
                        editor_foto: jsonDecode(data)['posts'][index]['editorfoto'],
                        reporter_foto: jsonDecode(data)['posts'][index]['reporterfoto'],
                        fotografer_foto: jsonDecode(data)['posts'][index]['fotograferfoto'],
                        title: "Berita",
                        ket_foto: jsonDecode(data)['posts'][index]['ket_foto'],
                                          )));
                            },
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: appStore.scaffoldBackground,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: defaultBoxShadow()),
                                child: Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  color: appStore.scaffoldBackground,
                                  child: Row(
                                    children: <Widget>[
                                      CachedNetworkImage(
                                          placeholder: placeholderWidgetFn(),
                                          imageUrl: jsonDecode(data)['posts']
                                              [index]['gambar'],
                                          width: width / 3.6,
                                          height: width / 4.7,
                                          fit: BoxFit.fill),
                                      Container(
                                        width: width - (width / 3.5) - 35,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: index % 2 == 0
                                                        ? t8_red
                                                        : db6_colorPrimary,
                                                    borderRadius: BorderRadius
                                                        .only(
                                                            bottomRight:
                                                                Radius.circular(
                                                                    16.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    16.0)),
                                                  ),
                                                  padding: EdgeInsets.fromLTRB(
                                                      8, 2, 8, 2),
                                                  child: Text(
                                                      index % 2 == 0
                                                          ? jsonDecode(
                                                                  data)['posts']
                                                              [index]['title']
                                                          : jsonDecode(
                                                                  data)['posts']
                                                              [index]['title'],
                                                      style: primaryTextStyle(
                                                          color: white,
                                                          size: 12)),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 2),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 7.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                      jsonDecode(data)['posts']
                                                              [index]
                                                          ['judul_berita'],
                                                      style: primaryTextStyle(
                                                          color: appStore
                                                              .textPrimaryColor,
                                                          size: 14,
                                                          fontFamily:
                                                              fontRoboto,
                                                          weight:
                                                              FontWeight.w600)),
                                                  SizedBox(height: 4),
                                                  Row(
                                                    children: <Widget>[
                                                      Icon(Icons.date_range,
                                                          size: 14,
                                                          color:
                                                              db7_dark_yellow),
                                                      SizedBox(width: 2),
                                                      Text(
                                                          tanggal(DateTime.parse(
                                                              jsonDecode(data)[
                                                                          'posts']
                                                                      [index]
                                                                  ['tanggal'])),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 12)),
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
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  margin: EdgeInsets.all(0),
                                ),
                              ),
                            ));
                      },
                      //itemCount: mFavouriteList.length,
                    ),
                  LabelLink(lbl_video, lbl_permalinkvideo),
                  SizedBox(height: 3),
                  Container(
                    margin: EdgeInsets.only(left: 16, right: 16),
                    child: Text('Diskominfotik Kabupaten Bengkalis',
                        style: secondaryTextStyle(size: 14)),
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                    height: 300,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: Videolength == null ? 0 : Videolength.length,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VideoDetail(
                                              id_video:
                                                  jsonDecode(data)['video']
                                                          [index]['id_video']
                                                      .toString(),
                                              judul_video:
                                                  jsonDecode(data)['video']
                                                      [index]['judul_video'],
                                              isi: jsonDecode(data)['video']
                                                  [index]['isi'],
                                              tanggal: tanggal(DateTime.parse(
                                                  jsonDecode(data)['video']
                                                      [index]['tanggal'])),
                                              waktu: jsonDecode(data)['video']
                                                  [index]['waktu'],
                                              penulis: jsonDecode(data)['video']
                                                  [index]['penulis'],
                                              gambar: jsonDecode(data)['video']
                                                  [index]['gambar'],
                                              permalink:
                                                  jsonDecode(data)['video']
                                                      [index]['permalink'],
                                              url: jsonDecode(data)['video']
                                                  [index]['url'],
                                              title: "Video",
                          foto: jsonDecode(data)['video'][index]['fotoku'],
                                            )));
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 15),
                                width: MediaQuery.of(context).size.width * 0.75,
                                decoration: boxDecoration2(
                                    radius: 5,
                                    showShadow: true,
                                    bgColor: db6_white),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Stack(
                                      alignment: Alignment.center,
                                      children: <Widget>[
                                        ClipRRect(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(8.0),
                                              topRight: Radius.circular(5.0)),
                                          child: CachedNetworkImage(
                                              placeholder:
                                                  placeholderWidgetFn(),
                                              imageUrl:
                                                  jsonDecode(data)['video']
                                                      [index]['gambar'],
                                              height: w * 0.45,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.95,
                                              fit: BoxFit.fill),
                                        ),
                                        Container(
                                          width: 50,
                                          height: 50,
                                          child: Icon(
                                            Icons.play_arrow,
                                            color: db6_white,
                                            size: 30,
                                          ),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: db7_dark_yellow),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Icon(Icons.date_range,
                                                  size: 14,
                                                  color: db7_dark_yellow),
                                              SizedBox(width: 2),
                                              Text(
                                                  tanggal(DateTime.parse(
                                                      jsonDecode(data)['video']
                                                          [index]['tanggal'])),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 12)),
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          RichText(
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            // TextOverflow.clip // TextOverflow.fade
                                            text: TextSpan(
                                              text: jsonDecode(data)['video']
                                                  [index]['judul_video'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: fontRoboto,
                                                  color:
                                                      appStore.textPrimaryColor,
                                                  fontSize: 14),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ));
                        }),
                  ),


                  Padding(
                    padding: EdgeInsets.only(top: 0, left: 15, right: 15),
                    child: ListView.builder(
                        padding: EdgeInsets.only(top: 5),
                        itemCount:
                        BannerLength == null ? 0 : BannerLength.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Column(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: <Widget>[
                                    CachedNetworkImage(
                                      placeholder: placeholderWidgetFn(),
                                      imageUrl: jsonDecode(data)['slider']
                                      [index]['slide_image'],
                                      fit: BoxFit.fill,
                                      width: width,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                  SizedBox(height: 15),
                  LabelLink(lbl_download, lbl_permalinkdownload),
                  Container(
                    margin: EdgeInsets.only(left: 16, right: 16),
                    child: Text('Diskominfotik Kabupaten Bengkalis',
                        style: secondaryTextStyle(size: 14)),
                  ),
                  ListView.builder(
                      padding: EdgeInsets.only(top: 15),
                      itemCount:
                          Downloadlength == null ? 0 : Downloadlength.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DownloadDetail(
                                            kode_download:
                                                jsonDecode(data)['download']
                                                        [index]['kode_download']
                                                    .toString(),
                                            download:
                                                jsonDecode(data)['download']
                                                    [index]['download'],
                                            file: jsonDecode(data)['download']
                                                [index]['file'],
                                            counter:
                                                jsonDecode(data)['download']
                                                        [index]['counter']
                                                    .toString(),
                                            tanggal: tanggal(DateTime.parse(
                                                jsonDecode(data)['download']
                                                    [index]['tanggal'])),
                                            permalink:
                                                jsonDecode(data)['download']
                                                    [index]['permalink'],
                                            title: "Info Publik",
                                          )));
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 5, right: 5, bottom: 5, top: 5),
                              color: appStore.scaffoldBackground,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    decoration: boxDecoration2(
                                        radius: 8, showShadow: true),
                                    margin: EdgeInsets.only(
                                        left: 15, right: 15, top: 0, bottom: 0),
                                    width: width / 7.2,
                                    height: width / 7.2,
                                    child: SvgPicture.asset(t5_download),
                                    padding: EdgeInsets.all(width / 40),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        RichText(
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          // TextOverflow.clip // TextOverflow.fade
                                          text: TextSpan(
                                            text: jsonDecode(data)['download']
                                                [index]['download'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontFamily: fontRoboto,
                                                color:
                                                    appStore.textPrimaryColor,
                                                fontSize: 14),
                                          ),
                                        ),
                                        text(
                                            tanggal(DateTime.parse(
                                                jsonDecode(data)['download']
                                                    [index]['tanggal'])),
                                            fontSize: textSizeSmall)
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ));
                      }),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ListView.builder(
                        padding: EdgeInsets.only(top: 0),
                        itemCount:
                            Agendalength == null ? 0 : Agendalength.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AgendaDetail(
                                              str: jsonDecode(data)['agenda']
                                                  [index]['tema_agenda'],
                                              permalink: "Agenda",
                                              isi: jsonDecode(data)['agenda']
                                                  [index]['isi'],
                                              tgl: tanggal(DateTime.parse(
                                                  jsonDecode(data)['agenda']
                                                      [index]['tanggal'])),
                                              jam: jsonDecode(data)['agenda']
                                                  [index]['jam'],
                                              lokasi: jsonDecode(data)['agenda']
                                                  [index]['tempat'],
                                            )));
                              },
                              child: VerifyCards(
                                size: size,
                                title: 'Agenda',
                                subtitle: jsonDecode(data)['agenda'][index]
                                    ['tema_agenda'],
                                image: 'images/dashboard/opvideocall.png',
                                color: Color(0xFFf35459),
                              ));
                        }),
                  ),
                  SizedBox(height: 15),
                  LabelLink(lbl_galeri, lbl_permalinkgaleri),
                  SizedBox(height: 3),
                  Container(
                    margin: EdgeInsets.only(left: 16, right: 16),
                    child: Text('Diskominfotik Kabupaten Bengkalis',
                        style: secondaryTextStyle(size: 14)),
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                    height: 300,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: Galerifotolength == null
                            ? 0
                            : Galerifotolength.length,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GaleriDetail(
                                              id_album:
                                                  jsonDecode(data)['galerifoto']
                                                          [index]['id_album']
                                                      .toString(),
                                              nama_album:
                                                  jsonDecode(data)['galerifoto']
                                                      [index]['nama_album'],
                                              keterangan:
                                                  jsonDecode(data)['galerifoto']
                                                      [index]['keterangan'],
                                              tanggal_album: tanggal(
                                                  DateTime.parse(
                                                      jsonDecode(data)[
                                                                  'galerifoto']
                                                              [index]
                                                          ['tanggal_album'])),
                                              penulis:
                                                  jsonDecode(data)['galerifoto']
                                                      [index]['penulis'],
                                              gambar:
                                                  jsonDecode(data)['galerifoto']
                                                      [index]['gambar'],
                                              permalink:
                                                  jsonDecode(data)['galerifoto']
                                                      [index]['permalink'],
                                              title: "Galeri Foto",
                                              foto: jsonDecode(data)['galerifoto'][index]['fotoku'],
                                            )));
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 15),
                                width: MediaQuery.of(context).size.width * 0.75,
                                decoration: boxDecoration2(
                                    radius: 5,
                                    showShadow: true,
                                    bgColor: db6_white),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Stack(
                                      alignment: Alignment.center,
                                      children: <Widget>[
                                        ClipRRect(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(7.0),
                                              topRight: Radius.circular(7.0)),
                                          child: CachedNetworkImage(
                                              placeholder:
                                                  placeholderWidgetFn(),
                                              imageUrl:
                                                  jsonDecode(data)['galerifoto']
                                                      [index]['gambar'],
                                              height: w * 0.45,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.95,
                                              fit: BoxFit.cover),
                                        ),
                                        Container(
                                          width: 50,
                                          height: 50,
                                          child: Icon(
                                            Icons.camera_alt,
                                            color: db6_white,
                                            size: 30,
                                          ),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: db7_dark_yellow),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Icon(Icons.date_range,
                                                  size: 14,
                                                  color: db7_dark_yellow),
                                              SizedBox(width: 2),
                                              Text(
                                                  tanggal(DateTime.parse(
                                                      jsonDecode(data)[
                                                                  'galerifoto']
                                                              [index]
                                                          ['tanggal_album'])),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 12)),
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          RichText(
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            // TextOverflow.clip // TextOverflow.fade
                                            text: TextSpan(
                                              text:
                                                  jsonDecode(data)['galerifoto']
                                                      [index]['nama_album'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: fontRoboto,
                                                  color:
                                                      appStore.textPrimaryColor,
                                                  fontSize: 14),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ));
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ListView.builder(
                        padding: EdgeInsets.only(top: 5),
                        itemCount:
                        Banner3Length == null ? 0 : Banner3Length.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Column(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: <Widget>[
                                    CachedNetworkImage(
                                      placeholder: placeholderWidgetFn(),
                                      imageUrl: jsonDecode(data)['slider3']
                                      [index]['slide_image'],
                                      fit: BoxFit.fill,
                                      width: width,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                  LabelLink(lbl_beritafoto, lbl_permalinkberitafoto),
                  SizedBox(height: 3),
                  Container(
                    margin: EdgeInsets.only(left: 16, right: 16),
                    child: Text('Diskominfotik Kabupaten Bengkalis',
                        style: secondaryTextStyle(size: 14)),
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                    height: 300,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: Beritafotolength == null
                            ? 0
                            : Beritafotolength.length,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FotoDetail(
                                              id_beritafoto:
                                                  jsonDecode(data)['beritafoto']
                                                              [index]
                                                          ['id_beritafoto']
                                                      .toString(),
                                              judul_beritafoto:
                                                  jsonDecode(data)['beritafoto']
                                                          [index]
                                                      ['judul_beritafoto'],
                                              isi:
                                                  jsonDecode(data)['beritafoto']
                                                      [index]['isi'],
                                              tanggal: tanggal(DateTime.parse(
                                                  jsonDecode(data)['beritafoto']
                                                      [index]['tanggal'])),
                                              waktu:
                                                  jsonDecode(data)['beritafoto']
                                                      [index]['waktu'],
                                              penulis:
                                                  jsonDecode(data)['beritafoto']
                                                      [index]['penulis'],
                                              gambar:
                                                  jsonDecode(data)['beritafoto']
                                                      [index]['gambar'],
                                              permalink:
                                                  jsonDecode(data)['beritafoto']
                                                      [index]['permalink'],
                                              title: "Berita Foto",
                                          foto: jsonDecode(data)['beritafoto'][index]['fotoku'],
                                            )));
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 15),
                                width: MediaQuery.of(context).size.width * 0.75,
                                decoration: boxDecoration2(
                                    radius: 5,
                                    showShadow: true,
                                    bgColor: db6_white),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Stack(
                                      alignment: Alignment.center,
                                      children: <Widget>[
                                        ClipRRect(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(7.0),
                                              topRight: Radius.circular(7.0)),
                                          child: CachedNetworkImage(
                                              placeholder:
                                                  placeholderWidgetFn(),
                                              imageUrl:
                                                  jsonDecode(data)['beritafoto']
                                                      [index]['gambar'],
                                              height: w * 0.45,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.95,
                                              fit: BoxFit.cover),
                                        ),
                                        Container(
                                          width: 50,
                                          height: 50,
                                          child: Icon(
                                            Icons.camera_alt,
                                            color: db6_white,
                                            size: 30,
                                          ),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: db7_dark_yellow),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Icon(Icons.date_range,
                                                  size: 14,
                                                  color: db7_dark_yellow),
                                              SizedBox(width: 2),
                                              Text(
                                                  tanggal(DateTime.parse(
                                                      jsonDecode(data)[
                                                              'beritafoto']
                                                          [index]['tanggal'])),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 12)),
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          RichText(
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            // TextOverflow.clip // TextOverflow.fade
                                            text: TextSpan(
                                              text:
                                                  jsonDecode(data)['beritafoto']
                                                          [index]
                                                      ['judul_beritafoto'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: fontRoboto,
                                                  color:
                                                      appStore.textPrimaryColor,
                                                  fontSize: 14),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ));
                        }),
                  ),
                  SizedBox(height: 15),
                  LabelBiasa(lbl_kontak),
                  SizedBox(height: 15),
                  Container(
                    decoration: BoxDecoration(
                        boxShadow: defaultBoxShadow(), color: white),
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 0, right: 0, bottom: 0, top: 0),
                      child: ListView.builder(
                          padding: EdgeInsets.only(top: 10),
                          scrollDirection: Axis.vertical,
                          itemCount: mListings.length,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 5, bottom: 15),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        decoration: boxDecoration2(
                                            radius: 8, showShadow: true),
                                        margin: EdgeInsets.only(
                                            left: 16, right: 16),
                                        width: width / 7.2,
                                        height: width / 7.2,
                                        child: SvgPicture.asset(
                                            mListings[index].icon),
                                        padding: EdgeInsets.all(width / 30),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                text(mListings[index].name,
                                                    textColor: appStore
                                                        .textPrimaryColor,
                                                    fontSize: textSizeMedium,
                                                    fontFamily: fontSemibold)
                                              ],
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                            ),
                                            text(mListings[index].day,
                                                fontSize: textSizeSmall)
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Divider(height: 0.5, color: t5ViewColor)
                              ],
                            );
                          }),
                    ),
                  ),
                  SizedBox(height: 15)
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

// ignore: must_be_immutable
class Banner extends StatelessWidget {
  List<SliderBanner> mSliderList;

  Banner(this.mSliderList);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    width = width - 50;

    return Container(
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: <Widget>[
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 10),
              height: 250,
              viewportFraction: 1.0,
              onPageChanged: (index, reason) {
                //controller.currentSlide.value = index;
              },
            ),
            items: mSliderList.map((slider) {
              return Builder(
                builder: (BuildContext context) {
                  return Stack(
                    children: [
                      Transform(
                        transform: Matrix4.rotationY(
                            Directionality.of(context) == TextDirection.rtl
                                ? math.pi
                                : 0),
                        child: Image.asset(slider.image),
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 60, horizontal: 20),
                          child: SizedBox(
                            width: 225,
                            child: Column(
                              children: [
                                Text(
                                  slider.balance,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: fontRoboto,
                                  ),
                                  maxLines: 1,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  slider.accountNo,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: fontIntro,
                                      fontSize: 21),
                                  maxLines: 3,
                                ),
                              ],
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                            ),
                          )),
                    ],
                  );
                },
              );
            }).toList(),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: mSliderList.map((slider) {
                return Container(
                  width: 20.0,
                  height: 5.0,
                  margin: EdgeInsets.symmetric(vertical: 40.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: Colors.white.withOpacity(0.4)),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class Menu extends StatelessWidget {
  List<Category> mFavouriteList;
  //var isScrollable = false;

  Menu(this.mFavouriteList);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GridView.builder(
        padding: EdgeInsets.only(top: 5),
        physics: NeverScrollableScrollPhysics(),
        itemCount: mFavouriteList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, crossAxisSpacing: 0, mainAxisSpacing: 3),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, mFavouriteList[index].permalink);
              },
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: width / 7.5,
                    width: width / 7.5,
                    margin: EdgeInsets.only(bottom: 5, top: 0),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: color_menu,
                        boxShadow: defaultBoxShadow(),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: mFavouriteList[index].color,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: SvgPicture.asset(
                        mFavouriteList[index].icon,
                        color: db6_white,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      mFavouriteList[index].name,
                      style: TextStyle(fontFamily: fontProduct, fontSize: 14),
                    ),
                  )
                ],
              ));
        });
  }
}

class _MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.style = PaintingStyle.fill;
    paint.color = db6_colorPrimary;
    Path path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 40);
    path.lineTo(size.width, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

// class _MyPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     var rect = Offset.zero & size;
//     Paint paint = Paint();
//     paint.style = PaintingStyle.fill;
//     paint.shader = LinearGradient(
//       begin: Alignment.centerLeft,
//       end: Alignment.centerRight,
//       colors: [
//         warna1,
//         warna2,
//       ],
//     ).createShader(rect);
//     Path path = Path();
//     path.lineTo(0, size.height - 40);
//     path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height - 40);
//     path.lineTo(size.width, 0);
//     canvas.drawPath(path, paint);
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }
