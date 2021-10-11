import 'package:critt_v2/ui/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../screens.dart';

class MenuProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _detailBio(
            context,
            title: "Notifikasi",
          ),
          // Divider(
          //   height: 0,
          // ),
          // _detailBio(
          //   context,
          //   title: "Pengaturan Akun",
          // ),
          Divider(
            height: 0,
          ),
          _detailBio(context, title: "Cara Penggunaan", onPressed: () {
            Get.to(FAQScreen());
          }),
          Container(
            height: 5,
            color: bgGrey,
          ),
        ],
      ),
    );
  }

  Widget _detailBio(BuildContext context,
      {String? title, Function()? onPressed}) {
    return MaterialButton(
      padding: EdgeInsets.all(0),
      onPressed: onPressed,
      splashColor: Colors.grey[300],
      highlightColor: Colors.grey[300],
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: deviceWidth(context) - 100,
              child: Text(
                title!,
                style: GoogleFonts.poppins(
                    color: primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: primaryColor)
          ],
        ),
      ),
    );
  }
}
