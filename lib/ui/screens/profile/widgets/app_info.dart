import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info/package_info.dart';

Widget appInfoWidget() {
  return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (context, snap) {
        if (snap.data != null) {
          return RichText(
              text: TextSpan(
                  text: 'Versi ',
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.black45,
                      fontWeight: FontWeight.w500),
                  children: [
                TextSpan(text: '${snap.data!.version}'),
                TextSpan(
                    text: ' ',
                    style: GoogleFonts.poppins(
                        color: Colors.black54, fontWeight: FontWeight.w500)),
                TextSpan(text: '+${snap.data!.buildNumber}'),
              ]));
        }
        return SizedBox();
      });
}
