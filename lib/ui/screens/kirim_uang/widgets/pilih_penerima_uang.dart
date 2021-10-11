import 'package:critt_v2/core/providers/providers.dart';
import 'package:critt_v2/core/services/services.dart';
import 'package:critt_v2/core/utils/dialog_utils.dart';
import 'package:critt_v2/ui/constants/constants.dart';
import 'package:critt_v2/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PilihPenerimaUang extends StatelessWidget {
  //final TextEditingController _atasNamaController = TextEditingController();
  final TextEditingController _bankRekController = TextEditingController();
  final _formPenerima = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formPenerima,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Text(
              "Rekening Penerima",
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          Consumer<TransaksiProvider>(
            builder: (context, prov, _) {
              return Container(
                color: Colors.white,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: transaksiTextFormFiled(
                  "Bank",
                  prov.bankController,
                  readOnly: true,
                  onTap: () {
                    selectedBank(context, isBankMethod: false);
                    FocusNode().unfocus();
                  },
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Tidak boleh kosong";
                    }
                    return '';
                  },
                  suffixIcon: Icon(Icons.arrow_drop_down),
                  isOff: prov.selectedBank != null &&
                          prov.selectedBank!.status == "off"
                      ? true
                      : false,
                ),
              );
            },
          ),
          Consumer<TransaksiProvider>(
            builder: (context, prov, _) {
              if (prov.selectedBank != null &&
                  prov.selectedBank!.status == "off") {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  decoration: BoxDecoration(
                      color: Colors.yellow.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                      'Maaf bank yang anda pilih sedang gangguan. Silahkan ulangi beberapa saat lagi.'),
                );
              }
              return Container();
            },
          ),
          // transaksiTextFormFiled("Atas Nama", _atasNamaController,
          //     type: TextInputType.text, validator: (value) {
          //   if (value.trim().length == 0) {
          //     return "Tidak boleh kosong";
          //   }
          //   return null;
          // }),
          Container(
            color: Colors.white,
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: transaksiTextFormFiled("Nomor Rekening", _bankRekController,
                type: TextInputType.number, validator: (value) {
              String pattern = r'^[0-9]*$';
              RegExp regExp = new RegExp(pattern);
              if (!regExp.hasMatch(value!)) {
                return 'Hanya menerima angka';
              }
              if (value.trim().isEmpty) {
                return "Tidak boleh kosong";
              }
              return '';
            }),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              'Penerima Sebelumnya',
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: listLastReceiver(true)),

          Expanded(
            child: Container(),
          ),
          Consumer<TransaksiProvider>(builder: (context, prov, _) {
            return Container(
              width: deviceWidth(context),
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  color: primaryColor,
                  padding: EdgeInsets.all(15),
                  onPressed: prov.selectedBank == null ||
                          prov.selectedBank!.status == "off"
                      ? null
                      : () async {
                          if (!_formPenerima.currentState!.validate()) {
                            return;
                          }

                          var data = await BankService.instance.getAccountName(
                              context,
                              nomerRek: _bankRekController.text,
                              bankCode:
                                  prov.selectedBank!.bankCode.toLowerCase());
                          if (data != null) {
                            var confirm = await DialogUtils.instance
                                .showConfirmDialog(context, 'Nama Penerima',
                                    'Benar akan mengirim kepada ${data['name']}?',
                                    btnCancel: 'Batal', btnOK: 'Ya, benar');
                            if (confirm!) {
                              prov.setPenerima(context, data["name"],
                                  _bankRekController.text);
                            } else {
                              return;
                            }
                          }
                        },
                  child: Text(
                    "Lanjutkan",
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  )),
            );
          }),
        ],
      ),
    );
  }
}

Widget transaksiTextFormFiled(
  String label,
  TextEditingController controller, {
  String? hint,
  String Function(String?)? validator,
  Function()? onTap,
  bool? readOnly,
  TextInputType? type,
  Widget? suffixIcon,
  bool isOff = false,
}) {
  return TextFormField(
    onTap: onTap,
    readOnly: readOnly == null ? false : readOnly,
    controller: controller,
    keyboardType: type != null ? type : TextInputType.text,
    decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        hintStyle: GoogleFonts.poppins(fontWeight: FontWeight.w500),
        labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w500),
        suffixIcon: suffixIcon,
        prefixIcon:
            isOff ? Icon(Icons.error_outline, color: Colors.deepOrange) : null,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Colors.grey[200]!))),
    validator: validator!,
  );
}
