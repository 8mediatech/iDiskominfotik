import 'dart:convert';
import 'package:diskominfotik_bengkalis/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:indonesia/indonesia.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:diskominfotik_bengkalis/utils/resource/size.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:diskominfotik_bengkalis/utils/resource/colors.dart';
import 'package:diskominfotik_bengkalis/utils/widget/widget.dart';
import 'package:http/http.dart' as http;
import 'package:diskominfotik_bengkalis/utils/resource/images.dart';
import '../../main.dart';
import 'VideoDetail.dart';


class Video extends StatefulWidget {
  static String tag = '/Video';
  @override
  VideoState createState() => VideoState();
}

class VideoState extends State<Video> {
  String apiUrl = mBaseUrl + "get_recent_video";
  int pageNo = 2;
  ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  bool isLastPage = false;
  List video = List();
  void _fetchData(pageNo) async {
    if (!isLoading) {
      setState(() { isLoading = true; });
      final response = await http.get(apiUrl);
      if (response.statusCode == 200) {
        List albumList = List();
        var resultBody;
        apiUrl = mBaseUrl + "get_recent_video&page=$pageNo";
        resultBody = jsonDecode(response.body)['video'];
        for (int i = 0; i < resultBody.length; i++) {
          albumList.add(resultBody[i]);
        }
        setState(() {
          isLoading = false;
          isLastPage = pageNo == jsonDecode(response.body)['count_total'];
          video.addAll(albumList);
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
    return video.length < 1
        ? Center(
      child: Container(
        child: CircularProgressIndicator(),
      ),
    )
        : ListView.builder(
      itemCount: video.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == video.length) {
          return buildProgressIndicator();
        } else {
          return GestureDetector(
              onTap : () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => VideoDetail(
                      id_video: video[index]['id_video'].toString(),
                      judul_video: video[index]['judul_video'],
                      isi: video[index]['isi'],
                      tanggal: tanggal(DateTime.parse(video[index]['tanggal'])),
                      waktu: video[index]['waktu'],
                      penulis: video[index]['penulis'],
                      gambar: video[index]['gambar'],
                      permalink: video[index]['permalink'],
                      url: video[index]['url'],
                      title: "Video",
                      foto: video[index]['fotoku'],
                    )));
              },child : Container(
            width: width * 0.7,
            decoration: boxDecoration2(
              showShadow: true,
            ),
            margin: EdgeInsets.fromLTRB(15, 15, 15, 5),
            child: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(spacing_middle), topRight: Radius.circular(spacing_middle)),
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      CachedNetworkImage(
                        placeholder: placeholderWidgetFn(),
                        imageUrl: video[index]['gambar'],
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
                          text: video[index]['judul_video'],
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
                                TextSpan(text: tanggal(DateTime.parse(video[index]['tanggal'])), style: TextStyle(
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
  Widget appBarTitle = Text("Video",
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
