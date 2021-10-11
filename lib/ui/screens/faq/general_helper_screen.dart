part of '../screens.dart';

class GeneralHelperScreen extends StatelessWidget {
  final Widget? body;
  GeneralHelperScreen({this.body});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgGrey,
        appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.white,
            leading: IconButton(
                color: Colors.black,
                icon: Icon(Icons.arrow_back_rounded),
                onPressed: () => Get.back()),
            title: Text("Bantuan",
                style: GoogleFonts.poppins(
                    color: Colors.black, fontWeight: FontWeight.w600))),
        body: SingleChildScrollView(child: body));
  }
}
