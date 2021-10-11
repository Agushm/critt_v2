part of '../screens.dart';
class HistoryWithdrawScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgGrey,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Penarikan Saldo",
          style: appBarStyle,
        ),
      ),
      body: listHistoryWithdraw()
    );
  }
}
