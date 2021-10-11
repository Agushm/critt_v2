part of 'models.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User(
      {this.name,
      this.email,
      this.phone,
      this.address,
      this.image,
      this.token,
      this.isVerified,
      this.ktpSelfie,
      this.ktpImage,
      this.saldo,
      this.saving});

  String? name;
  String? email;
  String? phone;
  String? address;
  String? image;
  String? token;
  String? isVerified;
  String? ktpSelfie;
  String? ktpImage;
  int? saldo;
  int? saving;
  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        image: json["image"],
        token: json["token"],
        isVerified: json["is_verified"],
        ktpSelfie: json['ktp_selfie'],
        ktpImage: json['ktp_image'],
        saldo: json['saldo'] == null ? 0 : int.parse(json['saldo'].toString()),
        saving:
            json['saving'] == null ? 0 : int.parse(json['saving'].toString()),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone": phone,
        "address": address,
        "image": image,
        "token": token,
        "is_verified": isVerified,
        'ktp_selfie': ktpSelfie,
        'ktp_image': ktpImage,
        "saldo": saldo,
        "saving": saving
      };
}
