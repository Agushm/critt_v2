import 'package:flutter/material.dart';

String appName = 'Critt';
const syaratKetentuanTransaksi =
    'Dengan memilih metode transfer, saya telah setuju dengan ';

List<String> refundReason = [
  'Transfer kurang dari nominal transaksi',
  'Transfer lebih dari nominal transaksi',
  'Salah kirim ke rekening $appName',
  'Terkirim lebih dari satu kali',
  'Pengembalian dana dari transaksi yang dibatalkan'
];
//* Constant Color
const primaryColor = Color(0xff44B4F2);
const darkPrimaryColor = Color(0xff3182A3);
const btnBlue = Color(0xff68dcc7);
const textNominal = Color(0xfff49a31);
const bgGrey = Color(0xfff1f1f1);
const selectedGridColor = Color(0xfff7b460);
const unselectedGridColor = Color(0xffe4e4e4);

class CustomColors {
  static const primaryTextColor = Colors.white;
  static const dividerColor = Colors.white54;
  static const pageBackgroundColor = Color(0xFF2D2F41);
  static const menuBackgroundColor = Color(0xFF242634);

  static const clockBG = Color(0xFF444974);
  static const clockOutline = Color(0xFFEAECFF);
  static const secHandColor = Colors.orange;
  static const minHandStatColor = Color(0xFF748EF6);
  static const minHandEndColor = Color(0xFF77DDFF);
  static const hourHandStatColor = Color(0xFFC279FB);
  static const hourHandEndColor = Color(0xFFEA74AB);
}

class GradientColors {
  final List<Color> colors;
  GradientColors(this.colors);

  static List<Color> sky = [Colors.transparent, Colors.white54];
  static List<Color> sunset = [Colors.transparent, primaryColor];
  static List<Color> sea = [Color(0xFF61A3FE), Color(0xFF63FFD5)];
  static List<Color> mango = [Color(0xFFFFA738), Color(0xFFFFE130)];
  static List<Color> fire = [Color(0xFFFF5DCD), Color(0xFFFF8484)];
  static List<Color> success = [Color(0xFF028090), Color(0xFF00BFB2)];
}

class GradientTemplate {
  static List<GradientColors> gradientTemplate = [
    GradientColors(GradientColors.sky),
    GradientColors(GradientColors.sunset),
    GradientColors(GradientColors.sea),
    GradientColors(GradientColors.mango),
    GradientColors(GradientColors.fire),
    GradientColors(GradientColors.success),
  ];
}

//* Device size
double deviceWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double deviceHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

const OutlineInputBorder formBorder =
    OutlineInputBorder(borderSide: BorderSide(width: 2, color: primaryColor));
const UnderlineInputBorder pinFormBorder =
    UnderlineInputBorder(borderSide: BorderSide(width: 2, color: primaryColor));
const TextStyle ppobFormLabelStyle = TextStyle(
    color: primaryColor,
    fontFamily: "omind",
    fontSize: 16,
    fontWeight: FontWeight.w500);

const TextStyle appBarStyle = TextStyle(
    color: Colors.white, fontFamily: "omind", fontWeight: FontWeight.w500);

Color colorStatusTransaction(String status) {
  if (status == 'failed') {
    return Colors.black45;
  } else if (status == "on-progress") {
    return Colors.orange;
  } else if (status == "success") {
    return Colors.green;
  } else {
    return Colors.black;
  }
}

String stringVerification(String isVerified) {
  if (isVerified == 'on-process') {
    return 'Proses verifikasi';
  } else if (isVerified == 'verified') {
    return 'Terverifikasi';
  } else {
    return 'Belum verifikasi';
  }
}
