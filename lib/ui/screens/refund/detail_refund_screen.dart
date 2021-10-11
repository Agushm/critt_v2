part of '../screens.dart';

class DetailRefundScreen extends StatelessWidget {
  final RequestRefund? data;
  DetailRefundScreen(this.data);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            color: Colors.black,
            icon: Icon(Icons.close)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Pengembalian Dana',
          style: GoogleFonts.poppins(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: bgGrey,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      "BUKTI PENGEMBALIAN DANA",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          color: data!.status == "on-progress" ||
                                  data!.status == "on-process"
                              ? Color(0xfff6b735)
                              : data!.status == "rejected"
                                  ? Colors.red
                                  : Color(0xff00BFB2)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            appName.toUpperCase(),
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w800),
                          ),
                          Text('ID-REFUND ${data!.id}',
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800))
                        ],
                      )),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Tujuan Pengiriman",
                              style: GoogleFonts.poppins(
                                  color: Colors.grey[600],
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                decoration: BoxDecoration(
                                    color: data!.status == "on-process"
                                        ? Colors.orange
                                        : Colors.green,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text(
                                  formatStatus(data!.status!),
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ))
                          ],
                        ),
                        Text(
                          '${data!.bankName}',
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w800),
                        ),
                        Text(
                          '${data!.nameAccount}',
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '${data!.bankNumber!}',
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 10),
                        Text(
                          data!.status == "success"
                              ? "Waktu Terkirim"
                              : "Waktu Dibuat",
                          style: GoogleFonts.poppins(
                              color: Colors.grey[600],
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${tanggalWithTime(data!.updatedAt!)}',
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w800),
                        ),
                        Divider(),
                        Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "${formatRupiah.format(data!.refundNominal!)}",
                              style: GoogleFonts.poppins(
                                  color: textNominal,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            data!.status != "success"
                ? SizedBox(
                    height: 20,
                  )
                : Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                            onPressed: () {},
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
                        MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                width: 2,
                                color: primaryColor,
                              ),
                            ),
                            onPressed: () {},
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
            Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Alasan Pengembalian Dana',
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w800),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '${data!.reason}',
                      style: GoogleFonts.poppins(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                  ],
                )),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                decoration: BoxDecoration(color: Colors.white),
                child: showReceipt(
                    "Bukti Transfer ke $appName", data!.userTransferReceipt!)),
            data!.status == "success"
                ? Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    decoration: BoxDecoration(color: Colors.white),
                    child: showReceipt("Bukti Transfer dari $appName",
                        data!.crittTransferReceipt))
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
