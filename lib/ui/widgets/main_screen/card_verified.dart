part of '../widgets.dart';

Widget cardVerified() {
  return Consumer<AuthProvider>(
    builder: (context, prov, _) {
      if (prov.user!.isVerified! == 'verified') {
        return Container();
      }
      return Container(
          width: double.infinity,
          color: Colors.white,
          margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Status Verifikasi Akun',
                    style: GoogleFonts.poppins(
                        color: primaryColor, fontWeight: FontWeight.w600),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(prov.user!.isVerified! == 'on-process'
                          ? 'Proses verifikasi'
                          : 'Belum terverifikasi'),
                      prov.user!.isVerified! == 'on-process'
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.orange,
                              ),
                              child: Text(
                                'Dalam Proses',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                ),
                              ))
                          : prov.user!.isVerified! == 'rejected'
                              ? GestureDetector(
                                  onTap: () {
                                    Get.to(
                                        VerificationScreen(user: prov.user!));
                                  },
                                  child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 3),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.red,
                                      ),
                                      child: Text(
                                        'Ditolak',
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                        ),
                                      )),
                                )
                              : Container(
                                  height: 20,
                                  child: MaterialButton(
                                      padding: EdgeInsets.all(0),
                                      color: primaryColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      onPressed: () {
                                        Get.to(VerificationScreen());
                                      },
                                      child: Text(
                                        'Verifikasi',
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                        ),
                                      )),
                                ),
                    ],
                  )
                ],
              ),
            ],
          ));
    },
  );
}
