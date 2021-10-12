part of 'models.dart';

class Bank {
  Bank({
    required this.bankId,
    required this.bankCode,
    required this.bankName,
    required this.bankNumber,
    required this.bankImage,
    required this.atasNama,
    required this.bankMethod,
    required this.status,
  });
  late final int bankId;
  late final String bankCode;
  late final String bankName;
  late final String bankNumber;
  late final String bankImage;
  late final String atasNama;
  late final List<BankMethod> bankMethod;
  late final String status;

  Bank.fromJson(Map<String, dynamic> json) {
    bankId = json['id'];
    bankCode = json['bank_code'];
    bankName = json['bank_name'];
    bankNumber = json['bank_number'];
    bankImage = json['bank_image'];
    atasNama = json['atas_nama'];
    bankMethod = json['bank_method'] == null
        ? []
        : List<BankMethod>.from(
            json["bank_method"].map((x) => BankMethod.fromJson(x)));
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['bank_id'] = bankId;
    _data['bank_code'] = bankCode;
    _data['bank_name'] = bankName;
    _data['bank_number'] = bankNumber;
    _data['bank_image'] = bankImage;
    _data['atas_nama'] = atasNama;
    _data['bank_method'] = bankMethod;
    _data['status'] = status;
    return _data;
  }
}

class BankMethod {
  BankMethod({
    required this.methodName,
    required this.description,
  });
  late final String methodName;
  late final String description;

  BankMethod.fromJson(Map<String, dynamic> json) {
    methodName = json['method_name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['method_name'] = methodName;
    _data['description'] = description;
    return _data;
  }
}
