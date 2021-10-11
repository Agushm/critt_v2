part of '../widgets.dart';

class PickImageDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              Get.back(
                result: "gallery",
              );
            },
            child: Container(
              padding: EdgeInsets.all(15),
              child: Row(
                children: [
                  Icon(Icons.image),
                  SizedBox(width: 10),
                  Text("Gallery",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Get.back(
                result: "camera",
              );
            },
            child: Container(
              padding: EdgeInsets.all(15),
              child: Row(
                children: [
                  Icon(Icons.camera_alt_outlined),
                  SizedBox(width: 10),
                  Text("Camera",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
