import 'package:cached_network_image/cached_network_image.dart';
import 'package:diskominfotik_bengkalis/utils/resource/size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:diskominfotik_bengkalis/utils/resource/colors.dart';
import 'package:diskominfotik_bengkalis/models/ModelUtils.dart';
import 'package:diskominfotik_bengkalis/utils/dummy.dart';
import 'package:diskominfotik_bengkalis/utils/widget/widget.dart';
import 'package:diskominfotik_bengkalis/utils/resource/images.dart';
import 'package:share/share.dart';

import '../../main.dart';

class Privacy extends StatefulWidget {
  static String tag = '/Privacy';
  @override
  PrivacyState createState() => PrivacyState();
}

class PrivacyState extends State<Privacy> {
  List<KontakModel> mListings;
  String data;
  // ignore: non_constant_identifier_names
  var Posts_Length;

  @override
  void initState() {
    super.initState();
    mListings = getListData();
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
                  child: Text("Privacy & Term", style: boldTextStyle(color: db6_white, size: 24, fontFamily: fontBold)),
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
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        // TextOverflow.clip // TextOverflow.fade
                        text: TextSpan(
                          text: "Kebijakan Privasi",
                          style: TextStyle(fontWeight: FontWeight.normal,fontFamily: fontBold,
                              color: appStore.textPrimaryColor,fontSize: textSizeLarge),
                        ),
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
                            imageUrl: "https://prokopim.bengkaliskab.go.id/slider/120737073_3457139001009690_3970561288380566856_o.jpg",
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
                          data: "<p><strong>Diskominfotik</strong> merupakan Portal aplikasi Pemerintah Kabupaten Bengkalis"
                              " yang menyediakan berbagai macam fitur aplikasi layanan publik bagi masyarakat mulai dari berita,"
                              " agenda, pengumuman, pengaduan masyarakat dan juga layanan internal bagi ASN pemerintah Kabupaten Bengkalis</p> "
                              "<p><strong>Layanan Kami</strong><br />memberikan layanan informasi kepada Masyarakat kabupaten bengkalis</p> <p>"
                              "<strong>Jenis layanan dan fitur dalam aplikasi</strong><br />- Berita</p> <p>- Galeri</p> <p>- Video</p> "
                              "<p>- Berita Foto</p> <p>- Pantun</p> <p>- Pidato</p> <p>- Agenda</p> <p>- Pengumuman</p> <p>- Penghargaan</p>"
                              " <p>- Download Dokumen</p> <p><br />Pengumpulan Informasi Pengguna<br />- Aplikasi membutuhkan koneksi internet</p>"
                              " <p>- Aplikasi tidak memungkinkan melakukan panggilan telepon</p> <p><br /><strong>Keamanan</strong><br />"
                              "Aplikasi Diskominfotik sangat peduli dengan menjaga informasi Anda. Kami menerapkan langkah-langkah wajar"
                              " yang dirancang untuk melindungi informasi Anda dari akses yang tidak sah. Namun, ada risiko yang "
                              "melekat dalam menggunakan Internet, dan kami tidak dapat menjamin bahwa informasi Anda akan 100% aman.</p>"
                              " <p><strong>Perubahan Kebijakan Privasi</strong><br />"
                              "Kebijakan Privasi ini mungkin di ubah dan/atau diperbaharui"
                              " dari waktu ke waktu tanpa pemberitahuan sebelumnya. Aplikasi"
                              " Diskominfotik menyarankan agar Anda membaca secara seksama dan memeriksa"
                              " halaman Kebijakan Privasi ini dari waktu ke waktu untuk mengetahui "
                              "perubahan apapun. Dengan tetap mengakses dan menggunakan layanan Aplikasi "
                              "Diskominfotik, maka Pengguna dianggap menyetujui perubahan-perubahan dalam Kebijakan Privasi ini.</p>",
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
                                      text("Tim Humas", textColor: appStore.textPrimaryColor, fontSize: textSizeMedium, fontFamily: fontMedium),
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
                          Share.share("");
                        },
                      ),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Divider(height: 16),
                    ),



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
