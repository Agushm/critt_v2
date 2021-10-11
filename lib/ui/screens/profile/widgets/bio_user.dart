import 'package:critt_v2/core/providers/providers.dart';
import 'package:critt_v2/ui/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BioUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, prov, _) {
        return Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              _detailBio(
                context,
                title: prov.user!.phone!,
                icon: Icon(
                  Icons.call,
                  color: Colors.black45,
                  size: 20,
                ),
              ),
              _detailBio(
                context,
                title: prov.user!.address!,
                icon: Icon(
                  Icons.home,
                  color: Colors.black45,
                  size: 20,
                ),
              ),
              _detailBio(
                context,
                title: prov.user!.email!,
                icon: Icon(
                  Icons.mail_outline,
                  size: 20,
                  color: Colors.black45,
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _detailBio(BuildContext context, {String? title, Widget? icon}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        children: <Widget>[
          icon!,
          SizedBox(
            width: 20,
          ),
          Container(
            width: deviceWidth(context) - 100,
            child: Text(
              title!,
              style: GoogleFonts.poppins(
                  color: Colors.black45,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
