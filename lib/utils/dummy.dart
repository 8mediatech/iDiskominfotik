import 'dart:core';
import 'package:diskominfotik_bengkalis/models/ModelUtils.dart';
import 'package:diskominfotik_bengkalis/utils/resource/colors.dart';
import 'package:diskominfotik_bengkalis/utils/resource/images.dart';


// ignore: non_constant_identifier_names
List<SliderBanner> GetSliders() {
  List<SliderBanner> list = List<SliderBanner>();

  SliderBanner model1 = SliderBanner();
  model1.image = db4_bg_card_1;
  model1.balance = "Pemerintah Kabupaten Bengkalis";
  model1.accountNo = "Dinas Komunikasi Informatika dan Statistik";

  SliderBanner model2 = SliderBanner();
  model2.image = db4_bg_card_1;
  model2.balance = "Terwujudnya Kabupaten Bengkalis";
  model2.accountNo = "Sebagai Model Negeri Maju dan Makmur";

  SliderBanner model3 = SliderBanner();
  model3.image = db4_bg_card_1;
  model3.balance = "Terwujudnya Pemerintahan";
  model3.accountNo = "Yang Berwibawa dan Transparan";

  list.add(model1);
  list.add(model2);
  list.add(model3);
  return list;
}
// ignore: non_constant_identifier_names
List<Category> GetCategoryItems() {
  var list = List<Category>();
  var category1 = Category();
  category1.name = "Berita";
  category1.permalink = "/Berita";
  category1.color = db4_cat_1;
  category1.icon = db4_berita;
  list.add(category1);

  var category2 = Category();
  category2.name = "Galeri";
  category2.permalink = "/Galeri";
  category2.color = db4_cat_2;
  category2.icon = db4_galeri;
  list.add(category2);

  var category3 = Category();
  category3.name = "Video";
  category3.permalink = "/Video";
  category3.color = db4_cat_3;
  category3.icon = db4_video;
  list.add(category3);

  var category4 = Category();
  category4.name = "Foto";
  category4.permalink = "/Foto";
  category4.color = db4_cat_4;
  category4.icon = db4_foto;
  list.add(category4);

  var category5 = Category();
  category5.name = "Opini";
  category5.permalink = "/Opini";
  category5.color = db4_cat_5;
  category5.icon = db4_opini;
  list.add(category5);


  var category7 = Category();
  category7.name = "Pengumuman";
  category7.permalink = "/Pengumuman";
  category7.color = db4_cat_7;
  category7.icon = db4_pengumuman;
  list.add(category7);

  var category8 = Category();
  category8.name = "Agenda";
  category8.permalink = "/Agenda";
  category8.color = db4_cat_8;
  category8.icon = db4_agenda;
  list.add(category8);


  var category10 = Category();
  category10.name = "Info Publik";
  category10.permalink = "/Download";
  category10.color = db4_cat_10;
  category10.icon = db4_publik;
  list.add(category10);

  var category11 = Category();
  category11.name = "Pegawai";
  category11.permalink = "/Struktur";
  category11.color = db4_cat_1;
  category11.icon = db4_pegawai;
  list.add(category11);

  var category12 = Category();
  category12.name = "Profil";
  category12.permalink = "/Profil";
  category12.color = db4_cat_2;
  category12.icon = db4_profil;
  list.add(category12);

  var category13 = Category();
  category13.name = "Unit Kerja";
  category13.permalink = "/Sekretariat";
  category13.color = db4_cat_3;
  category13.icon = db4_unitkerja;
  list.add(category13);


  var category = Category();
  category.name = "Kontak";
  category.permalink = "/Kontak";
  category.color = db4_cat_12;
  category.icon = db4_kontak;
  list.add(category);
  return list;
}

// ignore: non_constant_identifier_names
List<KontakModel> getListData() {
  var list = List<KontakModel>();
  var bill = KontakModel();

  bill.name = "Alamat Kantor";
  bill.day = "Jl. Kartini No. 012 Kode Pos 28712 Bengkalis Riau";
  bill.icon = t5_light_bulb;

  list.add(bill);

  var bill2 = KontakModel();
  bill2.name = "Email";
  bill2.day = "diskominfotik@bengkaliskab.go.id";
  bill2.icon = t5_call_answer;

  list.add(bill2);

  var bill3 = KontakModel();
  bill3.name = "Website";
  bill3.day = "www.diskominfotik.bengkaliskab.go.id";
  bill3.icon = t5_wifi;


  list.add(bill3);


  return list;
}

