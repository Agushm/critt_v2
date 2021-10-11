part of '../screens.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formLogin =
      GlobalKey<FormState>(debugLabel: '_loginScreenkey');

  final TextEditingController _phoneTextController = TextEditingController();

  final TextEditingController _passwordTextController = TextEditingController();

  String? noHP;

  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Image.asset("assets/images/bp.png", scale: 15)),
            SizedBox(
              height: 20,
            ),
            Form(
              key: _formLogin,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _phoneTextController,
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "omind",
                        fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        hintText: "Username",
                        counterStyle: TextStyle(color: Colors.white),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 3)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        hintStyle: TextStyle(
                            color: Colors.white,
                            fontFamily: "omind",
                            fontSize: 16),
                        prefixStyle: TextStyle(color: Colors.white)),
                    onChanged: (value) {
                      noHP = value;
                    },
                    validator: (value) {
                      if (value!.length < 6) {
                        return ("Username tidak valid");
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordTextController,
                    obscureText: true,
                    style: TextStyle(
                        fontFamily: "omind",
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 3)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      hintText: "Password",
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.white,
                      ),
                      hintStyle: TextStyle(
                          color: Colors.white,
                          fontFamily: "omind",
                          fontSize: 16),
                    ),
                    onChanged: (value) {
                      password = value;
                    },
                    validator: (value) {
                      if (value!.length < 6) {
                        return ("Password tidak valid");
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
            //_buildBtnMasuk(),
          ],
        ),
      ),
    );
  }

  // Widget _buildBtnMasuk() {
  //   return Consumer<AuthProvider>(
  //     builder: (context, authProv, _) {
  //       return Container(
  //         width: double.infinity,
  //         margin: EdgeInsets.symmetric(vertical: 20),
  //         child: MaterialButton(
  //           shape:
  //               RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //           padding: EdgeInsets.symmetric(vertical: 15),
  //           onPressed: () async {
  //             var location = await checkLocation();
  //             var loc = await ambilLokasi(context);
  //             if (!location) {
  //               DialogUtils.instance.showInfo(
  //                   context,
  //                   "Maaf, Anda harus mengaktifkan lokasi.",
  //                   Icons.info_outline,
  //                   "Maaf");
  //               return;
  //             }
  //             if(loc == null){
  //               return;
  //             }
  //             if (_formLogin.currentState.validate()) {
  //               FocusScope.of(context).unfocus();

  //               DialogUtils.instance.showLoading(context, "");
  //               await authProv
  //                   .login(context, _phoneTextController.text,
  //                       _passwordTextController.text,loc.latitude.toString(),loc.longitude.toString())
  //                   .then((value) {
  //                 // else if(value.error == "sukses"){
  //                 //   Navigator.pop(context);
  //                 //  //Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: OmindMainScreen()));
  //                 // }
  //               });
  //             }
  //           },
  //           elevation: 6,
  //           color: Colors.blue,
  //           child: Text(
  //             "MASUK",
  //             style: TextStyle(
  //                 fontSize: 18,
  //                 fontWeight: FontWeight.bold,
  //                 color: Colors.white),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
}
