part of 'providers.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;
  User? get user => _user;

  AuthProvider() {
    setup();
  }

  void setup() async {
    User? u = await ServicePreferances.instance.getUserData();
    _user = u;
    notifyListeners();
  }

  Future<void> login(BuildContext context) async {
    var data = await AuthService.instance.login(context);
    if (data != null) {
      ServicePreferances.instance.saveData("token", data["token"]);

      _user = data["user"];
      ServicePreferances.instance.saveData("userData", json.encode(_user));
      Get.offAll(IndexScreen());
    }
    notifyListeners();
  }

  Future<Map<String, dynamic>?> getUser(BuildContext context) async {
    var data = await AuthService.instance.getUser(context);
    if (data != null) {
      refreshUser(data["user"].saldo, data["user"].saving,
          statusVerified: data["user"].isVerified);
      return data["verification_data"];
    } else {
      return null;
    }
  }

  Future<void> logout(BuildContext context) async {
    ServicePreferances.instance.saveData("token", null);
    _user = null;
    ServicePreferances.instance.saveData("userData", null);
    AuthService.instance.signOutGoogle();
    Get.offAll(LandingScreen());
  }

  Future<void> register(BuildContext context,
      {Map<String, dynamic>? data}) async {
    var res = await AuthService.instance.register(data!, context);
    if (res != null) {
      ServicePreferances.instance.saveData("token", res["token"]);
      _user = res["user"];
      ServicePreferances.instance.saveData("userData", json.encode(_user));
      Get.offAll(IndexScreen());
    }
  }

  Future<void> verifAccount(BuildContext context,
      {Map<String, dynamic>? data}) async {
    var res = await AuthService.instance.verifAccount(context, data!, user!);
    if (res != null) {
      _user!.isVerified = res['isVerified'];
      _user!.ktpImage = res['ktp_image'];
      _user!.ktpSelfie = res['ktp_selfie'];
      ServicePreferances.instance.saveData("userData", json.encode(_user));
      notifyListeners();
    }
  }

  void refreshUser(int? newSaldo, int? newSaving, {String? statusVerified}) {
    _user!.saldo = newSaldo;
    if (newSaving != null) {
      _user!.saving = newSaving;
    }
    if (statusVerified != null) {
      _user!.isVerified = statusVerified;
    }

    ServicePreferances.instance.saveData("userData", json.encode(_user));
    notifyListeners();
  }
}
