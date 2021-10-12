part of '../screens.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    //ServicePreferances.instance.saveData('userData', null);
    Future.delayed(Duration(seconds: 3)).then((value) {
      ServicePreferances.instance.getUserData().then((value) {
        if (value == null) {
          Get.offAll(LandingScreen());
        } else {
          Get.offAll(IndexScreen());
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Image.asset('assets/images/logo-text.png',
              width: 250, height: 250)),
    );
  }
}
