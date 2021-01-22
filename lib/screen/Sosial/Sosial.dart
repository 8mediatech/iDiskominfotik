import 'dart:convert';
import 'package:diskominfotik_bengkalis/screen/berita/BeritaDetail.dart';
import 'package:diskominfotik_bengkalis/utils/constant.dart';
import 'package:diskominfotik_bengkalis/utils/resource/size.dart';
import 'package:diskominfotik_bengkalis/utils/widget/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:indonesia/indonesia.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:diskominfotik_bengkalis/utils/resource/colors.dart';
import 'package:http/http.dart' as http;
import '../../main.dart';


class Sosial extends StatefulWidget {
  static String tag = '/Sosial';
  @override
  SosialState createState() => SosialState();
}

class SosialState extends State<Sosial> {
  String apiUrl = mBaseUrl + "get_recent_posts";
  int pageNo = 2;
  ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  bool isLastPage = false;
  List posts = List();


  void _fetchData(pageNo) async {
    if (!isLoading) {
      setState(() { isLoading = true; });
      final response = await http.get(apiUrl);
      if (response.statusCode == 200) {
        List albumList = List();
        var resultBody;
        apiUrl = mBaseUrl + "get_recent_posts&page=$pageNo";
        resultBody = jsonDecode(response.body)['posts'];
        for (int i = 0; i < resultBody.length; i++) {
          albumList.add(resultBody[i]);
        }
        setState(() {
          isLoading = false;
          isLastPage = pageNo == jsonDecode(response.body)['count_total'];
          posts.addAll(albumList);
        });
      } else {
        setState(() { isLoading = false; });
      }
    }
  }
  @override
  void initState() {
    _fetchData(pageNo);
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        pageNo++;
        _fetchData(pageNo);
      }
    });
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  Widget _buildList() {
    var width = MediaQuery.of(context).size.width;
    return posts.length < 1
        ? Center(
      child: Container(
        child: CircularProgressIndicator(),
      ),
    )
        : ListView.builder(
      itemCount: posts.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == posts.length) {
          return buildProgressIndicator();
        } else {
          return GestureDetector(
              onTap : () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => BeritaDetail(
                      id_berita: posts[index]['id_berita'].toString(),
                      judul_berita: posts[index]['judul_berita'],
                      isi: posts[index]['isi'],
                      tanggal: tanggal(DateTime.parse(posts[index]['tanggal'])),
                      waktu: posts[index]['waktu'],
                      url_gambar: posts[index]['url_gambar'],
                      gambar: posts[index]['gambar'],
                      permalink: posts[index]['permalink'],
                      kategori: posts[index]['title'],
                      editor: posts[index]['editor'],
                      reporter: posts[index]['reporter'],
                      fotografer: posts[index]['fotografer'],
                      title: "Berita",
                    )));
              },child : Padding(
            padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
            child: Container(
              decoration: BoxDecoration(color: appStore.scaffoldBackground,borderRadius: BorderRadius.circular(10), boxShadow: defaultBoxShadow()),
              child: Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: appStore.scaffoldBackground,
                child: Row(
                  children: <Widget>[
                    CachedNetworkImage(placeholder: placeholderWidgetFn(), imageUrl: posts[index]['gambar'],
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
                                child: Text(index % 2 == 0 ? posts[index]['title'] : posts[index]['title'],
                                    style: primaryTextStyle(color: white, size: 12)),
                              ),
                            ],
                          ),
                          SizedBox(height: 2),
                          Padding(
                            padding: EdgeInsets.only(left: 7.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(posts[index]['judul_berita'],
                                    style: primaryTextStyle(color: appStore.textPrimaryColor, size: 16,fontFamily: fontBold)),
                                SizedBox(height: 4),
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.date_range, size: 14, color: db7_dark_yellow),
                                    SizedBox(width: 2),
                                    Text(tanggal(DateTime.parse(posts[index]['tanggal'])), style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12)),
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
        }

      },
      controller: _scrollController,
    );
  }
  Icon actionIcon = Icon(
    Icons.search,
    color: Colors.white,
  );
  FocusNode focusNode = FocusNode();
  Widget appBarTitle = Text("Sosial",
      style: boldTextStyle(color: db6_white, size: 24, fontFamily: fontBold));

  @override
  Widget build(BuildContext context) {
    changeStatusColor(db6_colorPrimary);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: db6_colorPrimary,
        title: Text("Sosial", style: boldTextStyle(color: db6_white, size: 24, fontFamily: fontBold)),
      ),
      body: Container(
        child: _buildList(),
      ),
    );
  }
}




