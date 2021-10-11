part of '../services.dart';

void saveInvoice(BuildContext context) async {
  Dio _dio = new Dio();

  DialogUtils.instance.showLoading(context, 'Memuat gambar');
  var appDir = await getTemporaryDirectory();
  String savePath = appDir.path + "/pubDEV.jpg";
  var _token = await ServicePreferances.instance.getToken();
  Map<String, dynamic> _headers = {"Authorization": _token};
  var response = await _dio.get(
    'https://pub.dev/static/img/pub-dev-logo-2x.png?hash=umitaheu8hl7gd3mineshk2koqfngugi',
    //Api.invoice + '${data.transactionId}',
    //onReceiveProgress: showDownloadProgress,
    //Received data with List<int>
    options: Options(
        headers: _headers,
        responseType: ResponseType.bytes,
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        }),
  );
  print(response.headers);
  File file = File(savePath);

  var raf = file.openSync(mode: FileMode.write);
  // response.data is List<int> type
  raf.writeFromSync(response.data);
  await raf.close();
  Get.back();
  final result = await ImageGallerySaver.saveFile(file.path);
  print(result);
}
