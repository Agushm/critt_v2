part of '../widgets.dart';

class InvoiceDialog extends StatelessWidget {
  final String? title;
  final Transaction? data;
  final String? clickText;

  final Function()? onClickOK;
  final Function()? onClickCancel;

  InvoiceDialog(
      {@required this.title,
      @required this.data,
      @required this.onClickOK,
      this.onClickCancel,
      this.clickText = "OK"});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Center(
        child: Text('Transaksi',
            style:
                GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          detailItem('ID Transaksi', data!.invoiceNumber!),
          detailItem('Nominal', formatRupiah.format(data!.nominalTransfer!)),
          detailItem('Status', formatStatus(data!.status!)),
          SizedBox(
            height: 5,
          ),
          Container(
            width: double.infinity,
            child: Row(
              children: [
                Text('${data!.bankCrittName!}',
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500)),
                Icon(
                  Icons.arrow_forward,
                  size: 15,
                ),
                Text('${data!.reciever!.map((e) => e.bankName)}',
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
      actions: <Widget>[
        onClickCancel != null
            ? MaterialButton(
                onPressed: () => onClickCancel!(),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  "Tutup",
                  style: TextStyle(
                      color: primaryColor, fontWeight: FontWeight.w600),
                ),
              )
            : SizedBox(),
        MaterialButton(
          color: primaryColor,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          onPressed: () => onClickOK!(),
          child: Text(
            clickText!,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

Widget detailItem(String title, String detail) {
  return Container(
    margin: EdgeInsets.only(bottom: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 100,
          child: Text('$title',
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500)),
        ),
        Text('$detail',
            style: GoogleFonts.poppins(
                color: colorStatusTransaction(detail),
                fontSize: 14,
                fontWeight: FontWeight.w300)),
      ],
    ),
  );
}
