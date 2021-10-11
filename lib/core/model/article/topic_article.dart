part of '../models.dart';

TopicArticle topicArticleFromJson(String str) =>
    TopicArticle.fromJson(json.decode(str));

String topicArticleToJson(TopicArticle data) => json.encode(data.toJson());

class TopicArticle {
  TopicArticle({
    this.id,
    this.title,
    this.description,
    this.image,
    this.adminId,
  });

  int? id;
  String? title;
  String? description;
  String? image;
  int? adminId;

  factory TopicArticle.fromJson(Map<String, dynamic> json) => TopicArticle(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        image: json["image"],
        adminId: json["admin_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "image": image,
        "admin_id": adminId,
      };
}
