part of '../services.dart';

class RefundService extends BaseServices {
  static RefundService instance = RefundService();

  Future<List<RefundReason>?> getRefundReason(BuildContext context) async {
    var res = await request(
      Api.refundReason,
      RequestType.GET,
      context,
      useToken: true,
    );
    if (res['status'] == 'success') {
      List<RefundReason> load = [];
      var d = res['data'] as List;
      d.forEach((e) {
        load.add(RefundReason.fromJson(e));
      });
      return load;
    } else {
      return null;
    }
  }

  Future<void> createRefund(
      BuildContext context, Map<String, dynamic> data) async {
    DialogUtils.instance.showLoading(context, '');
    var user = await ServicePreferances.instance.getUserData();
    String urlImage = await ServiceStorage.uploadImageToFirebase(
        data['transfer_receipt'],
        user!.email!,
        'Refund-Image-${DateTime.now().millisecondsSinceEpoch}');
    var res = await request(
      Api.refund,
      RequestType.POST,
      context,
      useToken: true,
      data: {
        'reason_id': data['reason_id'],
        'bank_id': data['bank_id'],
        'nominal_refund': data['nominal_refund'],
        'bank_number': data['bank_number'],
        'bank_account_name': data['bank_account_name'],
        'transfer_receipt': urlImage,
      },
    );
    Get.back();
    if (res['status'] == 'success') {
      DialogUtils.instance.showInfo(
          context, "${res['message']}", Icons.info, "OK",
          onClick: () => Get.back());
    } else {
      DialogUtils.instance.showInfo(
          context, "${res['message']}", Icons.error, "OK",
          onClick: () => Get.back());
      return null;
    }
  }

  Future<Map<String, dynamic>?> getListRequestRefund(
      BuildContext context, String page) async {
    var res = await request(
      Api.refund + 'list/' + page,
      RequestType.GET,
      context,
      useToken: true,
    );
    if (res['status'] == 'success') {
      List<RequestRefund> load = [];
      var d = res['data'] as List;
      d.forEach((e) {
        load.add(RequestRefund.fromJson(e));
      });
      return {
        "data": load,
        "loadMore": res["total_page"] == res["current_page"] ? false : true
      };
    } else {
      return null;
    }
  }
}
