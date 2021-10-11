part of '../services.dart';

class TransactionService extends BaseServices {
  Random rand = Random();
  static TransactionService instance = TransactionService();

  Future<Transaction?> addTransaction(BuildContext context,
      {int? nominal, int? bankID, List<Map<String, dynamic>>? receiver}) async {
    DialogUtils.instance.showLoading(context, '');
    int codeUnik = rand.nextInt(999);
    print(
      'Nominal transfer $nominal === receiver $receiver Bank Critt $bankID Uniq Code $codeUnik',
    );
    var res = await request(Api.transaksi, RequestType.POST, context,
        useToken: true,
        data: {
          'unique_code': codeUnik,
          'bank_critt_id': bankID,
          'nominal_transfer': nominal,
          'receiver': receiver,
        });
    Get.back();

    if (res['status'] == 'success') {
      return Transaction.fromJson(res['data']);
    } else {
      DialogUtils.instance.showInfo(context, res['message'], Icons.error, 'OK',
          onClick: () => Get.back());
      return null;
    }
  }

  Future<Map<String, dynamic>?> getTransaction(
      BuildContext context, String page) async {
    var res = await request(
      Api.transaksi + page,
      RequestType.GET,
      context,
      useToken: true,
    );
    if (res['status'] == 'success') {
      var d = res['data'] as List;
      // d.forEach((e) {
      //   load.add(Transaction.fromJson(e));
      // });
      return {
        'data': d,
        'current_page': res['current_page'],
        'total_page': res['total_page']
      };
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> uploadBuktiTransfer(BuildContext context,
      {Map<String, dynamic>? data}) async {
    DialogUtils.instance.showLoading(context, '');
    var user = await ServicePreferances.instance.getUserData();
    String urlBuktiTransfer = await ServiceStorage.uploadImageToFirebase(
        data!['image'],
        user!.email!,
        '$appName-${DateTime.now().millisecondsSinceEpoch}');
    var res = await request(Api.sendBuktiTransfer, RequestType.POST, context,
        useToken: true,
        data: {
          'transaction_id': data['transaction_id'],
          'receipt_image': urlBuktiTransfer
        });
    Get.back();

    if (res['status'] == 'success') {
      return {
        'data': res['data']['receipt_image'],
      };
    } else {
      DialogUtils.instance.showInfo(
          context, res['message'], Icons.error_outline, 'OK',
          onClick: () => Get.back());
      return null;
    }
  }

  Future<Map<String, dynamic>?> addWithdraw(BuildContext context,
      {Map<String, dynamic>? data}) async {
    DialogUtils.instance.showLoading(context, '');
    var res = await request(Api.withdraw, RequestType.POST, context,
        useToken: true,
        data: {
          'packet_id': data!['packet_id'],
          'bank_id': data['bank_id'],
          'bank_number': data['bank_number'],
          'bank_account_name': data['bank_account_name']
        });
    Get.back();

    if (res['status'] == 'success') {
      return {'Withdraw': res['data'], 'user': res['user']};
    } else {
      DialogUtils.instance.showInfo(
          context, res['message'], Icons.error_outline, 'OK',
          onClick: () => Get.back());
      return null;
    }
  }

  Future<Map<String, dynamic>?> getWithdraw(
      BuildContext context, int page) async {
    var res = await request(
      Api.withdraw + '/list/$page',
      RequestType.GET,
      context,
      useToken: true,
    );
    if (res['status'] == 'success') {
      List<Withdraw> load = [];
      var d = res['data'] as List;
      d.forEach((e) {
        load.add(Withdraw.fromJson(e));
      });
      return {'data': load};
    } else {
      return null;
    }
  }
}
