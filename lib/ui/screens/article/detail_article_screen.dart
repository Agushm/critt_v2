part of '../screens.dart';

class DetailArticleScreen extends StatelessWidget {
  final Article data;
  DetailArticleScreen(this.data);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: primaryColor,
          leading: IconButton(
              color: Colors.white,
              icon: Icon(Icons.arrow_back),
              onPressed: () => Get.back()),
          title: Text(data.title!,
              style: GoogleFonts.poppins(
                  color: Colors.white, fontWeight: FontWeight.w600))),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(data.title!,
                  style: GoogleFonts.poppins(
                      fontSize: 35,
                      color: Colors.black,
                      fontWeight: FontWeight.w600)),
            ),
            htmlWidget(data.content!),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text('$appName ● ${formatTglTransaksi(data.createdAt!)}',
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }
}
