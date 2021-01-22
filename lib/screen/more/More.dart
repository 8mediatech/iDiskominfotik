import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:diskominfotik_bengkalis/utils/constant.dart';
import 'package:diskominfotik_bengkalis/utils/resource/size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:indonesia/indonesia.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:diskominfotik_bengkalis/screen/berita/BeritaDetail.dart';
import 'package:diskominfotik_bengkalis/screen/berita/BeritaKategori.dart';
import 'package:diskominfotik_bengkalis/utils/resource/colors.dart';
import 'package:diskominfotik_bengkalis/models/ModelUtils.dart';
import 'package:diskominfotik_bengkalis/utils/dummy.dart';
import 'package:diskominfotik_bengkalis/utils/widget/widget.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';

class More extends StatefulWidget {
  static String tag = '/More';
  @override
  MoreState createState() => MoreState();
}

class MoreState extends State<More> {
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
  String data;
  // ignore: non_constant_identifier_names
  var Kategorilength;
  // ignore: non_constant_identifier_names
  var Posts_Length;
  bool isLoading = false;
  var searchText = '';

  void getKategori() async {
    http.Response response =
    await http.get(mBaseUrl + "get_recent_dashboard");

    if (response.statusCode == 200) {
      data = response.body; //store response as string

      setState(() {
        Kategorilength = jsonDecode(
            data)['kategori'];
      });
    } else {
      print(response.statusCode);
    }
  }
  TextEditingController controller = TextEditingController();
  List<Category> mFavouriteList;

  @override
  void initState() {
    super.initState();
    mFavouriteList = GetCategoryItems();
    getKategori();
  }

  void getBerita(nilai) async {
    http.Response response =
    await http.get(mBaseUrl + "get_search_results&search=$nilai");

    if (response.statusCode == 200) {
      data = response.body; //store response as string
      setState(() {
        Posts_Length = jsonDecode(data)['posts']; //get all the data from json string superheros
      });
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    changeStatusColor(db6_colorPrimary);

    final searchList = ListView.builder(
      padding: EdgeInsets.only(top: 15),
      itemCount: Posts_Length == null ? 0 : Posts_Length.length,
      itemBuilder: (BuildContext context, int index) {
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
                    editor_foto: jsonDecode(data)['posts'][index]['editorfoto'],
                    reporter_foto: jsonDecode(data)['posts'][index]['reporterfoto'],
                    fotografer_foto: jsonDecode(data)['posts'][index]['fotograferfoto'],
                    title: "Berita",
                    ket_foto: jsonDecode(data)['posts'][index]['ket_foto'],
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
                      width: width / 3.6,
                      height: width / 4.7, fit: BoxFit.fill),
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
      },
      //itemCount: mFavouriteList.length,
    );
    var searchListBawah = ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.only(left: spacing_standard_new,right: spacing_standard_new,top: spacing_standard_new),
        itemCount: mFavouriteList.length,
        itemBuilder: (BuildContext contxt, int index) {
          return GestureDetector(
              onTap : () {
            Navigator.pushNamed(context, mFavouriteList[index].permalink);
          },child : Container(
            margin: EdgeInsets.only(bottom: spacing_standard),
            decoration: boxDecoration2(bgColor: appStore.scaffoldBackground,showShadow: true),
            child: Row(
              children: <Widget>[
                SvgPicture.asset(mFavouriteList[index].icon, width: 24, height: 24,color: t12_colors[index%t12_colors.length],).paddingRight(spacing_standard_new),
                Expanded(
                  child: text(
                      mFavouriteList[index].name, fontSize: textSizeMedium,
                      textColor: appStore.textPrimaryColor),
                ),
                Icon(Icons.keyboard_arrow_right,size: 20,color: appStore.iconColor,)
              ],
            ).paddingAll(spacing_middle),
          ));
        });

    return Scaffold(
      appBar: AppBar(
        title: toolBarTitle("Pencarian"),
        leading: Icon(Icons.close,color: appStore.iconColor).onTap((){
          finish(context);
        }),
        iconTheme: IconThemeData(color: appStore.textPrimaryColor),
        backgroundColor: appStore.appBarColor,
        elevation: 0,
      ),
      body: Container(
    decoration: BoxDecoration(color: db4_LayoutBackgroundWhite),
    child:  Column(
        children: <Widget>[
          16.height,
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                      left: spacing_standard_new, right: spacing_standard_new),
                  decoration: boxDecoration2(
                    showShadow: true, radius: spacing_standard,),
                  child: TextFormField(
                    controller: controller,
                    textInputAction: TextInputAction.search,
                    onFieldSubmitted: (term) {
                      searchText = term;
                      setState(() {
                        isLoading = true;
                      });
                      getBerita(searchText);
                    },
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: "Masukan Kata Kunci..",
                      hintStyle: TextStyle(
                          fontSize: textSizeLargeMedium,
                          color: t12_text_secondary),
                      prefixIcon: Icon(
                        Icons.search,
                        color: t12_text_secondary,
                        size: 20,
                      ),
                    ),
                    style: TextStyle(
                        fontSize: textSizeNormal,
                        color: t12_text_color_primary,
                        fontFamily: fontRegular),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: spacing_standard_new),
                decoration: boxDecoration2(
                    showShadow: true, radius: spacing_standard,bgColor: appStore.scaffoldBackground),
                child: Icon(
                  Icons.filter_list, color: t12_primary_color, size: 30,)
                    .paddingAll(spacing_standard),
              )
            ],
          ),
          SizedBox(height: 15),
          Container(
              height: width * 0.11, margin: EdgeInsets.only(left: 7, right: 7),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: Kategorilength == null ? 0 : Kategorilength.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap : () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => BeritaKategori(
                              type: jsonDecode(data)['kategori'][index]['permalink'],
                              title: jsonDecode(data)['kategori'][index]['name'],
                              categoryId: jsonDecode(data)['kategori'][index]['category_id'].toString(),
                            )));
                      },

                      child: Container(
                        width: width * 0.4,
                        height: width * 0.2,
                        margin: EdgeInsets.only(left: spacing_standard, right: spacing_control),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(spacing_standard)),
                            gradient: LinearGradient(
                              colors: [
                                gradientColor1[index % gradientColor1.length],
                                gradientColor2[index % gradientColor2.length]
                              ],
                            )),
                        child: text(jsonDecode(data)['kategori'][index]['name'],
                            textColor: white,
                            fontFamily: fontBold,
                            fontSize: textSizeMedium,
                            maxLine: 1,
                            isCentered: true),
                      ),
                    );
                  })),
          Container(
            child: Expanded(
              child: searchList,
            ),
          ),
          Container(
            child: Expanded(
              child: searchListBawah,
            ),
          )
        ],
      ),
    ));
  }
}
