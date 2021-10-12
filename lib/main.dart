import 'package:animations/animations.dart';
import 'package:critt_v2/core/providers/providers.dart';
import 'package:critt_v2/ui/constants/constants.dart';
import 'package:critt_v2/ui/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:responsive_framework/responsive_framework.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebase_core.Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ArticleProvider(),
        ),
        ChangeNotifierProvider.value(
          value: AuthProvider(),
        ),
        ChangeNotifierProvider.value(
          value: TransaksiProvider(),
        ),
        ChangeNotifierProvider.value(
          value: RefundProvider(),
        ),
      ],
      child: GetMaterialApp(
        title: appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          accentColor: primaryColor,
          primaryColor: primaryColor,
          scaffoldBackgroundColor: Colors.white,
          primaryTextTheme:
              TextTheme(headline6: TextStyle(color: Colors.white)),
          pageTransitionsTheme: PageTransitionsTheme(
            builders: {
              TargetPlatform.android: SharedAxisPageTransitionsBuilder(
                transitionType: SharedAxisTransitionType.vertical,
              ),
              TargetPlatform.iOS: SharedAxisPageTransitionsBuilder(
                transitionType: SharedAxisTransitionType.horizontal,
              ),
            },
          ),
        ),
        builder: (context, widget) => ResponsiveWrapper.builder(
            BouncingScrollWrapper.builder(context, widget!),
            maxWidth: 450,
            minWidth: 375,
            defaultScale: true,
            breakpoints: [
              const ResponsiveBreakpoint.resize(450, name: MOBILE),
              const ResponsiveBreakpoint.resize(800, name: MOBILE),
              const ResponsiveBreakpoint.resize(1000, name: MOBILE),
              const ResponsiveBreakpoint.resize(1200, name: MOBILE),
              const ResponsiveBreakpoint.autoScale(2460, name: MOBILE),
            ],
            background: Container(color: Color(0xFFF1F1F1))),
        home: SplashScreen(),
        // TransactionDetail(data: Transaction(
        //   invoiceNumber: "#FT27754233",
        //   status:"Pending",
        //   createdAt: DateTime.now().toString(),
        //   total: 50890,
        //   uniqueCode: 890
        // ),),
        // LandingScreen(),
        // initialRoute: RouterGenerator.routeHome,
        // onGenerateRoute: RouterGenerator.generateRoute,
      ),
    );
  }
}
