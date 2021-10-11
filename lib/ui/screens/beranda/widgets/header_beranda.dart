import 'dart:math';

import 'package:critt_v2/core/config/data.dart';
import 'package:critt_v2/core/providers/providers.dart';
import 'package:critt_v2/ui/constants/constants.dart';
import 'package:critt_v2/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HeaderBeranda extends StatelessWidget {
  final random = Random();
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, prov, _) {
        if (prov.user == null) {
          return Container();
        }
        return Stack(
          children: <Widget>[
            Container(
              width: deviceWidth(context),
              height: deviceHeight(context) / 3,
              decoration: BoxDecoration(
                  color: primaryColor,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/bgHeader.jpg'))),
            ),
            Positioned(
              top: 40,
              child: Container(
                width: deviceWidth(context) - 40,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Center(
                        child: Image.asset('assets/icons/logo.png',
                            width: 40, height: 40, color: Colors.white)),
                    Container(
                        child: Text(
                      appName.toUpperCase(),
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    )),
                    Expanded(
                      child: SizedBox(),
                    ),
                    btnBantuan()
                  ],
                ),
              ),
            ),
            Positioned(
              top: 100,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Container(
                    //   width: deviceWidth(context) - 40,
                    //   margin: EdgeInsets.symmetric(horizontal: 20),
                    //   decoration: BoxDecoration(
                    //       gradient: LinearGradient(
                    //         colors: gradientColor,
                    //         begin: Alignment.centerLeft,
                    //         end: Alignment.centerRight,
                    //       ),
                    //       borderRadius: BorderRadius.circular(15)),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     children: <Widget>[
                    //       Container(
                    //         margin: EdgeInsets.symmetric(horizontal: 20),
                    //         width: 80,
                    //         height: 80,
                    //         decoration: BoxDecoration(
                    //             image: DecorationImage(
                    //                 fit: BoxFit.cover,
                    //                 image: CachedNetworkImageProvider(
                    //                     prov.user.image)),
                    //             borderRadius: BorderRadius.circular(15)),
                    //       ),
                    //       Column(
                    //         children: <Widget>[
                    //           Text(
                    //             "${prov.user.name.toString()}",
                    //             style: GoogleFonts.poppins(
                    //                 color: Colors.white,
                    //                 fontSize: 20,
                    //                 fontWeight: FontWeight.bold),
                    //           )
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 40,
                    // ),
                    Container(
                      // margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Text("Halo ${prov.user!.name!.split(" ")[0]} !",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 25,
                          )),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: deviceWidth(context) - 40,
                      child: Text(pesanHeaderHome(prov.user!.saving!),
                          maxLines: null,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            fontSize: 16,
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
