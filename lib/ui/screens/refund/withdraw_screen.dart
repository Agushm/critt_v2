part of '../screens.dart';

class WithdrawScreen extends StatefulWidget {
  @override
  _WithdrawScreenState createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController bankTextController = TextEditingController();
  final TextEditingController _bankNumberTextController =
      TextEditingController();
  final TextEditingController nominalTextController = TextEditingController();
  final _formWithdraw = GlobalKey<FormState>();
  NominalWithdraw? nominalWithdraw;

  @override
  void initState() {
    Provider.of<RefundProvider>(context, listen: false).resetBankAccount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            color: Colors.white,
            icon: Icon(Icons.arrow_back_rounded),
            onPressed: () => Get.back()),
        elevation: 0,
        title: Text('Penarikan Dana',
            style:
                GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500)),
        actions: [
          btnBantuan(),
          SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formWithdraw,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: bgGrey,
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Saldo Sekarang",
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                      Consumer<AuthProvider>(builder: (context, prov, _) {
                        return Container(
                            child: Text(
                                '${formatRupiah.format(prov.user!.saldo)}',
                                style: GoogleFonts.poppins(
                                    color: textNominal,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600)));
                      }),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text("Bank Penerima",
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.w500)),
              ),
              Consumer<TransaksiProvider>(builder: (context, prov, _) {
                if (prov.bankList == null) {
                  prov.getListBank(context);
                  return Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: LinearProgressIndicator());
                }
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextField(
                      autofocus: false,
                      readOnly: true,
                      onTap: () async {
                        selectedBank(context, isBankMethod: false);
                        Provider.of<RefundProvider>(context, listen: false)
                            .resetBankAccount();
                        FocusScope.of(context).nextFocus();
                      },
                      controller: prov.bankController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          suffixIcon:
                              Icon(Icons.arrow_drop_down, color: Colors.black),
                          hintText: 'Bank Penerima',
                          border: formBorder)),
                );
              }),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text("Nomor Rekening",
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.w500)),
              ),
              Consumer<RefundProvider>(builder: (context, prov, _) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
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
                                      var bank = Provider.of<TransaksiProvider>(
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
                          border: formBorder)),
                );
              }),
              SizedBox(
                height: 5,
              ),
              Consumer<RefundProvider>(
                builder: (context, prov, _) {
                  if (prov.bankNameTextController.text.trim().length == 0) {
                    return SizedBox();
                  }
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                        controller: prov.bankNameTextController,
                        readOnly: true,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.blue[100],
                            border: formBorder)),
                  );
                },
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text("Nominal Uang",
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.w500)),
              ),
              Consumer<TransaksiProvider>(builder: (context, prov, _) {
                if (prov.nominalWithdraw == null) {
                  prov.getListNominalWithdraw(context);
                  return Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: LinearProgressIndicator());
                }
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextField(
                      autofocus: false,
                      onTap: () async {
                        showNominalWithdraw();
                        FocusScope.of(context).unfocus();
                      },
                      readOnly: true,
                      controller: nominalTextController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          suffixIcon: Icon(Icons.arrow_drop_down),
                          hintText: 'Nominal Uang',
                          border: formBorder)),
                );
              }),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomInset: false,
      floatingActionButton: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: EdgeInsets.symmetric(vertical: 15),
            color: primaryColor,
            onPressed: () {
              var bankAccount =
                  Provider.of<RefundProvider>(context, listen: false)
                      .bankAccount;

              var bank = Provider.of<TransaksiProvider>(context, listen: false)
                  .selectedBank;
              Provider.of<TransaksiProvider>(context, listen: false)
                  .createWithdraw(context, {
                'packet_id': nominalWithdraw!.id,
                'bank_id': bank!.bankId,
                'bank_number': bankAccount!["bank_number"],
                'bank_account_name': bankAccount["bank_account_name"]
              });
            },
            child: Text('Ajukan Penarikan Dana',
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600))),
      ),
    );
  }

  void showNominalWithdraw() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Pilih Nominal Pengiriman',
                  style: GoogleFonts.poppins(
                      fontSize: 18, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              Consumer<TransaksiProvider>(builder: (context, prov, _) {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: prov.nominalWithdraw!.length,
                    itemBuilder: (context, i) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            nominalWithdraw = prov.nominalWithdraw![i];
                            nominalTextController.text =
                                prov.nominalWithdraw![i].name!;
                          });
                          Get.back();
                        },
                        child: Container(
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(vertical: 5),
                            padding: EdgeInsets.symmetric(vertical: 10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(8)),
                            child: Text(prov.nominalWithdraw![i].name!,
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600))),
                      );
                    });
              }),
            ],
          ),
        );
      },
    );
  }
}
