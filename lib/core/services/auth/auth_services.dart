part of '../services.dart';

class AuthService extends BaseServices {
  static AuthService instance = AuthService();

  Future<Map<String, dynamic>?> login(BuildContext context) async {
    var google = await signGoogle();
    if (google == null) {
      return null;
    } else {
      DialogUtils.instance.showLoading(context, '');

      var res = await request(Api.login, RequestType.POST, context,
          data: {
            'email': google.email,
            'google_ID': google.id,
            "fcm_token": await FCMService.instance.fcmToken()
          },
          useToken: false);
      Get.back();
      Map<String, dynamic> loadUser;

      if (res.containsKey('data') && res['status'] == 'success') {
        loadUser = {
          'token': res['data']['token'],
          'user': User.fromJson(res['data'])
        };
        return loadUser;
      }
      if (res['status'] == 'error' &&
          !res['message'].contains('belum terdaftar')) {
        DialogUtils.instance.showChooseLogin(
            context, res['message'], Icons.error, 'OK', onClick: () {
          Get.back();
        });
        return null;
      }

      if (res['status'] == 'error' &&
          res['message'].contains('belum terdaftar')) {
        DialogUtils.instance.showChooseLogin(
            context, res['message'], Icons.error, 'OK', onClick: () {
          Get.back();
          Get.to(RegisterScreen(google));
        });
        return null;
      } else {
        return null;
      }
    }
  }

  Future<Map<String, dynamic>?> getUser(BuildContext context) async {
    var res = await request(Api.user, RequestType.GET, context, useToken: true);

    Map<String, dynamic> loadUser;

    if (res.containsKey('data') && res['status'] == 'success') {
      loadUser = {
        'user': User.fromJson(res['data']),
        "verification_data": res["data"]["verification_data"].isEmpty
            ? null
            : res["data"]["verification_data"]
      };
      return loadUser;
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> register(
      Map<String, dynamic> data, BuildContext context) async {
    DialogUtils.instance.showLoading(context, 'Membuat akun ...');
    var res = await request(Api.register, RequestType.POST, context,
        data: {
          'name': data['name'],
          'email': data['email'],
          'address': data['address'],
          'phone': data['phone'],
          'image_url': data['image_url'],
          'google_ID': data['google_ID'],
          'fcm_token': await FCMService.instance.fcmToken(),
        },
        useToken: false);
    Get.back();
    Map<String, dynamic>? loadUser;
    ServicePreferances.instance.saveData('token', res['data']['token']);
    if (res.containsKey('data') && res['status'] != 'error') {
      loadUser = {
        'token': res['data']['token'],
        'user': User.fromJson(res['data'])
      };
      return loadUser;
    }
    if (res['status'] == 'error') {
      DialogUtils.instance.showChooseLogin(
          context, res['message'], Icons.error, 'OK', onClick: () {
        Get.back();
        Get.back();
      });
    }

    return loadUser;
  }

  Future<User?> getProfile(BuildContext context) async {
    var res =
        await request(Api.profile, RequestType.GET, context, useToken: true);
    User? loadUser;

    if (res.containsKey('data')) {
      loadUser = User.fromJson(res['data']);
    }

    return loadUser;
  }

  Future<bool> updatePin(BuildContext context, String pin) async {
    var res = await request(Api.updatePin, RequestType.PUT, context,
        useToken: true, data: {'pin': pin});
    if (res['status'] == 'success') {
      return true;
    } else {
      return false;
    }
  }

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      //'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  Future<GoogleSignInAccount?> signGoogle() async {
    try {
      var data = await _googleSignIn.signIn();
      return data;
    } catch (err) {
      return null;
    }
  }

  Future<GoogleSignInAccount?> signOutGoogle() async {
    try {
      var data = await _googleSignIn.signOut();
      return data;
    } catch (err) {
      return null;
    }
  }

  Future<Map<String, dynamic>?> verifAccount(
      BuildContext context, Map<String, dynamic> data, User user) async {
    DialogUtils.instance.showLoading(context, 'Mohon menunggu...');
    String? urlSelfie = data['ktp_selfie'] == null
        ? null
        : await ServiceStorage.uploadImageToFirebase(data['ktp_selfie'],
            user.email!, 'KTP-Selfie-${DateTime.now().millisecondsSinceEpoch}');
    String? urlImage = data['ktp_image'] == null
        ? null
        : await ServiceStorage.uploadImageToFirebase(data['ktp_image'],
            user.email!, 'KTP-Image-${DateTime.now().millisecondsSinceEpoch}');
    var res = await request(Api.verifAccount, RequestType.POST, context,
        data: {
          'nik': data['nik'],
          'ktp_selfie':
              data['ktp_selfie'] == null ? data["ktp_selfieURL"] : urlSelfie,
          'ktp_image':
              data['ktp_image'] == null ? data["ktp_imageURL"] : urlImage
        },
        useToken: true);
    Get.back();
    if (res['status'] == 'success') {
      DialogUtils.instance.showInfo(context,
          'Berhasil mengajukan verifikasi akun', Icons.info_outline, 'OK',
          onClick: () => Get.offAll(IndexScreen()));
      return {
        'isVerified': res['data']['status'],
        'ktpSelfie': res['data']['ktp_selfie'],
        'ktpImage': res['data']['ktp_Image'],
      };
    } else {
      DialogUtils.instance.showInfo(
          context, res['message'], Icons.error_outline, 'OK',
          onClick: () => Get.back());
      return null;
    }
  }
}
