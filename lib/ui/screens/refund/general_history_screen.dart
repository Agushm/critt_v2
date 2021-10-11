part of '../screens.dart';

class GeneralHistoryScreen extends StatelessWidget {
  final String type;
  GeneralHistoryScreen(this.type);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgGrey,
      appBar: AppBar(
        leading: IconButton(
              color: Colors.white,
              icon: Icon(Icons.arrow_back_rounded),
              onPressed: () => Get.back()),
        elevation: 0,
        title: Text(
          type == "withdraw" ?"Penarikan Saldo":"Pengembalian Dana",
          style: appBarStyle,
        ),
      ),
      body: type == "withdraw" ?listHistoryWithdraw():listHistoryRefund()
    );
  }
}
