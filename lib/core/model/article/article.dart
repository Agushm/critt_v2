part of '../models.dart';

Article articleFromJson(String str) => Article.fromJson(json.decode(str));

String articleToJson(Article data) => json.encode(data.toJson());

class Article {
  Article({
    this.id,
    this.topicId,
    this.title,
    this.content,
    this.adminId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int? id;
  int? topicId;
  String? title;
  String? content;
  int? adminId;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        id: json["id"],
        topicId: json["topic_id"],
        title: json["title"],
        content: json["content"],
        adminId: json["admin_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "topic_id": topicId,
        "title": title,
        "content": content,
        "admin_id": adminId,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
