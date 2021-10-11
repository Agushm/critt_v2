part of '../screens.dart';

class Refund2HelperScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GeneralHelperScreen(
      body: Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Transaksi uang prosesnya lama/belum sampai ke tujuan',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
            SizedBox(height: 5),
            Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.yellow[100],
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                    'Pastikan nominal yang kamu transfer ke rekening $appName sesuai dengan nominal yang ada pada transaksimu',
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.poppins())),
            Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                    'Jika nominal yang kamu transfer tidak sesuai, silakan lakukan refund.',
                    style: GoogleFonts.poppins())),
            SizedBox(height: 10),
            RichText(
              text: TextSpan(
                  text: 'Pelajari lebih lanjut: ',
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.black54,
                      fontWeight: FontWeight.w500),
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.to(RefundHelperScreen()),
                      text: 'Salah nominal transfer/lupa masukkan kode unik',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ]),
            ),
            SizedBox(height: 10),
            RichText(
              textAlign:TextAlign.justify,
              text: TextSpan(
                  text:
                      'Apabila nominal yang kamu transfer sudah sesuai, silakan ',
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                      
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.to(RefundHelperScreen()),
                      text:
                          'refresh secara berkala halaman proses transaksi atau halaman beranda.\n\n',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(text:'Proses transaksi yang lama/belum sampai saat ini juga dapat disebabkan oleh gangguan pada sistem bank(baik bank pengirim ataupun bank tujuan).\n\n'),
                    TextSpan(text:'Jika terdapat gangguan bank ringan, silakan menunggu dan transaksi akan diproses otomatis saat sistem bank sudah kembali normal.\n\n'),
                    TextSpan(text:'Namun, jika terdapat gangguan berat dan kamu ingin membatalkan transaksi, silakan hubungi tim $appName via chat bantuan. Kami akan melakukan pengecekan, dan jika transaksi dapat dibatalkan, silakan lakukan refund.')
                  ]),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
