part of '../screens.dart';

class VerificationScreen extends StatefulWidget {
  final User? user;
  VerificationScreen({this.user});
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  TextEditingController nikTextController = TextEditingController();
  File? imageKTP;
  File? selfieKTP;
  final picker = ImagePicker();
  Map<String, dynamic>? verifData;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getVerifData();
  }

  void getVerifData() async {
    if (widget.user != null) {
      setState(() {
        isLoading = true;
      });
      var data = await Provider.of<AuthProvider>(context, listen: false)
          .getUser(context);
      setState(() {
        isLoading = false;
        verifData = data;
        nikTextController.text = data!["nik"].toString();
      });
    }
  }

  Future getImage({bool? isSelfie}) async {
    final pickedFile = await picker.pickImage(
        source: isSelfie! ? ImageSource.camera : ImageSource.gallery,
        preferredCameraDevice: CameraDevice.front,
        imageQuality: 30);
    setState(() {
      if (pickedFile != null) {
        if (isSelfie) {
          selfieKTP = File(pickedFile.path);
        } else {
          imageKTP = File(pickedFile.path);
        }
      } else {
        print('No image selected.');
      }
    });
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
        title: Text('Verifikasi Akun'),
        actions: [
          btnBantuan(color: Colors.white),
          SizedBox(width: 5),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verifData == null
                      ? SizedBox()
                      : Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          decoration: BoxDecoration(
                            color: bgGrey,
                          ),
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 20),
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: RichText(
                              text: TextSpan(
                                  style: GoogleFonts.poppins(
                                      color: Colors.red,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                  text: "Alasan Ditolak\n",
                                  children: [
                                    TextSpan(
                                      text: "${verifData!["note"]}",
                                      style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ]),
                            ),
                          )),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text("Nomor Induk Kependudukan",
                        style: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: TextField(
                      controller: nikTextController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: 'NIK pada KTP', border: formBorder),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^[0-9]*$')),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text("Gambar KTP",
                        style: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                  ),
                  Container(
                      width: double.infinity,
                      height: 180,
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          // image: imageKTP == null
                          //     ? null
                          //     : DecorationImage(
                          //         fit: BoxFit.fill, image: FileImage(imageKTP)),
                          border: Border.all(color: Colors.black26, width: 1)),
                      alignment: Alignment.center,
                      child: imageKTP != null
                          ? Image.file(imageKTP!)
                          : verifData != null
                              ? Image.network(verifData!['ktp_image'])
                              : Text('Pilih gambar KTP')),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                          getImage(isSelfie: false);
                        },
                        child: Text(
                            imageKTP == null && verifData == null
                                ? '+ PILIH GAMBAR KTP'
                                : 'GANTI GAMBAR KTP',
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: primaryColor,
                                fontWeight: FontWeight.w500))),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.yellow[100],
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                          'Pastikan gambar KTP tulisan biodata tidak blur',
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w300))),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text("Selfie dengan KTP",
                        style: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                  ),
                  SizedBox(height: 10),
                  Container(
                      width: double.infinity,
                      height: 180,
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          // image: imageKTP == null
                          //     ? null
                          //     : DecorationImage(
                          //         fit: BoxFit.fill, image: FileImage(imageKTP)),
                          border: Border.all(color: Colors.black26, width: 1)),
                      alignment: Alignment.center,
                      child: selfieKTP != null
                          ? Image.file(selfieKTP!)
                          : verifData != null
                              ? Image.network(verifData!['ktp_selfie'])
                              : Text('Pilih gambar KTP')),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                          getImage(isSelfie: true);
                        },
                        child: Text(
                            selfieKTP == null && verifData == null
                                ? '+ AMBIL GAMBAR SELFIE'
                                : 'GANTI GAMBAR SELFIE',
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: primaryColor,
                                fontWeight: FontWeight.w500))),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    width: double.infinity,
                    child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.symmetric(vertical: 15),
                        color: primaryColor,
                        onPressed: () {
                          Provider.of<AuthProvider>(context, listen: false)
                              .verifAccount(context, data: {
                            'nik': int.parse(nikTextController.text),
                            'ktp_selfie': selfieKTP,
                            'ktp_image': imageKTP,
                            'ktp_imageURL': verifData == null
                                ? null
                                : verifData!['ktp_image'],
                            'ktp_selfieURL': verifData == null
                                ? null
                                : verifData!['ktp_selfie']
                          });
                        },
                        child: Text(
                            verifData != null
                                ? 'Ajukan Ulang Verifikasi'
                                : 'Ajukan Verifikasi',
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500))),
                  ),
                ],
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
