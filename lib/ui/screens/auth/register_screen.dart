part of '../screens.dart';

class RegisterScreen extends StatefulWidget {
  final GoogleSignInAccount? google;
  RegisterScreen(this.google);
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _namaController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _alamatController = TextEditingController();
  TextEditingController _hpController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _namaController.text = widget.google!.displayName!;
    _emailController.text = widget.google!.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  "Hallo, sobat $appName!",
                  style: GoogleFonts.poppins(
                      fontSize: 30, fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  "Segera lengkapi data berikut untuk menggunakan layanan $appName",
                  style: GoogleFonts.poppins(
                      fontSize: 20, fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              _registerTextFormFiled("Nama Lengkap", _namaController,
                  validator: (value) {
                if (value!.isEmpty) {
                  return "Masukan nama lengkap anda";
                }
                return '';
              }),
              _registerTextFormFiled("Email", _emailController, enebeled: false,
                  validator: (value) {
                if (value!.isEmpty || !value.isEmail) {
                  return "Masukan email yang valid";
                }
                return '';
              }),
              _registerTextFormFiled("Alamat", _alamatController,
                  validator: (value) {
                if (value!.isEmpty) {
                  return "Masukan alamat anda";
                }
                return '';
              }),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "NOMOR HANDPHONE",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              _registerTextFormFiled(null, _hpController, hint: "08xxxxxxxx",
                  validator: (value) {
                if (value!.isEmpty) {
                  return "Harus diisi";
                }
                return '';
              }),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "contoh: 08xxxxxxxx",
                    style: GoogleFonts.poppins(),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                width: deviceWidth(context),
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: MaterialButton(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: primaryColor,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Map<String, dynamic> data = {
                        "name": _namaController.text,
                        "email": _emailController.text,
                        "address": _alamatController.text,
                        "phone": _hpController.text,
                        "image_url": widget.google!.photoUrl,
                        "google_ID": widget.google!.id,
                      };
                      Provider.of<AuthProvider>(context, listen: false)
                          .register(context, data: data);
                      //Navigator.push(context,MaterialPageRoute(builder: (_) => IndexScreen()));
                    }
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (_) => IndexScreen()));
                  },
                  child: Text("BUAT AKUN ${appName.toUpperCase()}",
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              _peringatan(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _registerTextFormFiled(String? label, TextEditingController controller,
    {String? hint, String Function(String?)? validator, bool? enebeled}) {
  return Container(
    color: Colors.white,
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    child: TextFormField(
      enabled: enebeled ?? true,
      controller: controller,
      decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          hintStyle: GoogleFonts.poppins(fontWeight: FontWeight.w500),
          labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w500),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.grey[200]!))),
      validator: validator!,
    ),
  );
}

Widget _peringatan() {
  return RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
        text: "Dengan membuat akun saya telah setuju dengan ",
        style: GoogleFonts.sourceCodePro(color: Colors.black),
        children: <TextSpan>[
          TextSpan(
              text: "Syarat & Ketentuan",
              style: GoogleFonts.sourceCodePro(
                  color: primaryColor, fontWeight: FontWeight.bold)),
          TextSpan(text: " serta "),
          TextSpan(
              text: "Kebijakan Privasi",
              style: GoogleFonts.sourceCodePro(
                  color: primaryColor, fontWeight: FontWeight.bold)),
          TextSpan(text: " yang diterapkan oleh $appName."),
        ]),
  );
}
