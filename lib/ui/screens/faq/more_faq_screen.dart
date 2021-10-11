part of '../screens.dart';

class MoreFAQScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgGrey,
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
              color: Colors.black,
              icon: Icon(Icons.close),
              onPressed: () => Get.back()),
          title: Text("Butuh Bantuan?",
              style: GoogleFonts.poppins(
                  color: Colors.black, fontWeight: FontWeight.w600))),
      body: Consumer<ArticleProvider>(
        builder: (context, prov, _) {
          if (prov.topicArticle.isEmpty && prov.isTopicInit) {
            prov.getTopicArticle(context);
            return Center(child: CircularProgressIndicator());
          }
          if (prov.topicArticle.isEmpty && prov.isTopicInit == false) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/no_data.png'),
                Center(
                    child: Text('Belum ada article',
                        style: GoogleFonts.poppins())),
              ],
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 10,
                color: bgGrey,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: ListView.separated(
                  separatorBuilder: (context, i) {
                    return Container(
                      height: 3,
                      color: bgGrey,
                    );
                  },
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: prov.topicArticle.length,
                  itemBuilder: (context, i) {
                    var e = prov.topicArticle[i];
                    return InkWell(
                      onTap: () {
                        Get.to(ArticleByTopicScreen(e));
                      },
                      child: menuItem(e.title!, e.description!, e.image!),
                    );
                  },
                ),
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Text("Butuh bantuan lebih lanjut?",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 18))),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: InkWell(
                    onTap: () {
                      Get.to(ListCSScreen());
                    },
                    child: menuItem('Hubungi $appName via Whatsapp', null,
                        'https://cdn4.iconfinder.com/data/icons/miu-social/60/whatsapp-social-media-256.png'),
                  )),
            ],
          );
        },
      ),
    );
  }

  Widget menuItem(String? title, String? subtitle, String? imageUrl) {
    return Container(
      color: Colors.white,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        leading: CachedNetworkImage(
          imageUrl: imageUrl!,
          height: 50,
          width: 50,
        ),
        title: Text('$title',
            style: GoogleFonts.poppins(
                color: primaryColor, fontWeight: FontWeight.w600)),
        subtitle: subtitle == null
            ? null
            : Text(subtitle, style: GoogleFonts.poppins(color: Colors.black)),
        trailing: Icon(Icons.arrow_forward_ios_rounded, color: primaryColor),
      ),
    );
  }
}
