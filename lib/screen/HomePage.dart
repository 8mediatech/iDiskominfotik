import 'package:diskominfotik_bengkalis/utils/widget/LearnerBottomNavigationBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:diskominfotik_bengkalis/utils/resource/colors.dart';
import 'package:diskominfotik_bengkalis/utils/resource/images.dart';
import 'Dashboard.dart';
import 'Kategori/Kategori.dart';
import 'norifikasi/Notifikasi.dart';
import 'setting/Setting.dart';


class HomePage extends StatefulWidget {
  static String tag = '/HomePage';

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  var isSelected = 0;

  @override
  void initState() {
    super.initState();
    isSelected = 0;
  }
  @override
  Widget build(BuildContext context) {

    //debugPrint('token: $token');
    final tab = [
      Dashboard(),
      Kategori(),
      Notifikasi(),
      Setting(),
    ];
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(boxShadow: [BoxShadow(color: learner_ShadowColor, offset: Offset.fromDirection(3, 1), spreadRadius: 1, blurRadius: 5)]),
        child: LearnerBottomNavigationBar(
          items: const <LearnerBottomNavigationBarItem>[
            LearnerBottomNavigationBarItem(icon: db6_ic_home),
            LearnerBottomNavigationBarItem(icon: db4_menu),
            LearnerBottomNavigationBarItem(icon: db4_fire),
            LearnerBottomNavigationBarItem(icon: db4_setting),
          ],
          currentIndex: isSelected,
          unselectedIconTheme: IconThemeData(color: db6_textColorSecondary, size: 24),
          selectedIconTheme: IconThemeData(color: db4_cat_1, size: 24),
          onTap: (int index) {
            setState(() {
              isSelected = index;
            });
          },
          type: LearnerBottomNavigationBarType.fixed,
        ),
      ),
      body: tab[isSelected],

    );
  }
}

