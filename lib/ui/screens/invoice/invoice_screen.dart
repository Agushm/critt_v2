part of '../screens.dart';

class InvoiceScreen extends StatefulWidget {
  final Transaction? data;
  InvoiceScreen({this.data});
  @override
  _InvoiceScreenState createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Screenshot(
            controller: screenshotController,
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
                          '${appName.toUpperCase()}',
                          style: GoogleFonts.poppins(
                              fontSize: 20,
                              color: primaryColor,
                              fontWeight: FontWeight.w600),
                        ),
                        Expanded(child: SizedBox()),
                        Text(
                          'ID ${widget.data!.invoiceNumber!}',
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Waktu Terkirim',
                    style: GoogleFonts.poppins(
                        color: Colors.black54, fontWeight: FontWeight.w300),
                  ),
                  Text(
                    '${tanggalInvoice(widget.data!.updatedAt!)}',
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
                    '${formatRupiah.format(widget.data!.nominalTransfer!)}',
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
                        return buildReceiverDetail(widget.data!.reciever![i]);
                      },
                      separatorBuilder: (context, i) {
                        return Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: LineSeparator());
                      },
                      itemCount: widget.data!.reciever!.length),
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: LineSeparator()),
                  SizedBox(height: 20),
                  Text(
                    'Berita Transfer',
                    style: GoogleFonts.poppins(
                        color: Colors.black54, fontWeight: FontWeight.w300),
                  ),
                  Text('${widget.data!.reciever![0].beritaTransfer!}'),
                  SizedBox(height: 60),
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
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                      screenshotController
                          .capture(
                              pixelRatio: 2.0,
                              delay: Duration(milliseconds: 10))
                          .then((image) async {
                        File _image = File.fromRawPath(image!);
                        await ImageGallerySaver.saveFile(_image.path);
                        DialogUtils.instance.showInfo(
                            context,
                            'Gambar berhasil disimpan di gallery',
                            Icons.info,
                            'OK',
                            onClick: () => Get.back());
                      }).catchError((onError) {
                        print(onError);
                      });
                    },
                    child: Row(
                      children: [
                        Icon(Icons.download_rounded, color: primaryColor),
                        Text(
                          "Unduh",
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
                MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        width: 2,
                        color: primaryColor,
                      ),
                    ),
                    onPressed: () async {
                      screenshotController
                          .capture(
                              pixelRatio: 2.5,
                              delay: Duration(milliseconds: 10))
                          .then((image) async {
                        File _image = File.fromRawPath(image!);
                        Share.shareFiles([_image.path],
                            text:
                                '${widget.data!.invoiceNumber}\n\n${appName.toUpperCase()}\nTransfer uang antar bank gratis tanpa biaya admin.');
                      }).catchError((onError) {
                        print(onError);
                      });
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
        ],
      ),
    ));
  }
}

Widget buildReceiverDetail(Reciever receiver) {
  return Column(children: [
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Nama Penerima',
          style: GoogleFonts.poppins(
              fontSize: 13, color: Colors.black54, fontWeight: FontWeight.w300),
        ),
        Text(
          '${receiver.nameAccount}',
          style: GoogleFonts.poppins(
              fontSize: 12, color: Colors.black, fontWeight: FontWeight.w500),
        )
      ],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Bank Penerima',
          style: GoogleFonts.poppins(
              fontSize: 13, color: Colors.black54, fontWeight: FontWeight.w300),
        ),
        Text(
          '${receiver.bankName}',
          style: GoogleFonts.poppins(
              fontSize: 12, color: Colors.black, fontWeight: FontWeight.w500),
        )
      ],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Nomor Rekening',
          style: GoogleFonts.poppins(
              fontSize: 13, color: Colors.black54, fontWeight: FontWeight.w300),
        ),
        Text(
          '${receiver.bankNumber}',
          style: GoogleFonts.poppins(
              fontSize: 12, color: Colors.black, fontWeight: FontWeight.w500),
        )
      ],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Nominal Transfer',
          style: GoogleFonts.poppins(
              fontSize: 13, color: Colors.black54, fontWeight: FontWeight.w300),
        ),
        Text(
          formatRupiah.format(int.parse(receiver.nominal!)),
          style: GoogleFonts.poppins(
              fontSize: 12, color: Colors.black, fontWeight: FontWeight.w500),
        )
      ],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Berita Transfer',
          style: GoogleFonts.poppins(
              fontSize: 13, color: Colors.black54, fontWeight: FontWeight.w300),
        ),
        Text(
          '${receiver.beritaTransfer}',
          style: GoogleFonts.poppins(
              fontSize: 12, color: Colors.black, fontWeight: FontWeight.w500),
        )
      ],
    ),
  ]);
}
