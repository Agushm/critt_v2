part of '../widgets.dart';

Widget listLastReceiver(bool isLimited) {
  return Consumer<TransaksiProvider>(
    builder: (context, prov, _) {
      if (prov.listReceiver.isEmpty && prov.isListReceiverInit) {
        prov.getListReceiver(context, true);
        return LinearProgressIndicator();
      }
      if (prov.listReceiver.isEmpty && prov.isListReceiverInit == false) {
        return Container();
      }
      return Column(
        children: [
          ListView.builder(
            padding: EdgeInsets.all(0),
            shrinkWrap: true,
            itemCount: isLimited && prov.listReceiver.length > 3
                ? 3
                : prov.listReceiver.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, i) {
              var d = prov.listReceiver[i];
              return ListTile(
                onTap: () {
                  prov.setPenerima(context, d.nameAccount!, d.bankNumber!,
                      r: d);
                  if (isLimited == false) {
                    Get.back();
                  }
                },
                contentPadding: EdgeInsets.all(0),
                title: Text('${d.nameAccount}'),
                subtitle: Text('${d.bankNumber}'),
                trailing: CachedNetworkImage(
                  imageUrl: d.bankLogo!,
                  height: 30,
                  width: 100,
                ),
              );
            },
          ),
          isLimited
              ? InkWell(
                  onTap: () {
                    Get.to(LastReceiverScreen());
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Lihat lebih banyak',
                      style: GoogleFonts.poppins(
                          color: primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                )
              : SizedBox(),
        ],
      );
    },
  );
}
