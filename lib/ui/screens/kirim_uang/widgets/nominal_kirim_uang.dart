import 'package:cached_network_image/cached_network_image.dart';
import 'package:critt_v2/core/utils/currency_utils.dart';
import 'package:critt_v2/core/providers/providers.dart';
import 'package:critt_v2/core/utils/dialog_utils.dart';
import 'package:critt_v2/ui/constants/constants.dart';
import 'package:critt_v2/ui/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NominalKirimUang extends StatefulWidget {
  @override
  _NominalKirimUangState createState() => _NominalKirimUangState();
}

class _NominalKirimUangState extends State<NominalKirimUang> {
  final TextEditingController _nominalController = TextEditingController();

  final TextEditingController _beritaAcaraController = TextEditingController();
  final _formNominal = GlobalKey<FormState>();
  @override
  void initState() {
    var user = Provider.of<AuthProvider>(context, listen: false).user;
    _beritaAcaraController.text = user!.name!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TransaksiProvider>(
      builder: (context, prov, _) {
        return Form(
          key: _formNominal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: bgGrey,
                ),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                        width: 90,
                        height: 60,
                        child: CachedNetworkImage(
                          imageUrl: prov.penerima.last["bank_image"],
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          width: deviceWidth(context) / 2,
                          child: Text(
                            prov.penerima.last["name_account"],
                            style: GoogleFonts.poppins(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Text(
                          prov.penerima.last["bank_number"],
                          style: GoogleFonts.poppins(
                              color: Colors.grey[700],
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Nominal Transfer",
                  style: GoogleFonts.poppins(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _nominalController,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CurrencyInputFormatter()
                  ],
                  keyboardType: TextInputType.number,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w500),
                  onChanged: (value) {
                    setState(() {});
                  },
                  validator: (value) {
                    String v = "";
                    if (value!.trim().isNotEmpty) {
                      value.substring(2).split('.').forEach((e) {
                        v = v + e;
                      });
                    }
                    if (v != "" && int.parse(v) < 10000) {
                      return 'minimal transaksi Rp10.000';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: "Rp",
                      hintStyle: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.w500),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                      border: UnderlineInputBorder()),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Berita Acara",
                  style: GoogleFonts.poppins(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: _beritaAcaraController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.text,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                      suffixText: "via $appName",
                      // suffix: Text(
                      //   "via Critt",
                      //   style: GoogleFonts.poppins(

                      //       fontSize: 20,
                      //       fontWeight: FontWeight.w500),
                      // ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                      border: UnderlineInputBorder()),
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'harus diisi';
                    }
                    return null;
                  },
                ),
              ),
              Expanded(
                child: Container(),
              ),
              _nominalController.text.length < 8
                  ? Container()
                  : Container(
                      width: deviceWidth(context),
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          color: primaryColor,
                          padding: EdgeInsets.all(15),
                          onPressed: () {
                            if (!_formNominal.currentState!.validate()) {
                              return;
                            }
                            var user = Provider.of<AuthProvider>(context,
                                    listen: false)
                                .user;
                            String nominal = "";
                            _nominalController.text.split('.').forEach((e) {
                              nominal = nominal + e;
                            });

                            if (int.parse(nominal.substring(2)) > 1000000 &&
                                user!.isVerified! != "verified") {
                              DialogUtils.instance.showInfo(
                                  context,
                                  "Verifikasi akun untuk dapat mengirim lebih dari 1 juta",
                                  Icons.info,
                                  "Verifikasi Akun",
                                  onClick: () =>
                                      Get.off(VerificationScreen(user: null)));
                              return;
                            }
                            if (int.parse(nominal.substring(2)) > 20000000 &&
                                user!.isVerified! == "verified") {
                              DialogUtils.instance.showInfo(
                                  context,
                                  "Maksimal kirim uang 20 juta",
                                  Icons.info,
                                  "Tutup",
                                  onClick: () => Get.back());
                              return;
                            }
                            Provider.of<TransaksiProvider>(context,
                                    listen: false)
                                .setNominal(nominal.substring(2),
                                    _beritaAcaraController.text);
                          },
                          child: Text(
                            "Lanjut",
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          )),
                    ),
            ],
          ),
        );
      },
    );
  }
}
