part of 'models.dart';

Withdraw withdrawFromJson(String str) => Withdraw.fromJson(json.decode(str));

String withdrawToJson(Withdraw data) => json.encode(data.toJson());

class Withdraw {
  Withdraw({
    this.withdrawId,
    this.userid,
    this.withdrawPacketId,
    this.withdrawNominal,
    this.bankName,
    this.bankNumber,
    this.bankAccountName,
    this.status,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int? withdrawId;
  int? userid;
  int? withdrawPacketId;
  int? withdrawNominal;
  String? bankName;
  String? bankNumber;
  String? bankAccountName;
  String? status;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory Withdraw.fromJson(Map<String, dynamic> json) => Withdraw(
        withdrawId: json["withdraw_id"],
        userid: json["userid"],
        withdrawPacketId: json["withdraw_packet_id"],
        withdrawNominal: json["withdraw_nominal"],
        bankName: json["bank_name"],
        bankNumber: json["bank_number"],
        bankAccountName: json["bank_account_name"],
        status: json["status"],
        description: json["description"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": withdrawId,
        "userid": userid,
        "withdraw_packet_id": withdrawPacketId,
        "withdraw_nominal": withdrawNominal,
        "bank_name": bankName,
        "bank_number": bankNumber,
        "bank_account_name": bankAccountName,
        "status": status,
        "description": description,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
