part of '../widgets.dart';

Widget showReceipt(String title,String image){
  return ExpansionTile(
      childrenPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      title: Text(title,
          style: GoogleFonts.poppins(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w800)),
      children: <Widget>[
        Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(left: 10,right:10),
                            height: 300,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)),
                            child: CachedNetworkImage(imageUrl:image)),
      ],
    );
}