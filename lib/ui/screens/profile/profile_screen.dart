part of '../screens.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgGrey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          "Akun ${appName.toUpperCase()}",
          style: appBarStyle,
        ),
      ),
      body: Consumer<AuthProvider>(
        builder: (context, prov, _) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: deviceWidth(context),
                  padding: EdgeInsets.symmetric(vertical: 20),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        backgroundImage:
                            CachedNetworkImageProvider(prov.user!.image!),
                        radius: 50,
                      ),
                      SizedBox(width: 20),
                      // Container(
                      //   margin: EdgeInsets.symmetric(horizontal: 20),
                      //   width: 80,
                      //   height: 80,
                      //   decoration: BoxDecoration(
                      //       image: DecorationImage(
                      //           fit: BoxFit.cover,
                      //           image: ExactAssetImage("assets/images/profile.jpg")),
                      //       borderRadius: BorderRadius.circular(15)),
                      // ),
                      Column(
                        children: <Widget>[
                          Text(
                            prov.user!.name!,
                            style: GoogleFonts.poppins(
                                color: primaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            stringVerification(prov.user!.isVerified!),
                            style: GoogleFonts.poppins(
                                color: Colors.grey[600],
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                BioUser(),
                SizedBox(height: 5),
                MenuProfile(),
                SizedBox(height: 10),
                Center(
                    child: Image.asset('assets/icons/logo.png',
                        width: 70, height: 70)),
                Center(child: appInfoWidget()),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Container(
                    width: 100,
                    child: InkWell(
                      onTap: () async {
                        var confirm = await DialogUtils.instance
                            .showConfirmDialog(context, 'Konfirmasi Logout',
                                'Anda yakin ingin keluar dari akun ini');
                        if (confirm!) {
                          Provider.of<AuthProvider>(context, listen: false)
                              .logout(context);
                        }
                      },
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.logout,
                              color: primaryColor,
                            ),
                            SizedBox(width: 5),
                            Container(
                              child: Text(
                                "Keluar",
                                style: GoogleFonts.poppins(
                                    color: primaryColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 60),
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget menuProfile(String title, Widget icon) {
  return Container(
    padding: EdgeInsets.all(10),
    child: Row(
      children: <Widget>[
        icon,
        SizedBox(width: 10),
        Text(
          title,
          style: GoogleFonts.poppins(
              fontSize: 16, color: primaryColor, fontWeight: FontWeight.w400),
        ),
      ],
    ),
  );
}
