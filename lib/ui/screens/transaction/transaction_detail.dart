part of '../screens.dart';

class TransactionDetail extends StatelessWidget {
  final Transaction? data;
  TransactionDetail({this.data});
  final gradientColor = GradientTemplate.gradientTemplate[5].colors;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgGrey,
      body: Stack(
        children: [
          Consumer<TransaksiProvider>(
            builder: (context, prov, _) {
              return Screenshot(
                controller: prov.invoiceController,
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          children: [
                            Image.asset('assets/icons/logo.png',
                                width: 70, height: 70),
                            Text(
                              appName.toUpperCase(),
                              style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600),
                            ),
                            Expanded(child: SizedBox()),
                            Text(
                              'ID ${data!.invoiceNumber}',
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'Tanggal Transaksi',
                        style: GoogleFonts.poppins(
                            color: Colors.black54, fontWeight: FontWeight.w300),
                      ),
                      Text(
                        tanggalInvoice(data!.updatedAt!),
                        style: GoogleFonts.poppins(
                            color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 10),
                      Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: LineSeparator()),
                      Center(
                          child: Text(
                        'Transaksi Berhasil',
                        style: GoogleFonts.poppins(
                            color: Colors.black54, fontWeight: FontWeight.w300),
                      )),
                      Center(
                          child: Text(
                        formatRupiah.format(data!.nominalTransfer),
                        style: GoogleFonts.poppins(
                            fontSize: 25,
                            color: textNominal,
                            fontWeight: FontWeight.w500),
                      )),
                      Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: LineSeparator()),
                      ListView.separated(
                          padding: EdgeInsets.all(0),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, i) {
                            return buildReceiverDetail(data!.reciever![i]);
                          },
                          separatorBuilder: (context, i) {
                            return Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: LineSeparator());
                          },
                          itemCount: data!.reciever!.length),
                      Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: LineSeparator()),

                      SizedBox(height: 40),
                      Text(
                        'Kirim uang antar bank gratis tanpa biaya admin.',
                        style: GoogleFonts.poppins(
                            color: Colors.black54, fontWeight: FontWeight.w300),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/icons/logo.png',
                              width: 40, height: 40),
                          Text(
                            '${appName.toUpperCase()}',
                            style: GoogleFonts.poppins(
                                fontSize: 18,
                                color: primaryColor,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      Center(
                        child: Text(
                          'Transfer gratis kemana saja',
                          style: GoogleFonts.poppins(
                              color: Colors.black54,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: Image.asset(
                          'assets/icons/logo-playstore.png',
                          width: 100,
                        ),
                      ),
                      SizedBox(height: 20),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Image.asset('assets/icons/logo-BI.png',
                      //         width: 70, height: 70),
                      //     SizedBox(width: 10),
                      //     Container(
                      //         width: deviceWidth(context) - 120,
                      //         child: Text(
                      //           'Kegiatan transfer dana $appName diawasi dan terlisensi oleh Bank Indonesia',
                      //           style: GoogleFonts.poppins(
                      //               color: Colors.black54,
                      //               fontWeight: FontWeight.w300),
                      //         ))
                      //   ],
                      // ),
                    ],
                  ),
                ),
              );
            },
          ),
          SingleChildScrollView(
            child: Container(
              color: bgGrey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        width: deviceWidth(context),
                        height: deviceHeight(context) / 3.5,
                      ),
                      Container(
                        width: deviceWidth(context),
                        height: deviceHeight(context) / 3.5,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            gradient: LinearGradient(
                              colors: gradientColor,
                              end: Alignment.topCenter,
                              begin: Alignment.bottomCenter,
                            ),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    'assets/images/${data!.status == "on-progress" ? "process_bg.jpg" : data!.status == "failed" ? "failed_bg.jpg" : "bgHeader.jpg"}'))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                    child: Image.asset('assets/icons/logo.png',
                                        width: 60,
                                        height: 60,
                                        color: Colors.white)),
                                SizedBox(width: 10),
                                Text(
                                  formatStatusTransaksi(data!.status!),
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 25,
                        child: Container(
                          width: deviceWidth(context),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  child: Icon(
                                    Icons.arrow_back_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              Text(
                                'Detail Transaksi',
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Text(
                      "BUKTI TRANSFER",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  GestureDetector(
                    onTap: data!.status != "success"
                        ? null
                        : () {
                            Get.to(InvoiceScreen(data: data!));
                          },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  color: data!.status! == "on-progress"
                                      ? Color(0xfff6b735)
                                      : data!.status! == "failed"
                                          ? Colors.red
                                          : Color(0xff00BFB2)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    appName.toUpperCase(),
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text('ID ${data!.invoiceNumber!}',
                                      style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500))
                                ],
                              )),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Tanggal Transaksi",
                                  style: GoogleFonts.poppins(
                                      color: Colors.grey[600],
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  tanggalWithTime(data!.updatedAt!),
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300),
                                ),
                                _detailTransactionOnProgress(),
                                Divider(),
                                Center(
                                  child: Text(
                                    data!.status! != "success"
                                        ? "Total Transfer"
                                        : "Transaksi ${formatStatus2(data!.status!).toLowerCase()}",
                                    style: GoogleFonts.poppins(
                                        color: Colors.grey[600],
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    data!.status != "success"
                                        ? "${formatRupiah.format(data!.total)}"
                                        : "${formatRupiah.format(data!.nominalTransfer)}",
                                    style: GoogleFonts.poppins(
                                        color: textNominal,
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                data!.status != "on-progress"
                                    ? SizedBox()
                                    : Container(
                                        margin:
                                            EdgeInsets.only(top: 5, bottom: 5),
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.yellow.withOpacity(0.4),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        padding: EdgeInsets.only(
                                            left: 10,
                                            top: 10,
                                            right: 20,
                                            bottom: 10),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 5,
                                                      color: Colors.red
                                                          .withOpacity(0.5)),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          60)),
                                              child: Icon(
                                                Icons.info_outline,
                                                color: Colors.red,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Container(
                                                width: 200,
                                                child: Text(
                                                    "Pastikan anda transfer sesuai dengan total transfer ${formatRupiah.format(data!.total)}")),
                                          ],
                                        )),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  data!.status != "success"
                      ? SizedBox(
                          height: 20,
                        )
                      : Center(
                          child: Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MaterialButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: BorderSide(
                                        width: 2,
                                        color: primaryColor,
                                      ),
                                    ),
                                    onPressed: () async {
                                      Provider.of<TransaksiProvider>(context,
                                              listen: false)
                                          .downloadInvoice(context);
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.download_rounded,
                                            color: primaryColor),
                                        Text(
                                          "Unduh",
                                          style: GoogleFonts.poppins(
                                              fontSize: 18,
                                              color: primaryColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )),
                                SizedBox(width: 20),
                                MaterialButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: BorderSide(
                                        width: 2,
                                        color: primaryColor,
                                      ),
                                    ),
                                    onPressed: () async {
                                      Provider.of<TransaksiProvider>(context,
                                              listen: false)
                                          .shareInvoice(data!);
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.share, color: primaryColor),
                                        Text(
                                          "Bagikan",
                                          style: GoogleFonts.poppins(
                                              fontSize: 18,
                                              color: primaryColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ))
                              ],
                            ),
                          ),
                        ),
                  Container(
                    height: 15,
                    color: bgGrey,
                  ),
                  Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(color: Colors.white),
                      child: Row(
                        children: [
                          Text('ID TRANSAKSI ${data!.invoiceNumber}',
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                          SizedBox(
                            width: 5,
                          ),
                          btnSalin('${data!.invoiceNumber}', 'ID Transaksi')
                        ],
                      )),
                  Container(
                    height: 3,
                    color: bgGrey,
                  ),
                  detailReceiver(data),
                  Container(
                    height: 3,
                    color: bgGrey,
                  ),
                  // data.status == "success"
                  //     ? SizedBox()
                  //     : detailTransaction(data),
                  Container(
                    height: 3,
                    color: bgGrey,
                  ),
                  data!.status == "success"
                      ? SizedBox()
                      : HelperConfirmTransaction(
                          data,
                          isConfirmScreen: false,
                        ),
                  Container(
                    height: 15,
                    color: bgGrey,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 20),
                            child: Text(
                                "Bukti transfer juga sudah kami kirim ke emailmu.",
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300)),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: MaterialButton(
                              padding: EdgeInsets.all(15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: BorderSide(
                                  width: 2,
                                  color: primaryColor,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => IndexScreen()));
                              },
                              child: Text(
                                "Kembali Ke Beranda",
                                style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w500),
                              )),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          width: double.infinity,
                          child: MaterialButton(
                              padding: EdgeInsets.all(15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: BorderSide(
                                  width: 2,
                                  color: primaryColor,
                                ),
                              ),
                              color: primaryColor,
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => KirimUangScreen()));
                              },
                              child: Text(
                                "SAYA INGIN KIRIM UANG LAGI",
                                style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailTransactionOnProgress() {
    return data!.status != 'on-progress'
        ? SizedBox()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "Transfer",
                style: GoogleFonts.poppins(
                    color: Colors.grey[600],
                    fontSize: 13,
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '${data!.bankCrittName}',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w300),
              ),
              Text(
                'a/n ${data!.bankCrittAtasNama}',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w300),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${data!.bankCrittNumber}',
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 16,
                        letterSpacing: 3,
                        fontWeight: FontWeight.w300),
                  ),
                  btnSalin(data!.bankCrittNumber, ''),
                ],
              ),
            ],
          );
  }
}
