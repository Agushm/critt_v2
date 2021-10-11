part of '../screens.dart';

class ConfirmTransactionScreen extends StatefulWidget {
  final Transaction? data;
  ConfirmTransactionScreen({this.data});
  @override
  _ConfirmTransactionScreenState createState() =>
      _ConfirmTransactionScreenState();
}

class _ConfirmTransactionScreenState extends State<ConfirmTransactionScreen> {
  Timer? _timer;
  int _start = 600;
  @override
  void initState() {
    startTimer();
    super.initState();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            DialogUtils.instance.showInfo(
                context,
                "Transaksi Belum Selesai?\nSilahkan upload bukti transfer",
                Icons.info_outline,
                "Upload Bukti Transfer", onClick: () {
              Get.back();
            });
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            color: Colors.white,
            icon: Icon(Icons.close),
            iconSize: 30,
            onPressed: () {
              Get.offAll(IndexScreen());
            }),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Sedang Diproses",
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text('$appName sedang melakukan pengecekan',
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w300)),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 20),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                color: primaryColor.withOpacity(0.1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Waktu Pengecekan Transaksi',
                        style: GoogleFonts.poppins(
                            fontSize: 18, fontWeight: FontWeight.w700)),
                    Text(printDurationMinuteSeconds(Duration(seconds: _start)),
                        style: GoogleFonts.poppins(
                            color: textNominal,
                            fontSize: 40,
                            fontWeight: FontWeight.w500)),
                    Text('Menit     Detik',
                        style: GoogleFonts.poppins(
                            fontSize: 14, fontWeight: FontWeight.w500)),
                    SizedBox(height: 20),
                    Text(
                        'Setelah dana diterima oleh $appName, maka transaksi akan diproses instan.',
                        style: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.w500))
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Text('ID TRANSAKSI ${widget.data!.invoiceNumber!}',
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                      SizedBox(
                        width: 5,
                      ),
                      btnSalin(
                          '${widget.data!.invoiceNumber!}', 'ID Transaksi'),
                    ],
                  )),
              detailTransaction(widget.data!),
              HelperConfirmTransaction(
                widget.data,
                isConfirmScreen: true,
              ),
              SizedBox(height: 200),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
          color: Colors.white,
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text(
                'Sambil menunggu transaksimu selesai ajak temanmu memakai $appName juga yuk'),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              child: MaterialButton(
                  color: primaryColor,
                  padding: EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  onPressed: () {
                    Share.share(
                        'Kirim uang lewat $appName mudah,cepat dan tidak kena biaya transfer',
                        subject: 'Kemahalan biaya transfer beda bank?');
                  },
                  child: Text('Ajak Teman',
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500))),
            )
          ])),
    );
  }
}
