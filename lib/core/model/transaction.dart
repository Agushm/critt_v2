part of 'models.dart';

Transaction transactionFromJson(String str) =>
    Transaction.fromJson(json.decode(str));

String transactionToJson(Transaction data) => json.encode(data.toJson());

class Transaction {
  Transaction({
    this.transactionId,
    this.invoiceNumber,
    this.senderName,
    this.uniqueCode,
    this.feeCritt,
    this.bankCrittId,
    this.bankCrittName,
    this.bankCrittNumber,
    this.bankCrittAtasNama,
    this.bankCrittImage,
    this.nominalTransfer,
    this.total,
    this.reciever,
    this.status,
    this.approveCritt,
    this.approveUser,
    this.updatedAt,
  });

  int? transactionId;
  String? invoiceNumber;
  String? senderName;
  String? uniqueCode;
  String? feeCritt;
  int? bankCrittId;
  String? bankCrittName;
  String? bankCrittNumber;
  String? bankCrittAtasNama;
  String? bankCrittImage;
  int? nominalTransfer;
  int? total;
  List<Reciever>? reciever;
  String? status;
  dynamic approveCritt;
  dynamic approveUser;
  DateTime? updatedAt;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        transactionId: json["transaction_id"],
        invoiceNumber: json["invoice_number"],
        senderName: json["sender_name"],
        uniqueCode: json["unique_code"].toString(),
        feeCritt: json["fee_critt"].toString(),
        bankCrittId: json["bank_critt_id"],
        bankCrittName: json["bank_critt_name"],
        bankCrittNumber: json["bank_critt_number"],
        bankCrittAtasNama: json["bank_atas_nama"],
        bankCrittImage: json["bank_image"],
        nominalTransfer: json["nominal_transfer"],
        total: json["total"],
        reciever: List<Reciever>.from(
            json["receiver"].map((x) => Reciever.fromJson(x))),
        status: json["status"],
        approveCritt: json["approve_critt"],
        approveUser: json["approve_user"],
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "transaction_id": transactionId,
        "invoice_number": invoiceNumber,
        "sender_name": senderName,
        "unique_code": uniqueCode,
        "fee_critt": feeCritt,
        "bank_critt_id": bankCrittId,
        "bank_critt_name": bankCrittName,
        "bank_critt_number": bankCrittNumber,
        "bank_critt_atas_nama": bankCrittAtasNama,
        "bank_critt_image": bankCrittImage,
        "nominal_transfer": nominalTransfer,
        "total": total,
        "receiver": List<dynamic>.from(reciever!.map((x) => x.toJson())),
        "status": status,
        "approve_critt": approveCritt,
        "approve_user": approveUser,
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class Reciever {
  Reciever(
      {this.nameAccount,
      this.nominal,
      this.bankName,
      this.bankNumber,
      this.bankImage,
      this.beritaTransfer});

  String? nameAccount;
  String? nominal;
  String? bankName;
  String? bankNumber;
  String? bankImage;
  String? beritaTransfer;

  factory Reciever.fromJson(Map<String, dynamic> json) => Reciever(
      nameAccount: json["name_account"],
      nominal: json["nominal"].toString(),
      bankName: json["bank_name"],
      bankNumber: json["bank_number"].toString(),
      bankImage: json["bank_image"],
      beritaTransfer: json["berita_transfer"]);

  Map<String, dynamic> toJson() => {
        "name_account": nameAccount,
        "nominal": nominal,
        "bank_name": bankName,
        "bank_number": bankNumber,
        "bank_image": bankImage,
        "berita_transfer": beritaTransfer
      };
}
