part of 'models.dart';

RequestRefund requestRefundFromJson(String str) =>
    RequestRefund.fromJson(json.decode(str));

String requestRefundToJson(RequestRefund data) => json.encode(data.toJson());

class RequestRefund {
  RequestRefund({
    this.id,
    this.bankName,
    this.bankNumber,
    this.nameAccount,
    this.reason,
    this.refundNominal,
    this.status,
    this.userTransferReceipt,
    this.crittTransferReceipt,
    this.description,
    this.updatedAt,
  });

  int? id;
  String? bankName;
  String? bankNumber;
  String? nameAccount;
  String? reason;
  int? refundNominal;
  String? status;
  String? userTransferReceipt;
  dynamic crittTransferReceipt;
  String? description;
  DateTime? updatedAt;

  factory RequestRefund.fromJson(Map<String, dynamic> json) => RequestRefund(
        id: json["id"],
        bankName: json["bank_name"],
        bankNumber: json["bank_number"],
        nameAccount: json["name_account"],
        reason: json["reason"],
        refundNominal: json["refund_nominal"],
        status: json["status"],
        userTransferReceipt: json["user_transfer_receipt"],
        crittTransferReceipt: json["critt_transfer_receipt"],
        description: json["description"],
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bank_name": bankName,
        "bank_number": bankNumber,
        "name_account": nameAccount,
        "reason": reason,
        "refund_nominal": refundNominal,
        "status": status,
        "user_transfer_receipt": userTransferReceipt,
        "critt_transfer_receipt": crittTransferReceipt,
        "description": description,
        "updated_at": updatedAt!.toIso8601String(),
      };
}
