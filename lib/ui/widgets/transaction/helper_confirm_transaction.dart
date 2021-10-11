part of '../widgets.dart';

class HelperConfirmTransaction extends StatefulWidget {
  final Transaction? data;
  final bool? isConfirmScreen;
  HelperConfirmTransaction(this.data, {this.isConfirmScreen});
  @override
  _HelperConfirmTransactionState createState() =>
      _HelperConfirmTransactionState();
}

class _HelperConfirmTransactionState extends State<HelperConfirmTransaction> {
  File? buktiTransfer;
  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        preferredCameraDevice: CameraDevice.front,
        imageQuality: 60);

    setState(() {
      if (pickedFile != null) {
        buktiTransfer = File(pickedFile.path);
        Provider.of<TransaksiProvider>(context, listen: false)
            .uploadBuktiTransfer(
                context,
                {
                  "image": File(pickedFile.path),
                  "transaction_id": widget.data!.transactionId,
                },
                isUpdateTransaction: widget.isConfirmScreen);
      } else {
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: ExpansionTile(
        childrenPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        title: Text('Apakah transaksi anda bermasalah?',
            style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500)),
        children: <Widget>[
          Text(
              'Jika transaksi anda bermasalah silahkan unggah bukti transfer agar kami dapat melakukan pengecekan manual',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w300)),
          SizedBox(height: 20),
          buktiTransfer == null || widget.data!.approveUser! == null
              ? Center(
                  child: MaterialButton(
                      padding: EdgeInsets.all(8),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(width: 2, color: primaryColor),
                          borderRadius: BorderRadius.circular(8)),
                      onPressed: () {
                        getImage();
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.photo_camera_outlined),
                          SizedBox(width: 5),
                          Text('Upload Bukti Transfer'),
                        ],
                      )),
                )
              : InkWell(
                  onTap: () {
                    //getImage(isSelfie: false);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 180,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: widget.data!.approveUser != null
                                ? CachedNetworkImageProvider(
                                    widget.data!.approveUser!)
                                : FileImage(buktiTransfer!) as ImageProvider),
                        border: Border.all(color: Colors.black26, width: 1)),
                    alignment: Alignment.center,
                  ),
                ),
        ],
      ),
    );
  }
}
