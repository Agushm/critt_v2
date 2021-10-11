part of '../screens.dart';
class TransactionScreen extends StatelessWidget {
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();

  Future<void> refresh(BuildContext context)async{
    return Provider.of<TransaksiProvider>(context,listen:false).getListTransaction(context,true);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgGrey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          "Transaksi",
          style: appBarStyle,
        ),
      ),
      body: LiquidPullToRefresh(
        color: primaryColor,
        key: _refreshIndicatorKey,
        onRefresh: ()=>refresh(context),
        showChildOpacityTransition: false,
        animSpeedFactor: 3.5,
        child: listTransaction(isLastTransaction: false))
    );
  }
}
