part of '../widgets.dart';

Widget listHistoryRefund() {
  return Consumer<RefundProvider>(
    builder: (context, prov, _) {
      if (prov.listRequestRefund.isEmpty && prov.isListRequestRefundInit) {
        prov.getListRequestRefund(context, true);
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (prov.listRequestRefund.isEmpty &&
          prov.isListRequestRefundInit == false) {
        return LiquidPullToRefresh(
          color: primaryColor,
          onRefresh: () => prov.getListRequestRefund(context, true),
          showChildOpacityTransition: false,
          animSpeedFactor: 3.5,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              height: deviceHeight(context),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/no_data.png'),
                  Center(
                      child: Text('Belum ada permintaan pengembalian dana',
                          style: GoogleFonts.poppins())),
                ],
              ),
            ),
          ),
        );
      }
      return LiquidPullToRefresh(
        color: primaryColor,
        onRefresh: () => prov.getListRequestRefund(context, true),
        showChildOpacityTransition: false,
        animSpeedFactor: 3.5,
        child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shrinkWrap: false,
            itemCount: prov.listRequestRefund.length,
            physics: AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, i) {
              var d = prov.listRequestRefund[i];

              return InkWell(
                onTap: () {
                  Get.to(DetailRefundScreen(
                    d,
                  ));
                },
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    color: primaryColor,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //Text(tanggalWithTime(DateTime.now())),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: [
                                  Text(
                                    "Refund",
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                    size: 10,
                                  ),
                                  Text(
                                    "${d.bankName}",
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                      color: d.status == "on-process"
                                          ? Colors.orange
                                          : Colors.green,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Text(
                                    formatStatus(d.status!),
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ))
                            ],
                          ),
                          Text(
                            '${d.nameAccount}',
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${d.bankNumber}',
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                formatRupiah.format(d.refundNominal),
                                style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    color: textNominal,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ],
                      ),
                    )),
              );
            }),
      );
    },
  );
}
