part of '../screens.dart';

class BerandaScreen extends StatefulWidget {
  @override
  _BerandaScreenState createState() => _BerandaScreenState();
}

class _BerandaScreenState extends State<BerandaScreen> {
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();

  Future<void> refresh() async {
    Provider.of<AuthProvider>(context, listen: false).getUser(context);
    Provider.of<TransaksiProvider>(context, listen: false)
        .getListTransaction(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgGrey,
      body: LiquidPullToRefresh(
        color: primaryColor,
        key: _refreshIndicatorKey,
        onRefresh: refresh,
        showChildOpacityTransition: false,
        animSpeedFactor: 3.5,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: <Widget>[
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    width: deviceWidth(context),
                    height: (deviceHeight(context) / 3) + 25,
                  ),
                  Positioned(top: 0, child: HeaderBeranda()),
                  Positioned(bottom: 0, child: _cardSaldo(context)),
                ],
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    cardVerified(),
                    menuList(context),
                    Consumer<TransaksiProvider>(builder: (context, prov, _) {
                      if (prov.listTransaksi.length > 0) {
                        return Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 25, vertical: 10),
                          child: Text(
                            "Transaksi Terbaru",
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: primaryColor,
                                fontWeight: FontWeight.w600),
                          ),
                        );
                      }
                      return SizedBox();
                    }),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: listTransaction(isLastTransaction: true)),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _cardSaldo(BuildContext context) {
  return Consumer<AuthProvider>(builder: (context, prov, _) {
    return Container(
      width: deviceWidth(context) - 40,
      child: Card(
        elevation: 5,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("SALDO",
                  style: GoogleFonts.poppins(
                      fontSize: 18, fontWeight: FontWeight.w400)),
              SizedBox(
                width: 5,
              ),
              InkWell(
                  onTap: () {
                    DialogUtils.instance.showInfo(
                        context,
                        "Kode unik setiap transaksimu dikonversikan menjadi saldo.",
                        Icons.info,
                        "OK");
                  },
                  child:
                      Icon(Icons.info_outline, size: 15, color: primaryColor)),
              Expanded(
                child: SizedBox(),
              ),
              Text("${formatRupiah.format(prov.user!.saldo ?? 0)}",
                  style: GoogleFonts.poppins(
                      color: textNominal,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  });
}

Widget gradient() {
  var gradientColor = GradientTemplate.gradientTemplate[0].colors;
  return Container(
      margin: const EdgeInsets.only(bottom: 32),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColor,
          begin: Alignment.centerLeft,
          end: Alignment.centerLeft,
        ),
        boxShadow: [
          BoxShadow(
            color: gradientColor.last.withOpacity(0.4),
            blurRadius: 8,
            spreadRadius: 2,
            offset: Offset(4, 4),
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ));
}

Widget menuList(BuildContext context) {
  return Container(
    padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
    child: Column(
      children: [
        MaterialButton(
            padding: EdgeInsets.symmetric(vertical: 10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
            color: primaryColor,
            onPressed: () {
              Provider.of<TransaksiProvider>(context, listen: false)
                  .resetPenerima();
              Get.to(KirimUangScreen());
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/icons/send.svg",
                    height: 30, color: Colors.white),
                SizedBox(width: 10),
                Text(
                  'Kirim Uang Gratis',
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              ],
            )),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            // btnMenuItem(context,
            //     title: "Kirim\nUang",
            //     src: "assets/icons/send.svg", function: () {
            //   Provider.of<TransaksiProvider>(context, listen: false)
            //       .resetPenerima();
            //   Get.to(KirimUangScreen());
            // }),
            btnMenuItem(context,
                title: "Penarikan\nSaldo",
                src: "assets/icons/refund.svg", function: () {
              showMenuWithdraw(context);
            }),
            btnMenuItem(context,
                title: "Refund\n", src: "assets/icons/send.svg", function: () {
              showMenuRefund(context);
            })
          ],
        ),
      ],
    ),
  );
}

Widget btnMenuItem(BuildContext context,
    {String? title, String? src, Function()? function}) {
  return Container(
    width: (deviceWidth(context) - 60) / 2,
    child: MaterialButton(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        padding: EdgeInsets.symmetric(vertical: 10),
        elevation: 5,
        onPressed: function,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SvgPicture.asset(
              src!,
              color: primaryColor,
              height: 30,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              title!,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 12,
              ),
            )
          ],
        )),
  );
}
