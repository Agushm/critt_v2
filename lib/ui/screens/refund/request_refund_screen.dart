part of '../screens.dart';

class RequestRefundScreen extends StatefulWidget {
  @override
  _RequestRefundScreenState createState() => _RequestRefundScreenState();
}

class _RequestRefundScreenState extends State<RequestRefundScreen> {
  final TextEditingController _nominalTextController = TextEditingController();
  final TextEditingController _bankNumberTextController =
      TextEditingController();
  final _formRefund = GlobalKey<FormState>();

  File? image;

  @override
  void initState() {
    Provider.of<RefundProvider>(context, listen: false).resetBankAccount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text('Pengembalian Dana',
            style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w500)),
        leading: IconButton(
            color: Colors.black,
            icon: Icon(Icons.close),
            onPressed: () => Get.back()),
        actions: [
          btnBantuan(color: Colors.black),
          SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formRefund,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                decoration: BoxDecoration(
                  color: bgGrey,
                ),
                child: Column(
                  children: [
                    Text(
                        'INGIN MENGEMBALIKAN DANA YANG TERIKIRIM KE ${appName.toUpperCase()}?',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontSize: 19,
                            color: Colors.black,
                            fontWeight: FontWeight.w500)),
                    SizedBox(height: 20),
                    Text(
                        'Silahkan buat permintaan pengembalian dana/refund agar uang kamu dapat kami kembalikan paling lambat di akhir jam oprasional.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w300)),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFormLabel('BUKTI TRANSFER'),
                    SizedBox(height: 8),
                    Text(
                        'Silahkan unggah bukti transfer atau mutasi rekening bank kamu. Bukti harus berbentuk JPG, JPEG, atau PNG dan di bawah 10MB.',
                        style: GoogleFonts.poppins(
                            color: Colors.black, fontWeight: FontWeight.w300)),
                    SizedBox(height: 15),
                    image == null
                        ? SizedBox()
                        : Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(bottom: 10),
                            height: 300,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)),
                            child: Image.file(image!)),
                    Container(
                      width: double.infinity,
                      child: MaterialButton(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: primaryColor,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          onPressed: () {
                            showDialogGetImage();
                          },
                          child: Text(
                              image == null
                                  ? '+ PILIH BUKTI TRANSFER'
                                  : 'GANTI BUKTI TRANSFER',
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w500))),
                    ),
                    SizedBox(height: 20),
                    _buildFormLabel('ALASAN REFUND'),
                    SizedBox(height: 8),
                    Consumer<RefundProvider>(
                      builder: (context, prov, _) {
                        if (prov.refundReason.isEmpty &&
                            prov.isRefundReasonInit) {
                          prov.getRefundReason(context);
                          return Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: LinearProgressIndicator());
                        }
                        if (prov.refundReason.isEmpty &&
                            prov.isRefundReasonInit == false) {
                          return Text(
                              'Prikasa koneksi gagal mengambil alasan refund');
                        }
                        return DropdownButtonFormField<RefundReason?>(
                          isExpanded: true,
                          items: prov.refundReason.map((RefundReason reason) {
                            return DropdownMenuItem(
                              value: reason,
                              child: Text('${reason.reason}',
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300)),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            prov.changeSelectedRefundReason(newValue!);
                          },
                          value: prov.selectedRefundReason,
                          style: GoogleFonts.poppins(
                              color: Colors.black, fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                              border: formBorder,
                              hintText: '${prov.selectedRefundReason!.reason}',
                              hintStyle: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)
                              //errorText: errorSnapshot.data == 0 ? Localization.of(context).reasonEmpty : null
                              ),
                        );
                      },
                    ),
                    SizedBox(height: 20),
                    _buildFormLabel('NOMINAL REFUND'),
                    SizedBox(height: 8),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _nominalTextController,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CurrencyInputFormatter()
                      ],
                      keyboardType: TextInputType.number,
                      style: GoogleFonts.poppins(
                          color: Colors.black, fontWeight: FontWeight.w500),
                      onChanged: (value) {
                        setState(() {});
                      },
                      validator: (value) {
                        if (value!.trim().length == 0) {
                          return "Harus diisi";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: "Rp",
                          hintStyle: GoogleFonts.poppins(
                              color: Colors.black, fontWeight: FontWeight.w500),
                          border: formBorder),
                    ),
                    SizedBox(height: 20),
                    _buildFormLabel('REKENING TUJUAN REFUND'),
                    SizedBox(height: 8),
                    Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.yellow[100]),
                        child: RichText(
                            textAlign: TextAlign.justify,
                            text: TextSpan(
                                text:
                                    'Rekening tujuan refund harus sama dengan rekening yang digunakan saat transfer ke rekening $appName. ',
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                                children: [
                                  TextSpan(
                                    text:
                                        'Jika rekening yang dimasukan berbeda, refund tidak dapat diproses oleh $appName.',
                                    style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w300),
                                  )
                                ]))),
                    SizedBox(height: 15),
                    Consumer2<TransaksiProvider, RefundProvider>(
                        builder: (context, prov, refund, _) {
                      if (prov.bankList == null) {
                        prov.getListBank(context);
                        return Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: LinearProgressIndicator());
                      }
                      return TextFormField(
                          autofocus: false,
                          readOnly: true,
                          onTap: () async {
                            selectedBank(context, isBankMethod: false);
                            refund.resetBankAccount();
                            FocusScope.of(context).unfocus();
                          },
                          controller: prov.bankController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              suffixIcon: Icon(Icons.arrow_drop_down,
                                  color: Colors.black),
                              hintText: 'Bank',
                              border: formBorder));
                    }),
                    SizedBox(
                      height: 5,
                    ),
                    Consumer<RefundProvider>(builder: (context, prov, _) {
                      return TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _bankNumberTextController,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            prov.resetBankAccount();
                          },
                          validator: (value) {
                            if (value!.trim().length == 0) {
                              return "Harus diisi";
                            }
                            if (prov.bankAccount == null) {
                              return "Nama pemilik rekening harus dicheck";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              suffixIcon: prov.bankAccount != null
                                  ? Icon(Icons.check_circle_outline,
                                      color: Colors.green)
                                  : InkWell(
                                      onTap: () {
                                        FocusScope.of(context).unfocus();
                                        if (_bankNumberTextController.text
                                                .trim()
                                                .length !=
                                            0) {
                                          var bank =
                                              Provider.of<TransaksiProvider>(
                                                      context,
                                                      listen: false)
                                                  .selectedBank;
                                          prov.checkBankAccount(
                                              context,
                                              _bankNumberTextController.text,
                                              bank!.bankCode);
                                        }
                                      },
                                      child: Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 10),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Text(
                                            "CEK NAMA",
                                            style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500),
                                          )),
                                    ),
                              hintText: 'Nomor rekening tujuan',
                              border: formBorder));
                    }),
                    SizedBox(
                      height: 5,
                    ),
                    Consumer<RefundProvider>(
                      builder: (context, prov, _) {
                        if (prov.bankNameTextController.text.trim().length ==
                            0) {
                          return SizedBox();
                        }
                        return TextFormField(
                            controller: prov.bankNameTextController,
                            readOnly: true,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.blue[100],
                                border: formBorder));
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: MaterialButton(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    onPressed: () {
                      if (!_formRefund.currentState!.validate()) {
                        return;
                      } else if (image == null) {
                        DialogUtils.instance.showInfo(
                            context,
                            "Anda belum memilih bukti transfer",
                            Icons.info,
                            "OK", onClick: () {
                          Get.back();
                          showDialogGetImage();
                        });
                        return;
                      } else {
                        var bank = Provider.of<TransaksiProvider>(context,
                                listen: false)
                            .selectedBank;
                        String nominal = "";
                        _nominalTextController.text.split('.').forEach((e) {
                          nominal = nominal + e;
                        });
                        var bankAccount =
                            Provider.of<RefundProvider>(context, listen: false)
                                .bankAccount;
                        var refundReason =
                            Provider.of<RefundProvider>(context, listen: false)
                                .selectedRefundReason;

                        Provider.of<RefundProvider>(context, listen: false)
                            .createRefundRequest(context, {
                          'reason_id': refundReason!.id,
                          'bank_id': bank!.bankId,
                          'nominal_refund': nominal.substring(2),
                          'bank_number': bankAccount!['bank_number'],
                          'bank_account_name': bankAccount['bank_account_name'],
                          'transfer_receipt': image,
                        });
                      }
                    },
                    color: primaryColor,
                    child: Text(
                      'BUAT PERMINTAAN REFUND',
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    )),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormLabel(String title) {
    return Text(title,
        style: GoogleFonts.poppins(
            fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500));
  }

  final picker = ImagePicker();

  void showDialogGetImage() async {
    var from = await DialogUtils.instance.showGetImageFromDialog(context);
    if (from == "gallery") {
      getImage(ImageSource.gallery);
    }
    if (from == 'camera') {
      getImage(ImageSource.camera);
    }
  }

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(
        source: source,
        preferredCameraDevice: CameraDevice.front,
        imageQuality: 40);

    setState(() {
      if (pickedFile != null) {
        setState(() {
          image = File(pickedFile.path);
        });
      } else {
        print('No image selected.');
      }
    });
  }
}
