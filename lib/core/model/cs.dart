part of 'models.dart';

CustomerService customerServiceFromJson(String str) =>
    CustomerService.fromJson(json.decode(str));

String customerServiceToJson(CustomerService data) =>
    json.encode(data.toJson());

class CustomerService {
  CustomerService({
    this.id,
    this.name,
    this.phone,
    this.adminId,
  });

  int? id;
  String? name;
  String? phone;
  int? adminId;

  factory CustomerService.fromJson(Map<String, dynamic> json) =>
      CustomerService(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        adminId: json["admin_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "admin_id": adminId,
      };
}
