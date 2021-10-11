part of 'models.dart';

RefundReason refundReasonFromJson(String str) =>
    RefundReason.fromJson(json.decode(str));

String refundReasonToJson(RefundReason data) => json.encode(data.toJson());

class RefundReason {
  RefundReason({
    this.id,
    this.reason,
  });

  String? id;
  String? reason;

  factory RefundReason.fromJson(Map<String, dynamic> json) => RefundReason(
        id: json["id"].toString(),
        reason: json["reason"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "reason": reason,
      };
}
