part of '../widgets.dart';

Widget detailReceiver(Transaction? data) {
  return Container(
    decoration: BoxDecoration(color: Colors.white),
    child: ExpansionTile(
      childrenPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      title: Text('DETAIL TRANSAKSI',
          style: GoogleFonts.poppins(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500)),
      children: <Widget>[
        Row(
          children: [
            Container(
              constraints: BoxConstraints(
                maxWidth: 130,
              ),
              child: Text('${data!.bankCrittName}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
            ),
            Icon(
              Icons.arrow_forward,
              size: 28,
            ),
            Container(
              constraints: BoxConstraints(
                maxWidth: 130,
              ),
              child: Text('${data.reciever!.map((e) => e.bankName)}',
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
            ),
          ],
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('PENERIMA',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500)),
            Text('NOMINAL',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500)),
          ],
        ),
        Column(
            children: data.reciever!
                .map((e) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Text('${e.nameAccount}',
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300)),
                            Text('${e.bankNumber}',
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w300)),
                          ],
                        ),
                        Text(formatRupiah.format(int.parse(e.nominal!)),
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w300)),
                      ],
                    ))
                .toList()),
        SizedBox(height: 5),
        data.status == 'success'
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('KODE UNIK',
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500)),
                  Text(formatRupiah.format(int.parse(data.uniqueCode!)),
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w300)),
                ],
              )
            : SizedBox(),
        SizedBox(
          height: 10,
        ),
      ],
    ),
  );
}
