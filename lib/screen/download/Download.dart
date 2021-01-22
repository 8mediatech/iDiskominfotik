import 'dart:convert';

import 'package:diskominfotik_bengkalis/utils/constant.dart';
import 'package:diskominfotik_bengkalis/utils/resource/size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:indonesia/indonesia.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:diskominfotik_bengkalis/utils/resource/colors.dart';
import 'package:diskominfotik_bengkalis/utils/widget/widget.dart';
import 'package:http/http.dart' as http;
import 'package:diskominfotik_bengkalis/utils/resource/images.dart';
import '../../main.dart';
import 'DownloadDetail.dart';


class Download extends StatefulWidget {
  static String tag = '/Download';
  @override
  DownloadState createState() => DownloadState();
}

class DownloadState extends State<Download> {
  String apiUrl = mBaseUrl + "get_recent_download";
  int pageNo = 2;
  ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  bool isLastPage = false;
  List download = List();
  void _fetchData(pageNo) async {
    if (!isLoading) {
      setState(() { isLoading = true; });
      final response = await http.get(apiUrl);
      if (response.statusCode == 200) {
        List albumList = List();
        var resultBody;
        apiUrl = mBaseUrl + "get_recent_pantunpidato&page=$pageNo";
        resultBody = jsonDecode(response.body)['download'];
        for (int i = 0; i < resultBody.length; i++) {
          albumList.add(resultBody[i]);
        }
        setState(() {
          isLoading = false;
          isLastPage = pageNo == jsonDecode(response.body)['count_total'];
          download.addAll(albumList);
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
    return download.length < 1
        ? Center(
      child: Container(
        child: CircularProgressIndicator(),
      ),
    )
        : ListView.builder(
      itemCount: download.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == download.length) {
          return buildProgressIndicator();
        } else {
          return GestureDetector(
              onTap : () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => DownloadDetail(
                      kode_download: download[index]['kode_download'].toString(),
                      download: download[index]['download'],
                      file: download[index]['file'],
                      counter: download[index]['counter'].toString(),
                      tanggal: tanggal(DateTime.parse(download[index]['tanggal'])),
                      permalink: download[index]['permalink'],
                      title: "Info Publik",
                    )));
              },child : Container(
            margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
            color: appStore.scaffoldBackground,
            child: Row(
              children: <Widget>[
                Container(
                  decoration: boxDecoration2(radius: 8, showShadow: true),
                  margin: EdgeInsets.only(left: 7, right: 10, top: 7,bottom: 5),
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
                          text: download[index]['download'],
                          style: TextStyle(fontWeight: FontWeight.normal,fontFamily: fontBold,color: appStore.textPrimaryColor,fontSize: 15),
                        ),
                      ),
                      text(tanggal(DateTime.parse(download[index]['tanggal'])), fontSize: textSizeSmall)
                    ],
                  ),
                )
              ],
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
  Widget appBarTitle = Text("Info Publik",
      style: boldTextStyle(color: db6_white, size: 24, fontFamily: fontBold));

  @override
  Widget build(BuildContext context) {
    changeStatusColor(db6_colorPrimary);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: db6_colorPrimary,
        title: appBarTitle,
      ),
      body: Container(
        child: _buildList(),
      ),
    );
  }
}
