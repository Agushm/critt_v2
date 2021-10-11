import 'package:cached_network_image/cached_network_image.dart';
import 'package:critt_v2/core/model/models.dart';
import 'package:critt_v2/core/utils/currency_utils.dart';
import 'package:critt_v2/core/providers/providers.dart';
import 'package:critt_v2/ui/constants/constants.dart';
import 'package:critt_v2/ui/screens/kirim_uang/widgets/detail_transaksi.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardDetailTransaksi extends StatelessWidget {
  final Map<String, dynamic> data;
  CardDetailTransaksi(this.data);
  @override
  Widget build(BuildContext context) {
    return Consumer<TransaksiProvider>(
      builder: (context, prov, _) {
        return Container(
          margin: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: primaryColor.withOpacity(0.1)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  width: 120,
                  height: 60,
                  child: CachedNetworkImage(
                    imageUrl: data["bank_image"],
                  )),
              Divider(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: (deviceWidth(context) - 70) / 2,
                              child: buildDetailItem(
                                "Rekening Tujuan",
                                "${data["bank_number"]}\n${data["name_account"]}",
                              ),
                            ),
                            Container(
                              width: (deviceWidth(context) - 70) / 2,
                              child: buildDetailItem(
                                "Nominal",
                                formatRupiah.format(int.parse(data["nominal"])),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: buildDetailItem("Berita Transfer",
                                  "${data["berita"]} via $appName"),
                            ),
                            // Container(
                            //   width: (deviceWidth(context) - 70) / 2,
                            //   child: buildDetailItem("Biaya", "Rp 0"),
                            // ),
                          ],
                        ),
                      ],
                    ),
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

Widget detialCardTransaksi(BuildContext context, {List<Reciever>? data}) {
  return ListView.builder(
    shrinkWrap: true,
    itemCount: data!.length,
    physics: NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      return Container(
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: primaryColor.withOpacity(0.1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: data[index].bankImage!,
              fit: BoxFit.scaleDown,
              height: 50,
              width: 100,
            ),
            Divider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: (deviceWidth(context) - 70) / 2,
                            child: buildDetailItem(
                              "Rekening Tujuan",
                              "${data[index].bankName}\n${data[index].nameAccount}",
                            ),
                          ),
                          Container(
                            width: (deviceWidth(context) - 70) / 2,
                            child: buildDetailItem(
                              "Nominal",
                              formatRupiah
                                  .format(int.parse(data[index].nominal!)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 200,
                            child: buildDetailItem("Berita Transfer",
                                "${data[index].beritaTransfer} via $appName"),
                          ),
                          // Container(
                          //   width: (deviceWidth(context) - 70) / 2,
                          //   child: buildDetailItem("Biaya", "Rp 0"),
                          // ),
                        ],
                      ),
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: <Widget>[
                      //     Container(
                      //       width: (deviceWidth(context) - 70) / 2,
                      //       child: Container(),
                      //     ),
                      //     Container(
                      //       width: (deviceWidth(context) - 70) / 2,
                      //       child: buildDetailItem("Kode Unik", "Rp 0"),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
