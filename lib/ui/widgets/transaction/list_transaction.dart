part of '../widgets.dart';

Widget listTransaction({bool? isLastTransaction}) {
  return Consumer<TransaksiProvider>(
    builder: (context, prov, _) {
      if (prov.listTransaksi.isEmpty && prov.getTransactionInit == false) {
        prov.getListTransaction(context, true);
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (prov.listTransaksi.isEmpty && prov.getTransactionInit == true) {
        return isLastTransaction!
            ? Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/no_data.png', height: 100),
                    Center(
                        child: Text('Belum ada transaksi',
                            style: GoogleFonts.poppins())),
                  ],
                ),
              )
            : SingleChildScrollView(
                child: Container(
                  height: deviceHeight(context) - 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/no_data.png'),
                      Center(
                          child: Text('Belum ada transaksi',
                              style: GoogleFonts.poppins())),
                    ],
                  ),
                ),
              );
      } else {
        return ListView.builder(
            padding: isLastTransaction!
                ? EdgeInsets.all(0)
                : EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shrinkWrap: isLastTransaction ? true : false,
            itemCount: isLastTransaction
                ? prov.listTransaksi.length > 5
                    ? 5
                    : prov.listTransaksi.length
                : prov.listTransaksi.length + (prov.loadingTransaction ? 1 : 0),
            physics: isLastTransaction
                ? NeverScrollableScrollPhysics()
                : AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, i) {
              if (i ==
                      prov.listTransaksi.length -
                          prov.itemTransactionThreshold &&
                  prov.isLoadMore == true) {
                prov.getListTransaction(context, false);
              }
              if (i == prov.listTransaksi.length &&
                  prov.loadingTransaction == true) {
                return Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: CircularProgressIndicator(),
                ));
              } else {
                Transaction d = prov.listTransaksi[i];

                return InkWell(
                  onTap: () {
                    if (d.status == 'on-progress') {
                      Get.to(KonfirmasiKirimUang(
                        data: d,
                      ));
                    } else {
                      Get.to(TransactionDetail(
                        data: d,
                      ));
                    }
                  },
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      color: Colors.white,
                      elevation: 0,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: [
                                Container(
                                  constraints: BoxConstraints(
                                    maxWidth: 100,
                                  ),
                                  child: Text('${d.bankCrittName}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(
                                          fontSize: 13,
                                          color: d.status == 'failed'
                                              ? Colors.black45
                                              : Colors.black,
                                          fontWeight: FontWeight.w500)),
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: d.status == 'failed'
                                      ? Colors.black45
                                      : Colors.black,
                                  size: 15,
                                ),
                                Container(
                                  constraints: BoxConstraints(
                                    maxWidth: 100,
                                  ),
                                  child: Text(
                                      d.reciever!.length == 1
                                          ? '${d.reciever![0].bankName}'
                                          : '${d.reciever!.length} tujuan',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(
                                          color: d.status == 'failed'
                                              ? Colors.black45
                                              : Colors.black,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500)),
                                ),
                                Expanded(child: SizedBox()),
                                Text(
                                  formatRupiah.format(d.nominalTransfer),
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: d.status == 'failed'
                                          ? Colors.black45
                                          : Colors.black,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            d.reciever!.length == 1
                                ? Text(
                                    'sdr ${d.reciever![0].nameAccount}',
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: d.status == 'failed'
                                            ? Colors.black45
                                            : Colors.black,
                                        fontWeight: FontWeight.w300),
                                  )
                                : SizedBox(),
                            Row(
                              children: [
                                Text(
                                  tanggal(d.updatedAt!),
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: d.status == 'failed'
                                          ? Colors.black45
                                          : Colors.black,
                                      fontWeight: FontWeight.w300),
                                ),
                                Expanded(child: SizedBox()),
                                Text(
                                  formatStatus(d.status!),
                                  style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      color: colorStatusTransaction(d.status!),
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ],
                        ),
                      )),
                );
              }
            });
      }
    },
  );
}
