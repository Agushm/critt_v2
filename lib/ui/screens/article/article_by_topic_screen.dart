part of '../screens.dart';

class ArticleByTopicScreen extends StatefulWidget {
  final TopicArticle? data;
  ArticleByTopicScreen(this.data);
  @override
  _ArticleByTopicScreenState createState() => _ArticleByTopicScreenState();
}

class _ArticleByTopicScreenState extends State<ArticleByTopicScreen> {
  bool isExpanded = true;
  bool isLoading = false;

  @override
  void initState() {
    setState(() => isLoading = true);
    Provider.of<ArticleProvider>(context, listen: false)
        .getArticle(context, widget.data!.id!.toString())
        .then((value) => setState(() => isLoading = false));
    super.initState();
  }

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
          title: Text("Dukungan",
              style: GoogleFonts.poppins(
                  color: Colors.white, fontWeight: FontWeight.w600))),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: ExpansionTile(
                initiallyExpanded: true,
                onExpansionChanged: (bool expanding) =>
                    setState(() => this.isExpanded = expanding),
                childrenPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                title: Text('Pusat Bantuan',
                    style: GoogleFonts.poppins(
                        color: isExpanded ? primaryColor : Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w800)),
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('${widget.data!.title!}',
                      style: GoogleFonts.poppins(
                          color: Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.w800)),
                  SizedBox(height: 20),
                  Consumer<ArticleProvider>(
                    builder: (context, prov, _) {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: prov.articles.length,
                          itemBuilder: (context, i) {
                            var d = prov.articles[i];
                            return InkWell(
                              onTap: () => Get.to(DetailArticleScreen(d)),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child: Text("${d.title}",
                                    style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                              ),
                            );
                          });
                    },
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
    );
  }
}
