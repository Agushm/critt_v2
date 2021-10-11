part of 'providers.dart';

class TransaksiProvider extends ChangeNotifier {
  List<Map<String, dynamic>> penerima = [];

  TextEditingController bankController = TextEditingController();
  Bank? _selectedBank;
  Bank? get selectedBank => _selectedBank;

  void resetPenerima() {
    penerima = [];
    notifyListeners();
  }

  void setSelectedBank(Bank data, bool isBankMethod) {
    _selectedBank = data;
    bankController.text = data.bankName;
    notifyListeners();
  }

  int jmlTransaksi() {
    return penerima.where((e) => e["nominal"] != "0").toList().length;
  }

  int totalNominal() {
    int total = 0;
    penerima.forEach((e) {
      total = total + int.parse(e["nominal"]);
    });
    return total;
  }

  List<Receiver> _listReceiver = [];
  List<Receiver> get listReceiver => _listReceiver;
  bool isListReceiverInit = true;
  int pageReceiver = 0;
  bool isReceiverLoadMore = true;
  bool loadingReceiver = false;

  void getListReceiver(BuildContext context, bool isRefresh) async {
    if (isRefresh) {
      _listReceiver = [];
      pageReceiver = 0;
      isReceiverLoadMore = true;
      isListReceiverInit = true;
    }
    if (isReceiverLoadMore == false) {
      return;
    }
    loadingReceiver = true;
    var data = await ReceiverService.instance
        .getReceiver(context, pageReceiver.toString());
    pageReceiver = pageReceiver + 1;

    if (data != null) {
      if (isRefresh) {
        List<Receiver> load = [];
        data['data'].forEach((e) {
          load.add(Receiver.fromJson(e));
        });
        _listReceiver = load;
      } else {
        data['data'].forEach((e) {
          _listReceiver.add(Receiver.fromJson(e));
        });
      }

      if (data['current_page'] > data['total_page']) {
        isLoadMore = false;
      }
    }
    loadingReceiver = false;
    isListReceiverInit = false;
    notifyListeners();
  }

  void setPenerima(BuildContext context, String nameAccount, String bankNumber,
      {Receiver? r}) async {
    var data;
    if (r == null) {
      data = await ReceiverService.instance.addReceiver(
        context,
        bankID: selectedBank!.bankId,
        bankNumber: bankNumber,
        nameAccount: nameAccount,
      );
      print("RECEIVER $data");
    }
    if (penerima.isEmpty) {
      penerima.add({
        "idreceiver": r != null ? r.id : data.id,
        "name_account": nameAccount,
        "bank_number": bankNumber,
        "bank": selectedBank,
        "bank_image": r != null ? r.bankLogo : data.bankLogo,
        "nominal": "0",
        "biaya": "0"
      });
    } else {
      var last = penerima.last;
      int index = penerima.indexOf(last);
      penerima[index] = {
        "idreceiver": r != null ? r.id : data.id,
        "name_account": nameAccount,
        "bank_number": bankNumber,
        "bank": selectedBank,
        "bank_image": r != null ? r.bankLogo : data.bankLogo,
        "nominal": "0",
        "biaya": "0"
      };
    }
    notifyListeners();
  }

  void setNominal(String nominal, String berita) {
    String _nominal = "";
    nominal.split(".").forEach((e) {
      _nominal = _nominal + e;
    });
    print("Nominal:$_nominal,Berita:$berita");
    var last = penerima.last;
    int index = penerima.indexOf(last);

    penerima[index] = {
      "idreceiver": last["idreceiver"],
      "name_account": last["name_account"],
      "bank_number": last["bank_number"],
      "bank_image": last["bank_image"],
      "bank": last["bank"],
      "nominal": _nominal,
      "berita": berita,
      "biaya": "0"
    };
    print(penerima.toString());
    notifyListeners();
  }

  void tambahPenerimaLagi() {
    penerima.add({
      "name_account": null,
      "bank_number": null,
      "nominal": "0",
      "biaya": "0"
    });
    notifyListeners();
  }

  // void saveReciever(int bankID,String accountName,String bankNumber){
  //   RecieverService.instance.addReceiver(context,bankID:selectedBank. ;
  // }

  TextEditingController searchBankController = TextEditingController();
  List<Bank>? _bankList;
  List<Bank>? get bankList => _bankList;

  List<Bank> _filterBankList = [];
  List<Bank> get filterBankList => _filterBankList;

  void changeFilterBankList(String keyword) {
    _filterBankList = bankList!
        .where((e) => e.bankName.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
    notifyListeners();
  }

  Future<void> getListBank(BuildContext context) async {
    var data = await BankService.instance.listBank(context);
    if (data != null) {
      _bankList = data;
      _selectedBank = data[0];
      bankController.text = data[0].bankName;
    }
    notifyListeners();
  }

  Bank? bankMethod;
  Transaction transaction = Transaction(
      transactionId: 28,
      invoiceNumber: "CRITT-104352628",
      uniqueCode: "902",
      bankCrittId: 2,
      nominalTransfer: 50902,
      reciever: [Reciever(nameAccount: "", nominal: "50000")],
      total: 51804,
      updatedAt: DateTime.parse("2020-09-26T12:23:37.407Z"));

  Future<void> createTransaction(BuildContext context, Bank bankMethod) async {
    List<Map<String, dynamic>> receiver = [];
    penerima.forEach((e) {
      receiver.add({
        "idreceiver": e["idreceiver"],
        "nominal": int.parse(e["nominal"].toString()),
        "berita_transfer": e["berita"]
      });
    });
    var _nominal = totalNominal();

    var _bankID = bankMethod.bankId;

    var data = await TransactionService.instance.addTransaction(context,
        nominal: _nominal, bankID: _bankID, receiver: receiver);
    if (data != null) {
      transaction = data;
      _listTransaction.insert(0, data);
      notifyListeners();
      Get.back();
      Get.off(KonfirmasiKirimUang(data: data));
    }
  }

  // Daftar Transaksi //
  List<Transaction> _listTransaction = [
    // Transaction(
    //     transactionId: 1,
    //     nominalTransfer: 50000,
    //     reciever: [
    //       Reciever(
    //         bankName: "Bank Sariah Mandiri",
    //       ),
    //     ],
    //     bankCrittName: 'Bank Syariah Mandiri ',
    //     updatedAt: DateTime.now(),
    //     status: "success",
    //     senderName: 'Agus'),
  ];
  List<Transaction> get listTransaksi => _listTransaction;
  bool getTransactionInit = false;
  int pageTransaction = 0;
  bool isLoadMore = true;
  int itemTransactionThreshold = 1;
  bool loadingTransaction = false;

  void changeStatus(int transactionId, String status) {
    int _index =
        _listTransaction.indexWhere((e) => e.transactionId == transactionId);
    if (_index != null) {
      _listTransaction[_index].status = status;
      notifyListeners();
    }
  }

  void getListTransaction(BuildContext context, bool isRefresh) async {
    if (isRefresh) {
      pageTransaction = 0;
      isLoadMore = true;
      _listTransaction = [];
    }
    if (isLoadMore == false) {
      return;
    }
    loadingTransaction = true;
    var data = await TransactionService.instance
        .getTransaction(context, pageTransaction.toString());
    pageTransaction = pageTransaction + 1;
    if (data != null) {
      var d = data["data"] as List;
      d.forEach((e) {
        _listTransaction.add(Transaction.fromJson(e));
      });
      if (data['current_page'] > data['total_page']) {
        isLoadMore = false;
      }
    }
    loadingTransaction = false;
    getTransactionInit = true;

    notifyListeners();
  }

  Future<void> uploadBuktiTransfer(
      BuildContext context, Map<String, dynamic> data,
      {bool? isUpdateTransaction}) async {
    var res = await TransactionService.instance
        .uploadBuktiTransfer(context, data: data);
    print("URL BUKTI TRANSFER = ${res!["data"]}");
    if (res != null) {
      if (isUpdateTransaction != null && isUpdateTransaction == true) {
        transaction.approveUser = res['data'];
      }
      _listTransaction[data['transaction_id']].approveUser = res["data"];
      notifyListeners();
    }
  }

  List<NominalWithdraw>? _nominalWithdraw;
  List<NominalWithdraw>? get nominalWithdraw => _nominalWithdraw;

  Future<void> getListNominalWithdraw(BuildContext context) async {
    var data = await BankService.instance.listNominalWithdraw(context);
    if (data != null) {
      _nominalWithdraw = data;
    }
    notifyListeners();
  }

  List<Withdraw> _withdraw = [];
  List<Withdraw> get withdraw => _withdraw;
  bool isWithdrawInit = false;
  int pageWithdraw = 0;
  Future<void> createWithdraw(
      BuildContext context, Map<String, dynamic> data) async {
    var res =
        await TransactionService.instance.addWithdraw(context, data: data);
    if (res != null) {
      Provider.of<AuthProvider>(context, listen: false)
          .refreshUser(res["user"]["saldo"], null, statusVerified: null);
      _withdraw.insert(0, Withdraw.fromJson(res['withdraw']));
      Get.offAll(IndexScreen());
    }
  }

  Future<void> getWithdraw(BuildContext context, bool isRefresh) async {
    if (isRefresh) {
      pageWithdraw = 0;
    }
    var res =
        await TransactionService.instance.getWithdraw(context, pageWithdraw);
    if (res != null) {
      if (pageWithdraw == 0) {
        _withdraw = res["data"];
      } else {
        var d = res["data"] as List;
        d.forEach((e) {
          _withdraw.add(e);
        });
      }

      pageWithdraw = pageWithdraw + 1;
      isWithdrawInit = true;
      notifyListeners();
    }
  }

  //* Invoice
  ScreenshotController invoiceController = ScreenshotController();
  void shareInvoice(Transaction data) {
    invoiceController
        .capture(pixelRatio: 2.5, delay: Duration(milliseconds: 10))
        .then((image) async {
      final Directory temp = await getTemporaryDirectory();
      final File imageFile =
          File('$temp/Critt-${DateTime.now().millisecondsSinceEpoch}.png');
      imageFile.writeAsBytesSync(image!);
      Share.shareFiles([imageFile.path],
          text:
              '${data.invoiceNumber}\n\n${appName.toUpperCase()}\nTransfer uang antar bank gratis tanpa biaya admin.');
    }).catchError((onError) {
      print(onError);
    });
  }

  void downloadInvoice(BuildContext context) async {
    var status = await Permission.storage.request();
    if (status.isDenied || status.isPermanentlyDenied) {
      DialogUtils.instance.showInfo(
          context, 'Akses memory harus disetujui', Icons.info, 'OK',
          onClick: () => Get.back());
      return;
    }
    invoiceController
        .capture(pixelRatio: 2.0, delay: Duration(milliseconds: 10))
        .then((capture) async {
      final Directory temp = await getTemporaryDirectory();
      final File imageFile =
          File('$temp/Critt-${DateTime.now().millisecondsSinceEpoch}.png');
      imageFile.writeAsBytesSync(capture!);

      var path = await ImageGallerySaver.saveFile(imageFile.path);
      if (path != null) {
        DialogUtils.instance.showInfo(
            context, 'Gambar berhasil disimpan di gallery', Icons.info, 'OK',
            onClick: () => Get.back());
      }
    }).catchError((onError) {
      print(onError);
    });
  }
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}
