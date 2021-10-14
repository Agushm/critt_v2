part of '../services.dart';

enum RequestType { GET, POST, DELETE, PUT }

class BaseServices {
  final Dio _dio = Dio();
  Options? _headersOption;

  Future _getToken() async {
    var _token = await ServicePreferances.instance.getToken();
    _headersOption = ConfigServices.getHeaders(token: _token!);
  }

  Future<dynamic> request(String url, RequestType type, BuildContext context,
      {dynamic data, bool? useToken}) async {
    var response;

    //If this route use token then fetch token
    if (useToken != null && useToken) {
      await _getToken();
    } else {
      _headersOption = ConfigServices.getHeaders();
    }

    try {
      switch (type) {
        case RequestType.GET:
          response = await _dio.get(url, options: _headersOption);
          break;
        case RequestType.POST:
          response = await _dio.post(url,
              data: data != null ? data : null, options: _headersOption);
          break;

        case RequestType.PUT:
          response = await _dio.put(url,
              data: data != null ? data : null, options: _headersOption);
          break;
        case RequestType.DELETE:
          response = await _dio.delete(url,
              data: data != null ? data : null, options: _headersOption);
          break;
      }
    } on DioError catch (e) {
      var code = e.response!.statusCode!;
      if (code >= 400) {
        DialogUtils.instance.showChooseLogin(
            context,
            "Terjadi kesalahan, silahkan ulangi login",
            Icons.error,
            "Halaman Login", onClick: () {
          Get.offAll(LandingScreen());
        });
      }
      return null;
    }

    //* Handling error and status code
    response = json.decode(response.toString());

    if (response["status"].toString() == "401") {
      DialogUtils.instance.showChooseLogin(
          context,
          "Terjadi kesalahan, silahkan ulangi login",
          Icons.error,
          "Halaman Login", onClick: () {
        Get.offAll(LandingScreen());
      });
      return response;
    }

    return response;
  }
}
