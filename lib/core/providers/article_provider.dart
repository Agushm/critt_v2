part of 'providers.dart';

class ArticleProvider extends ChangeNotifier {
  List<TopicArticle> _topics = [];
  List<TopicArticle> get topicArticle => _topics;
  bool isTopicInit = true;

  void getTopicArticle(BuildContext context) async {
    var res = await ArticleService.instance.getTopicArticle(context);
    if (res != null) {
      _topics = res;
    }
    isTopicInit = false;
    notifyListeners();
  }

  List<Article> _articles = [];
  List<Article> get articles => _articles;
  int pageArticle = 0;

  Future<void> getArticle(BuildContext context, String topicID) async {
    var res = await ArticleService.instance
        .getArticleByTopic(context, topicID, pageArticle.toString());
    if (res != null) {
      _articles = res;
    }
    notifyListeners();
  }
}
