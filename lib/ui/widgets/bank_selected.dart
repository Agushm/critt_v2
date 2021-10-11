part of 'widgets.dart';

void selectedBank(BuildContext context, {bool? isBankMethod}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext _) {
      return Consumer<TransaksiProvider>(builder: (context, prov, _) {
        if (prov.bankList == null) {
          return Text("Belum ada data bank");
        }
        return Container(
            height: deviceHeight(context) - 130,
            margin: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    width: 80,
                    height: 5,
                    decoration: BoxDecoration(color: primaryColor)),
                Container(
                    child: Text(
                  isBankMethod!
                      ? "Pilih Metode Pembayaran"
                      : "Pilih Bank Tujuan",
                  style: GoogleFonts.poppins(
                      fontSize: 18, fontWeight: FontWeight.w600),
                )),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: prov.searchBankController,
                    onChanged: (value) {
                      prov.changeFilterBankList(value);
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: "Masukan nama bank",
                        hintStyle:
                            GoogleFonts.poppins(fontWeight: FontWeight.w500),
                        labelStyle:
                            GoogleFonts.poppins(fontWeight: FontWeight.w500),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.grey[200]!))),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, i) {
                      return Divider();
                    },
                    shrinkWrap: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: prov.searchBankController.text.trim().length == 0
                        ? prov.bankList!.length
                        : prov.filterBankList.length,
                    itemBuilder: (context, i) {
                      var list =
                          prov.searchBankController.text.trim().length == 0
                              ? prov.bankList
                              : prov.filterBankList;
                      var b = list![i];
                      return InkWell(
                        onTap: () {
                          if (isBankMethod) {
                            prov.createTransaction(context, b);
                          } else if (!isBankMethod) {
                            prov.setSelectedBank(b, isBankMethod);
                            Get.back();
                          } else {
                            Get.back();
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            children: <Widget>[
                              CachedNetworkImage(
                                imageUrl: b.bankImage,
                                height: 30,
                                width: 100,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                b.bankName,
                                style: GoogleFonts.poppins(
                                    color: b.status != 'on'
                                        ? Colors.grey
                                        : Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                              Expanded(
                                child: Container(),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: b.status != 'on'
                                    ? Colors.grey
                                    : primaryColor,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ));
      });
    },
    isScrollControlled: true,
  );
}

class BankSelected extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
          child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text:
                      "Dengan memilih metode transfer, saya telah setuju dengan ",
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                  children: <TextSpan>[
                    TextSpan(
                      text: "Syarat & Ketentuan ",
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.red),
                    ),
                    TextSpan(text: "transaksi $appName"),
                  ])),
        ),
        Container(
            width: deviceWidth(context),
            margin: EdgeInsets.symmetric(horizontal: 10),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Text(
              "BAYAR VIA BANK TRANSFER",
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            )),
        ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 10),
          separatorBuilder: (context, i) {
            return Divider();
          },
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, i) {
            return InkWell(
              onTap: () {
                Get.back();
              },
              child: Row(
                children: <Widget>[
                  Image.asset(
                    "assets/images/bca.png",
                    height: 60,
                    width: 120,
                  ),
                  SizedBox(width: 20),
                  Text(
                    "Bank $i",
                    style: GoogleFonts.poppins(
                        fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  Expanded(child: Container()),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: primaryColor,
                  )
                ],
              ),
            );
          },
        )
      ],
    );
  }
}
