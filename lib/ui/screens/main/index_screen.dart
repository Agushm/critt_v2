part of '../screens.dart';

class IndexScreen extends StatefulWidget {
  @override
  _IndexScreenState createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  PageController? _pageController;
  int _page = 0;

  Future<bool> _willPopCallback() async {
    // await showDialog or Show add banners or whatever
    // then
    return false; // return true if the route to be popped
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: onPageChanged,
          children: <Widget>[
            BerandaScreen(),
            TransactionScreen(),
            ProfileScreen(),
          ],
        ),
        bottomNavigationBar: SizedBox(
          height: 70,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            fixedColor: primaryColor,
            selectedLabelStyle: GoogleFonts.poppins(
                color: primaryColor, fontSize: 16, fontWeight: FontWeight.w500),
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: _page == 0 ? 25 : 20,
                  color: _page == 0 ? primaryColor : Colors.black54,
                ),
                label: 'Beranda',
              ),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/transaksi.svg',
                    width: _page == 1 ? 25 : 20,
                    height: _page == 1 ? 25 : 20,
                    color: _page == 1 ? primaryColor : Colors.black54,
                  ),
                  label: 'Transaksi'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    size: _page == 2 ? 25 : 20,
                    color: _page == 2 ? primaryColor : Colors.black54,
                  ),
                  label: 'Profil'),
            ],
            onTap: navigationTapped,
            currentIndex: _page,
          ),
        ),
      ),
    );
  }

  void navigationTapped(int page) {
    _pageController!.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    FCMService.instance.initFCM();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController!.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }
}
