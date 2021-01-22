import 'dart:convert';
import 'package:diskominfotik_bengkalis/screen/berita/BeritaKategori.dart';
import 'package:diskominfotik_bengkalis/utils/constant.dart';
import 'package:diskominfotik_bengkalis/utils/resource/images.dart';
import 'package:diskominfotik_bengkalis/utils/resource/size.dart';
import 'package:diskominfotik_bengkalis/utils/widget/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:diskominfotik_bengkalis/utils/resource/colors.dart';
import 'package:http/http.dart' as http;
import '../../main.dart';


class Kategori extends StatefulWidget {
  static String tag = '/Kategori';
  @override
  KategoriState createState() => KategoriState();
}

class KategoriState extends State<Kategori> {
  String data;
  // ignore: non_constant_identifier_names
  var Kategorilength;


  void getBerita() async {
    http.Response response =
    await http.get(mBaseUrl + "get_category_index");
    if (response.statusCode == 200) {
      data = response.body; //store response as string
      setState(() {
        Kategorilength = jsonDecode(data)['categories'];//get all the data from json string superheros// just printed length of data
      });
    } else {
      print(response.statusCode);
    }
  }
  @override
  void initState() {
    super.initState();
    getBerita();
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
  var isScrollable = false;
  Widget appBarTitle = Text("Kategori",
      style: boldTextStyle(color: db6_white, size: 24, fontFamily: fontBold));

  @override
  Widget build(BuildContext context) {
    changeStatusColor(db6_colorPrimary);
    var width = MediaQuery.of(context).size.width;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: db6_colorPrimary,
        title: Text("Kategori", style: boldTextStyle(color: db6_white, size: 24, fontFamily: fontBold)),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 35, left: 15, right: 15),
                width: size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    if (Kategorilength == null) Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: new Center( child: CircularProgressIndicator() ),
                    ) else GridView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: Kategorilength == null ? 0 : Kategorilength.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 16, mainAxisSpacing: 16),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap : () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => BeritaKategori(
                                    type: jsonDecode(data)['categories'][index]['permalink'],
                                    title: jsonDecode(data)['categories'][index]['kategori'],
                                    categoryId: jsonDecode(data)['categories'][index]['id_kategori'].toString(),
                                  )));
                            },child :  Container(
                          decoration: boxDecoration2(bgColor: appStore.scaffoldBackground, radius: 8, showShadow: true),
                          margin: EdgeInsets.only(bottom: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: width / 5.5,
                                width: width / 5.5,
                                margin: EdgeInsets.only(bottom:0, top: 0),
                                padding: EdgeInsets.all(10),
                                child: Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(spacing_standard)),
                                      gradient: LinearGradient(
                                        colors: [
                                          gradientColor1[index % gradientColor1.length],
                                          gradientColor2[index % gradientColor2.length]
                                        ],
                                      )),
                                  child: SvgPicture.asset(
                                    db4_berita,
                                    color: db6_white,
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  jsonDecode(data)['categories'][index]['kategori'],
                                  textAlign: TextAlign.center,
                                    style: TextStyle(fontFamily: fontProduct, fontSize: textSizeSmall)
                                ),
                              )
                            ],
                          ),
                        )
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}




