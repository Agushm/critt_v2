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
          Container(
              margin: EdgeInsets.symmetric(vertical: 40),
              child: Image.asset('assets/images/logo-text.png',
                  width: 200, height: 200)),
          Expanded(
            child: Container(
              width: deviceWidth(context),
              child: PageView(
                controller: controller,
                scrollDirection: Axis.horizontal,
                children: [
                  Slider(
                      src: 'assets/images/intro2.png',
                      message:
                          "Dengan $appName transfer beda bank di Indonesia menjadi lebih hemat"),
                  Slider(
                      src: 'assets/images/intro1.png',
                      message:
                          '$appName dipercaya lebih dari 1 juta pengguna. Yuk mulai kirim uang sekarang!'),
                ],
              ),
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
                    Provider.of<AuthProvider>(context, listen: false)
                        .login(context);
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

class Slider extends StatelessWidget {
  final String? src;
  final String? message;
  const Slider({Key? key, this.src, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 300,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.scaleDown, image: AssetImage(src!))),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            message!,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                color: Colors.black, fontWeight: FontWeight.w300, fontSize: 16),
          ),
        )
      ],
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
