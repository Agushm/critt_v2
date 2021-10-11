import 'package:critt_v2/core/model/models.dart';
import 'package:critt_v2/core/utils/currency_utils.dart';
import 'package:critt_v2/core/providers/providers.dart';
import 'package:critt_v2/ui/screens/kirim_uang/widgets/card_detail_transaksi.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

Widget buildDetailTotalTransaksi() {
  return Consumer<TransaksiProvider>(
    builder: (context, prov, _) {
      if (prov.penerima.isNotEmpty && prov.penerima[0]["nominal"] != "0") {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildItemDetailTotalTransaksi(
                  "Kamu memiliki ", "${prov.jmlTransaksi()} Transaksi"),
              buildItemDetailTotalTransaksi(
                  "Nominal ", "${formatRupiah.format(prov.totalNominal())}"),
            ],
          ),
        );
      }
      return Container();
    },
  );
}

Widget buildItemDetailTotalTransaksi(String title, String content) {
  return RichText(
      text: TextSpan(
          text: title,
          style: GoogleFonts.poppins(fontSize: 16, color: Colors.black),
          children: <TextSpan>[
        TextSpan(
            text: content,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            )),
      ]));
}

class DetailTransaksiCard extends StatefulWidget {
  final Transaction data;
  DetailTransaksiCard(this.data);
  @override
  _DetailTransaksiCardState createState() => _DetailTransaksiCardState();
}

class _DetailTransaksiCardState extends State<DetailTransaksiCard> {
  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Text(
              "ID TRANSAKSI #${widget.data.invoiceNumber}",
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Divider(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "DETAIL TRANSAKSI",
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isOpen = !isOpen;
                    });
                  },
                  child: Text(
                    isOpen ? "Tutup" : "Buka",
                    style: GoogleFonts.poppins(
                      color: Colors.orangeAccent,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          isOpen
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child:
                      detialCardTransaksi(context, data: widget.data.reciever))
              : Container()
        ],
      ),
    );
  }
}
