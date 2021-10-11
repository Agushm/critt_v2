part of 'widgets.dart';

Widget btnBantuan({Color? color}) {
  return InkWell(
    onTap: () => Get.to(FAQScreen()),
    child: Row(children: [
      Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
          decoration: BoxDecoration(
              color: Colors.orange[800],
              borderRadius: BorderRadius.circular(20)),
          child: Text(
            'Bantuan',
            style: GoogleFonts.poppins(
                fontSize: 10, color: Colors.white, fontWeight: FontWeight.w600),
          )),
      SizedBox(width: 3),
      SvgPicture.asset('assets/icons/help.svg',
          width: 25, height: 25, color: color ?? Colors.white),
    ]),
  );
}
