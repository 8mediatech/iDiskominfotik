import 'utils/dark/AppStore.dart';
import 'utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:diskominfotik_bengkalis/screen/Paper/Paper.dart';
import 'package:diskominfotik_bengkalis/screen/Profil/Profil.dart';
import 'package:diskominfotik_bengkalis/screen/Sekretariat/Sekretariat.dart';
import 'package:diskominfotik_bengkalis/screen/statistik/Statistik.dart';
import 'package:diskominfotik_bengkalis/screen/Struktur/Struktur.dart';
import 'package:diskominfotik_bengkalis/screen/opini/Opini.dart';
import 'package:diskominfotik_bengkalis/screen/aspirasi/Aspirasi.dart';
import 'package:diskominfotik_bengkalis/screen/berita/Berita.dart';
import 'package:diskominfotik_bengkalis/screen/download/Download.dart';
import 'package:diskominfotik_bengkalis/screen/foto/Foto.dart';
import 'package:diskominfotik_bengkalis/screen/kontak/Kontak.dart';
import 'package:diskominfotik_bengkalis/screen/kontak/Privacy.dart';
import 'package:diskominfotik_bengkalis/screen/kontak/Tentang.dart';
import 'package:diskominfotik_bengkalis/screen/pengumuman/Pengumuman.dart';
import 'package:diskominfotik_bengkalis/screen/video/Video.dart';
import 'package:diskominfotik_bengkalis/screen/covid/Covid.dart';
import 'package:diskominfotik_bengkalis/screen/agenda/Agenda.dart';
import 'package:diskominfotik_bengkalis/screen/galeri/Galeri.dart';
import 'package:diskominfotik_bengkalis/screen/more/More.dart';
import 'package:diskominfotik_bengkalis/screen/Splash_Screen.dart';


AppStore appStore = AppStore();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  appStore.toggleDarkMode(value: await getBool(isDarkModeOnPref));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/Berita': (context) => Berita(),
        '/Opini': (context) => Opini(),
        '/Galeri': (context) => Galeri(),
        '/Video': (context) => Video(),
        '/Covid': (context) => Covid(),
        '/Foto': (context) => Foto(),
        '/Agenda': (context) => Agenda() ,
        '/More': (context) => More(),
        '/Pengumuman': (context) => Pengumuman(),
        '/Download': (context) => Download(),
        '/Kontak': (context) => Kontak(),
        '/Privacy': (context) => Privacy(),
        '/Tentang': (context) => Tentang(),
        '/Profil': (context) => Profil(),
        '/Sekretariat': (context) => Sekretariat(),
        '/Struktur': (context) => Struktur(),
        '/Statistik': (context) => Statistik(),
        '/Paper': (context) => Paper(),
        '/Aspirasi': (context) => Aspirasi(),
      },
      debugShowCheckedModeBanner: false,
      home: OPSplashScreen(),
    );
  }


}

