part of '../screens.dart';

class LastReceiverScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                color: Colors.white,
                icon: Icon(Icons.arrow_back_rounded),
                onPressed: () => Get.back()),
            title: Text('Penerima sebelumnya', style: appBarStyle)),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text("Tekan untuk membuat transaksi baru",
                      style: GoogleFonts.poppins(color: Colors.white))),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: listLastReceiver(false)),
            ],
          ),
        ));
  }
}
