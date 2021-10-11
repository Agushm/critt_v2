part of 'providers.dart';

class RefundProvider extends ChangeNotifier {
  List<RefundReason> _refundReason = [];
  List<RefundReason> get refundReason => _refundReason;
  RefundReason? _selectedRefundReason;
  RefundReason? get selectedRefundReason => _selectedRefundReason;
  bool isRefundReasonInit = true;

  void changeSelectedRefundReason(RefundReason newData) {
    _selectedRefundReason = newData;
  }

  void getRefundReason(BuildContext context) async {
    var data = await RefundService.instance.getRefundReason(context);
    if (data != null) {
      _refundReason = data;
      _selectedRefundReason = data[0];
    }
    isRefundReasonInit = false;
    notifyListeners();
  }

  Map<String, dynamic>? _bankAccount;
  Map<String, dynamic>? get bankAccount => _bankAccount;
  bool loadingCheckBankAccount = false;
  TextEditingController bankNameTextController = TextEditingController();

  void resetBankAccount() {
    _bankAccount = null;
    bankNameTextController.clear();

    notifyListeners();
  }

  void checkBankAccount(
      BuildContext context, String nomerRek, String bankCode) async {
    _bankAccount = null;
    bankNameTextController.clear();
    loadingCheckBankAccount = true;

    var data = await BankService.instance
        .getAccountName(context, nomerRek: nomerRek, bankCode: bankCode);
    loadingCheckBankAccount = false;
    if (data != null) {
      bankNameTextController.text = data['name'];
      _bankAccount = {
        'bank_number': nomerRek,
        'bank_account_name': data['name'],
      };
    }
    notifyListeners();
  }

  void createRefundRequest(
      BuildContext context, Map<String, dynamic> data) async {
    RefundService.instance.createRefund(context, data);
  }

  List<RequestRefund> _listRequestRefund = [];
  List<RequestRefund> get listRequestRefund => _listRequestRefund;
  bool isListRequestRefundInit = true;
  bool isListRequestRefundLoadMore = true;
  int pageListRequestRefund = 0;

  Future<void> getListRequestRefund(BuildContext context, isRefresh) async {
    if (isRefresh) {
      pageListRequestRefund = 0;
      isListRequestRefundLoadMore = true;
    }
    if (isListRequestRefundLoadMore == false) {
      return;
    }
    var res = await RefundService.instance
        .getListRequestRefund(context, pageListRequestRefund.toString());
    pageListRequestRefund = pageListRequestRefund + 1;
    if (res != null) {
      _listRequestRefund = res["data"];
      isListRequestRefundLoadMore = res["loadMore"];
    }
    isListRequestRefundInit = false;
    notifyListeners();
  }
}
