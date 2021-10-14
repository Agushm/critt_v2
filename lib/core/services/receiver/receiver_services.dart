part of '../services.dart';

class ReceiverService extends BaseServices {
  static ReceiverService instance = ReceiverService();
  Future<Receiver?> addReceiver(BuildContext context,
      {int? bankID, String? nameAccount, String? bankNumber}) async {
    DialogUtils.instance.showLoading(context, "");
    var res = await request(Api.receiver, RequestType.POST, context,
        useToken: true,
        data: {
          "list_bank_id": bankID,
          "name_account": nameAccount,
          "bank_number": bankNumber
        });
    Get.back();
    if (res["status"] == "success") {
      return Receiver.fromJson(res['data']);
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getReceiver(
      BuildContext context, String page) async {
    var res = await request(
      Api.receiver + page,
      RequestType.GET,
      context,
      useToken: true,
    );
    if (res["status"] == "success") {
      return {
        'current_page': res['current_page'],
        'total_page': res['total_page'],
        "data": res['listReciever']
      };
    } else {
      return null;
    }
  }
}
