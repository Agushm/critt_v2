part of '../services.dart';

class BankService extends BaseServices {
  Dio dio = Dio();
  static BankService instance = BankService();
  Future<List<Bank>> listBank(BuildContext context,
      {String? bankID, String? nameAccount, String? bankNumber}) async {
    var res = await request(
      Api.bankList,
      RequestType.GET,
      context,
      useToken: true,
    );
    List<Bank> loaded = [];
    if (res["status"] == "success") {
      var d = res["data"] as List;
      d.forEach((e) {
        loaded.add(Bank.fromJson(e));
      });
      return loaded;
    } else {
      return [];
    }
  }

  Future<List<NominalWithdraw>> listNominalWithdraw(
      BuildContext context) async {
    var res = await request(
      Api.withdraw,
      RequestType.GET,
      context,
      useToken: true,
    );
    List<NominalWithdraw> loaded = [];
    if (res["status"] == "success") {
      var d = res["data"] as List;
      d.forEach((e) {
        loaded.add(NominalWithdraw.fromJson(e));
      });
      return loaded;
    } else {
      return [];
    }
  }

  Future<void> getListReceiver(BuildContext context,
      {String? bankID, String? nameAccount, String? bankNumber}) async {
    var res = await request(
      Api.receiver,
      RequestType.GET,
      context,
      useToken: true,
    );
    if (res["status"] == "success") {}
  }

  Future<void> addReceiver(BuildContext context,
      {String? bankID, String? nameAccount, String? bankNumber}) async {
    var res = await request(Api.receiver, RequestType.POST, context,
        useToken: true,
        data: {
          "list_bank_id": bankID,
          "name_account": nameAccount,
          "bank_number": bankNumber
        });
    if (res["status"] == "success") {}
  }

  Future<Map<String, dynamic>?> getAccountName(BuildContext context,
      {String? nomerRek, String? bankCode}) async {
    var formData =
        dioForm.FormData.fromMap({"nomer": nomerRek, "code": bankCode});
    DialogUtils.instance.showLoading(context, "Mohon menunggu");
    var res = await dio.post(Api.checkAccountBank, data: formData);
    Get.back();
    print(res);
    var resData = json.decode(res.toString());
    if (resData["status"] == true &&
        resData["data"]["name"].trim().length > 0) {
      return {"name": resData["data"]["name"]};
    } else {
      DialogUtils.instance.showInfo(
          context, "Nomor rekening tidak ditemukan", Icons.error, "OK",
          onClick: () => Get.back());
      return null;
    }
  }
}
