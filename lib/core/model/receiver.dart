part of 'models.dart';

Receiver receiverFromJson(String str) => Receiver.fromJson(json.decode(str));

String receiverToJson(Receiver data) => json.encode(data.toJson());

class Receiver {
  Receiver({
    this.id,
    this.bankName,
    this.bankLogo,
    this.nameAccount,
    this.bankNumber,
  });

  int? id;
  String? bankName;
  String? bankLogo;
  String? nameAccount;
  String? bankNumber;

  factory Receiver.fromJson(Map<String, dynamic> json) => Receiver(
        id: json["id"],
        bankName: json["bank_name"],
        bankLogo: json["bank_logo"],
        nameAccount: json["name_account"],
        bankNumber: json["bank_number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bank_name": bankName,
        "bank_logo": bankLogo,
        "name_account": nameAccount,
        "bank_number": bankNumber,
      };
}
