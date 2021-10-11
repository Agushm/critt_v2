part of '../services.dart';

class ArticleService extends BaseServices {
  static ArticleService instance = ArticleService();

  Future<List<TopicArticle>?> getTopicArticle(BuildContext context) async {
    var res = await request(Api.article + 'topic', RequestType.GET, context,
        useToken: true);
    if (res['status'] == 'success') {
      List<TopicArticle> load = [];
      var d = res['data'] as List;
      d.forEach((e) {
        load.add(TopicArticle.fromJson(e));
      });
      return load;
    } else {
      return null;
    }
  }

  Future<List<Article>?> getArticleByTopic(
      BuildContext context, String topicID, String page) async {
    var res = await request(
        Api.article + '$topicID/$page', RequestType.GET, context,
        useToken: true);
    if (res['status'] == 'success') {
      List<Article> load = [];
      var d = res['data'] as List;
      d.forEach((e) {
        load.add(Article.fromJson(e));
      });
      return load;
    } else {
      return null;
    }
  }
}
