part of '../screens.dart';

class KonfirmasiKirimUang extends StatelessWidget {
  final Transaction? data;
  KonfirmasiKirimUang({this.data});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
          color: Colors.white,
        ),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Kirim Uang",
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: Consumer<TransaksiProvider>(
        builder: (context, prov, _) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  color: bgGrey,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    children: <Widget>[
                      Text(
                          "LAKUKAN TRANSFER KE REKENING ${appName.toUpperCase()}"),
                      Icon(
                        Icons.info_outline,
                        color: Colors.grey[400],
                        size: 20,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          width: 100,
                          height: 50,
                          child: CachedNetworkImage(
                            imageUrl: data!.bankCrittImage!,
                          )),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: <Widget>[
                          Text(data!.bankCrittName!),
                          Text(data!.bankCrittAtasNama!)
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8), color: bgGrey),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        data!.bankCrittNumber!,
                        style: GoogleFonts.poppins(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      btnSalin('${data!.bankCrittNumber!}',
                          'Nomor Rekening $appName')
                    ],
                  ),
                ),
                Divider(),
                _detailItem("Nominal Transfer",
                    "${formatRupiah.format(data!.nominalTransfer)}"),
                _detailItem("Admin",
                    "${formatRupiah.format(int.parse(data!.feeCritt!))}"),
                _detailItem("Kode Unik", "${data!.uniqueCode}"),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Total Transfer",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                _buildTotalNominal(data!),
                SizedBox(
                  height: 10,
                ),
                Container(
                    width: deviceWidth(context),
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.yellow.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.only(
                        left: 10, top: 10, right: 20, bottom: 10),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 5, color: Colors.red.withOpacity(0.5)),
                              borderRadius: BorderRadius.circular(60)),
                          child: Icon(
                            Icons.info_outline,
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                            width: deviceWidth(context) -
                                (deviceWidth(context) / 3),
                            child: Text(
                                "Pastikan nominal sesuai hingga 3 digit terakhir")),
                      ],
                    )),
                Divider(),
                _labelBatasTransfer(data!),
                buildGarisPemisah(context, height: 20),
                DetailTransaksiCard(data!),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: Container(
        width: deviceWidth(context),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        color: Colors.white,
        child: MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.symmetric(vertical: 10),
            color: primaryColor,
            onPressed: () {
              Get.off(ConfirmTransactionScreen(
                data: data!,
              ));
            },
            child: Text(
              "SUDAH TRANSFER?",
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

Widget _detailItem(String title, String content) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    child: Row(
      children: <Widget>[
        Text(
          title,
          style: GoogleFonts.poppins(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
        ),
        Expanded(child: Container()),
        Text(
          content,
          style: GoogleFonts.poppins(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
        )
      ],
    ),
  );
}

Widget _buildTotalNominal(Transaction d) {
  String total = formatRupiah.format(d.total);

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 20),
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(8), color: bgGrey),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        RichText(
            text: TextSpan(
                text: total,
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
                children: <TextSpan>[
              // TextSpan(
              //   text: "177",
              //   style: GoogleFonts.poppins(
              //       backgroundColor: Colors.yellow,
              //       fontSize: 25,
              //       fontWeight: FontWeight.bold),
              // ),
            ])),
        btnSalin('$total', 'Total Transfer'),
      ],
    ),
  );
}

Widget _labelBatasTransfer(Transaction t) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: RichText(
        text: TextSpan(children: <TextSpan>[
      TextSpan(
          text: "Transfer sebelum ",
          style: GoogleFonts.poppins(fontSize: 14, color: Colors.black)),
      TextSpan(
          text: "${tanggalWithTime(t.updatedAt!)} WIB",
          style: GoogleFonts.poppins(
              fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold)),
      TextSpan(
          style: GoogleFonts.poppins(fontSize: 14, color: Colors.black),
          text: " atau transaksimu akan dibatalkan otomatis oleh sistem."),
    ])),
  );
}
