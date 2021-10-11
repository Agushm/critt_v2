part of '../widgets.dart';

Widget btnRequestRefund() {
  return Container(
    width: 150,
    alignment: Alignment.center,
    child: MaterialButton(
        onPressed: () {
          Get.to(RequestRefundScreen());
        },
        child: Row(
          children: [
            Icon(Icons.undo_rounded, color: primaryColor),
            SizedBox(width: 5),
            Text("Buat Refund",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500, fontSize: 14))
          ],
        )),
  );
}
