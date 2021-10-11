part of '../screens.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  PageController controller = PageController();

  double currentPage = 0;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        currentPage = controller.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 40),
          Container(child: Image.asset('assets/images/logo-text.png')),
          SizedBox(height: 40),
          Container(
            width: deviceWidth(context),
            height: deviceHeight(context) / 2,
            child: PageView(
              controller: controller,
              scrollDirection: Axis.horizontal,
              children: [
                Column(
                  children: [
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage('assets/images/intro2.png'))),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Dengan $appName transfer beda bank di Indonesia menjadi lebih hemat',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontSize: 16),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage('assets/images/intro1.png'))),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        '$appName dipercaya lebih dari 1 juta pengguna. Yuk mulai kirim uang sekarang!',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontSize: 16),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            alignment: AlignmentDirectional.bottomCenter,
            margin: EdgeInsets.only(bottom: 20.0, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                for (int i = 0; i < 2; i++)
                  if (i == currentPage)
                    SlideDots(true, color: primaryColor)
                  else
                    SlideDots(false, color: Colors.grey)
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60)),
                  elevation: 5,
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  color: primaryColor,
                  onPressed: () {
                    // AuthService.instance.register('Budi', 'asu@asu.id', 'sdasdsa', '911', context);
                    Provider.of<AuthProvider>(context, listen: false)
                        .login(context);
                    //Navigator.push(context, MaterialPageRoute(builder: (_)=>RegisterScreen()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SvgPicture.asset(
                        "assets/icons/google.svg",
                        height: 20,
                      ),
                      SizedBox(width: 5),
                      Text("Masuk Dengan Google",
                          style: GoogleFonts.poppins(color: Colors.white)),
                    ],
                  ))),
        ],
      ),
    );
  }
}

class SlideDots extends StatelessWidget {
  final bool? isActive;
  final Color? color;
  SlideDots(this.isActive, {this.color});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(microseconds: 1),
      margin: const EdgeInsets.symmetric(horizontal: 3.3),
      height: isActive! ? 6 : 6,
      width: isActive! ? 20 : 6,
      decoration: BoxDecoration(
        color: isActive! ? color : Colors.grey,
        border: isActive!
            ? Border.all(
                color: color!,
                width: 2.0,
              )
            : Border.all(
                color: Colors.transparent,
                width: 1,
              ),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
