part of '../screens.dart';

class ListCSScreen extends StatefulWidget {
  @override
  _ListCSScreenState createState() => _ListCSScreenState();
}

class _ListCSScreenState extends State<ListCSScreen> {
  List<CustomerService> listCS = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getListCS();
  }

  void getListCS() async {
    setState(() {
      isLoading = true;
    });
    var data = await CSService.instance.getListCS(context);
    setState(() {
      if (data != null) {
        listCS = data;
      }
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Colors.white,
          icon: Icon(
            Icons.arrow_back,
            size: 30.0,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        elevation: 0,
        title: Text('Daftar Customer Service',
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: listCS.length,
              itemBuilder: (context, i) {
                var d = listCS[i];
                return ListTile(
                  onTap: () {
                    String phone = "";
                    if (d.phone!.contains('+62')) {
                      phone = d.phone!;
                    } else {
                      phone = "+62" + d.phone!.substring(1);
                    }
                    launchWhatsApp(
                        phone: phone,
                        message: "Halo $appName, Saya perlu bantuan");
                  },
                  leading: CachedNetworkImage(
                    imageUrl:
                        'https://cdn4.iconfinder.com/data/icons/miu-social/60/whatsapp-social-media-256.png',
                  ),
                  title: Text(d.name!),
                  subtitle: Text(d.phone!),
                );
              },
            ),
    );
  }
}
