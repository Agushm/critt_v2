import 'package:critt_v2/core/providers/providers.dart';
import 'package:critt_v2/core/utils/dialog_utils.dart';
import 'package:critt_v2/ui/constants/constants.dart';
import 'package:critt_v2/ui/screens/kirim_uang/widgets/card_detail_transaksi.dart';
import 'package:critt_v2/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DetailTransaksi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<TransaksiProvider, AuthProvider>(
      builder: (context, prov, auth, _) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children:
                      prov.penerima.map((e) => CardDetailTransaksi(e)).toList(),
                ),
              ),
              // Expanded(
              //     child: ListView.builder(
              //       shrinkWrap: true,
              //       physics: NeverScrollableScrollPhysics(),
              //       padding: EdgeInsets.symmetric(horizontal: 20),
              //       itemCount: prov.penerima.length,
              //       itemBuilder: (context, index) {
              //         return CardDetailTransaksi(index);
              //       },
              //     ),

              // ),
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: deviceWidth(context),
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: BorderSide(color: primaryColor, width: 2),
                        ),
                        color: Colors.white,
                        padding: EdgeInsets.all(15),
                        onPressed: () {
                          int maxReceiver =
                              auth.user!.isVerified! != 'verified' ? 1 : 5;
                          if (prov.penerima.length == maxReceiver) {
                            DialogUtils.instance.showInfo(
                                context,
                                'Maksimal mengirim $maxReceiver tujuan',
                                Icons.info,
                                "OK",
                                onClick: () => Get.back());
                            return;
                          }
                          prov.tambahPenerimaLagi();
                        },
                        child: Text(
                          "Tambah Transaksi",
                          style: GoogleFonts.poppins(
                              color: primaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: deviceWidth(context),
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        color: primaryColor,
                        padding: EdgeInsets.all(15),
                        onPressed: () async {
                          var jam = DateTime.now().hour;
                          if (jam >= 20 || jam <= 7) {
                            var confirm = await DialogUtils.instance
                                .showConfirmDialog(
                                    context,
                                    "Diluar Jam Oprasional",
                                    "Transaksi anda berada diluar jam oprasional dan akan diproses besuk. Yakin lanjut membuat transaksi?",
                                    btnOK: "Buat Transaksi");
                            if (confirm!) {
                              selectedBank(context, isBankMethod: true);
                            }
                          } else {
                            selectedBank(context, isBankMethod: true);
                          }
                        },
                        child: Text(
                          "Metode Pembayaran",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        )),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget buildDetailItem(String title, String content) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        title,
        style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[600]),
      ),
      Text(
        content,
        style: GoogleFonts.poppins(
            fontSize: 18, color: Colors.black, fontWeight: FontWeight.w400),
      ),
    ],
  );
}
