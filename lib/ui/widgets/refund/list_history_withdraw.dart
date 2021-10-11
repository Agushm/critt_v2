part of '../widgets.dart';

Widget listHistoryWithdraw() {
  return Consumer<TransaksiProvider>(
    builder: (context, prov, _) {
      if (prov.withdraw.isEmpty && prov.isWithdrawInit == false) {
        prov.getWithdraw(context,true);
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (prov.withdraw.isEmpty && prov.isWithdrawInit == true){
          return Container(
          height: deviceHeight(context),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/no_data.png'),
              Center(child: Text('Belum ada permintaan penarikan saldo',style:GoogleFonts.poppins())),
            ],
          ),
        );
      }
      return RefreshIndicator(
        onRefresh: (){
          return prov.getWithdraw(context,true);
        },
              child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal:20,vertical:10),
            shrinkWrap: false,
            itemCount:  prov.withdraw.length,
            physics:  AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, i) {
              Withdraw d = prov.withdraw[i];
              return InkWell(
                onTap: () {
                  // Get.to(TransactionDetail(
                  //   data: d,
                  // ));
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
                              Text(
                                "Withdraw",
                                style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Text(
                                    d.status.toString(),
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ))
                            ],
                          ),
                          Text(
                            '${d.bankName}',
                            style: GoogleFonts.poppins(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            formatRupiah.format(d.withdrawNominal),
                            style: GoogleFonts.poppins(
                                fontSize: 18,
                                color: textNominal,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    )),
              );
            }),
      );
    },
  );
}
