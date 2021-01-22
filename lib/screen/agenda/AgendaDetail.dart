import 'package:diskominfotik_bengkalis/utils/resource/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:diskominfotik_bengkalis/utils/resource/colors.dart';
import 'package:diskominfotik_bengkalis/utils/widget/widget.dart';

import '../../main.dart';



// ignore: must_be_immutable
class AgendaDetail extends StatelessWidget {
  // Initial variable String
  String str = "";
  String permalink = "";
  String isi = "";
  String tgl = "";
  String jam = "";
  String lokasi = "";

// Get Key Data
  AgendaDetail({Key key, this.str,this.permalink,this.isi,this.tgl,this.jam,this.lokasi}): super(key: key);
  @override
  Widget build(BuildContext context) {
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
                  child: Text(permalink, style: boldTextStyle(color: db6_white, size: 24, fontFamily: fontBold)),
                ),

              ),
            )
          ];
        },

        body: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Container(
                    decoration: boxDecoration2(bgColor: appStore.scaffoldBackground, radius: 8, showShadow: true),
                    margin: EdgeInsets.only(bottom: 20),
                    padding: EdgeInsets.only(left: 15, right: 15,top: 10),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 8),
                        RichText(
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          // TextOverflow.clip // TextOverflow.fade
                          text: TextSpan(
                            text: str,
                            style: TextStyle(fontWeight: FontWeight.normal,fontFamily: fontBold,
                                color: appStore.textPrimaryColor,fontSize: textSizeLarge),
                          ),
                        ),
                        Container(
                          child: DataTable(
                            showBottomBorder: true,
                            columns: <DataColumn>[
                              DataColumn(label: Text("")),
                              DataColumn(label: Text("")),


                            ],
                            rows: <DataRow>[
                              DataRow(
                                cells: <DataCell>[
                                  DataCell(Text("Tanggal")),
                                  DataCell(Text(tgl)),


                                ],
                              ),
                              DataRow(
                                cells: <DataCell>[
                                  DataCell(Text("Jam")),
                                  DataCell(Text(jam)),


                                ],
                              ),
                              DataRow(
                                cells: <DataCell>[
                                  DataCell(Text("Agenda")),
                                  DataCell(Text(str)),


                                ],
                              ),
                              DataRow(
                                cells: <DataCell>[
                                  DataCell(Text("Lokasi")),
                                  DataCell(Text(lokasi)),


                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),

                      ],
                    ),
                  ),

                ),
              ),
            )
          ],
        ),
      ),

    );
  }
}