part of '../screens.dart';

class FAQScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgGrey,
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: bgGrey,
          leading: IconButton(
              color: Colors.black,
              icon: Icon(Icons.close),
              onPressed: () => Get.back()),
          title: Text("Bantuan",
              style: GoogleFonts.poppins(
                  color: Colors.black, fontWeight: FontWeight.w600))),
      body: Column(
        children: [
          Image.asset('assets/images/faq.png'),
          menuItemFAQ(context, 'Salah nominal transfer/lupa masukkan kode unik',
              onTap: () => Get.to(RefundHelperScreen())),
          menuItemFAQ(context, 'Transaksi uang lama/belum sampai ke tujuan',
              onTap: () => Get.to(Refund2HelperScreen())),
          menuItemFAQ(context, 'Cara lakukan refund',
              onTap: () => Get.to(RefundHelperScreen())),
          SizedBox(height: 20),
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: InkWell(
                onTap: () {
                  Get.to(MoreFAQScreen());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Lihat masalah lainnya',
                        style: GoogleFonts.poppins(color: primaryColor)),
                    SizedBox(width: 10),
                    Icon(Icons.arrow_forward_ios, color: primaryColor)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget menuItemFAQ(BuildContext context, String title, {Function()? onTap}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black54, width: 0.5),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)),
      child: InkWell(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  width: deviceWidth(context) - (deviceWidth(context) / 3.5),
                  child: Text(title, style: GoogleFonts.poppins())),
              Icon(Icons.arrow_forward_ios, color: primaryColor)
            ],
          )),
    );
  }
}
