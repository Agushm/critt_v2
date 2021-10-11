part of '../screens.dart';

class KirimUangScreen extends StatefulWidget {
  @override
  _KirimUangScreenState createState() => _KirimUangScreenState();
}

class _KirimUangScreenState extends State<KirimUangScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Provider.of<TransaksiProvider>(context, listen: false).getListBank(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var confirm = await DialogUtils.instance.showConfirmDialog(
          context,
          'Konfirmasi',
          'Data kirim uang akan direset. Anda akan ke tampilan utama',
        );
        return confirm!;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              color: Colors.white,
              icon: Icon(Icons.arrow_back_rounded),
              onPressed: () => Get.back()),
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Kirim Uang",
            style:
                GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          actions: [
            btnBantuan(),
            SizedBox(width: 8),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildDetailTotalTransaksi(),
            Expanded(
              child: Form(
                key: _formKey,
                child: Consumer<TransaksiProvider>(
                  builder: (context, prov, _) {
                    if (prov.penerima.isNotEmpty &&
                        prov.penerima.last["name_account"] != null &&
                        prov.penerima.last["nominal"] == "0") {
                      return NominalKirimUang();
                    }
                    if (prov.penerima.isNotEmpty &&
                        prov.penerima.last["nominal"] != "0") {
                      return DetailTransaksi();
                    } else {
                      return PilihPenerimaUang();
                    }
                    //return KonfirmasiKirimUang();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
