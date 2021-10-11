part of '../screens.dart';

class RefundHelperScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GeneralHelperScreen(
      body:Container(
        margin:EdgeInsets.only(top:10),
        padding:EdgeInsets.symmetric(horizontal:20,vertical:15),
        color:Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize:MainAxisSize.min,
          children: [
            Text('Cara lakukan refund',style:GoogleFonts.poppins(
              fontWeight:FontWeight.w600
            )),
            SizedBox(height:5),
            Container(
              margin:EdgeInsets.symmetric(vertical:15),
              padding:EdgeInsets.all(15),
              decoration: BoxDecoration(
                color:Colors.yellow[100],
                borderRadius: BorderRadius.circular(10)
              ),
              child: Text('Refund tidak dapat dilakukan untuk transaksi yang sedang atau sudah berhasil diproses oleh $appName',textAlign:TextAlign.justify,style:GoogleFonts.poppins())),
            Container(
              margin:EdgeInsets.symmetric(vertical:5),
              child: Text('Silakan lakukan refund jika:',style:GoogleFonts.poppins())),
            dottedText(context,'Nominal transaksi tidak sesuai/lupa memasukan kode unik.'),
            dottedText(context,'Transaksi dibatalkan otomatis oleh sistem.'),
            dottedText(context,'Transaksi dibatalkan otomatis oleh sistem.'),
            SizedBox(height:20),
            Text('Pastikan nominal yang kamu refund, sesuai dengan nominal yang kamu transfer ke rekening $appName. $appName tidak dapat memproses refund jika nominal refund dan nominal yang kamu transfer tidak sesuai.',style:GoogleFonts.poppins(
              fontWeight:FontWeight.w600
            )),
            SizedBox(height:20),
            btnRequestRefund(),
            SizedBox(height:20),
          ],
        ),
      ),
    );
  }
}

Widget dottedText(BuildContext context,String content){
  return Container(
    margin:EdgeInsets.symmetric(vertical:5),
    child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 3,
                  ),
                  SizedBox(width:10),
                  Container(
                    width: deviceWidth(context)-70,
                    alignment: Alignment.topLeft,
                    child: Text(content,
                        style: GoogleFonts.poppins(
                          fontWeight:FontWeight.w500,
                          fontSize: 14
                        )),
                  )
                ],
              ),
  );
}

