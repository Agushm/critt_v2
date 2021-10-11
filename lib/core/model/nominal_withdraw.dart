part of 'models.dart';

NominalWithdraw nominalWithdrawFromJson(String str) =>
    NominalWithdraw.fromJson(json.decode(str));

String nominalWithdrawToJson(NominalWithdraw data) =>
    json.encode(data.toJson());

class NominalWithdraw {
  NominalWithdraw({
    this.id,
    this.name,
    this.withdrawNominal,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int? id;
  String? name;
  int? withdrawNominal;
  DateTime? createdAt;
  dynamic updatedAt;
  dynamic deletedAt;

  factory NominalWithdraw.fromJson(Map<String, dynamic> json) =>
      NominalWithdraw(
        id: json["id"],
        name: json["name"],
        withdrawNominal: json["withdraw_nominal"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "withdraw_nominal": withdrawNominal,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
      };
}
