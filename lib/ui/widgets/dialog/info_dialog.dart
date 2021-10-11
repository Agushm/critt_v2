part of '../widgets.dart';

class InfoDialog extends StatelessWidget {
  final String? text;
  final String? clickText;
  final IconData? icon;
  final Function()? onClickOK;
  final Function()? onClickCancel;

  InfoDialog(
      {@required this.text,
      @required this.icon,
      @required this.onClickOK,
      this.onClickCancel,
      this.clickText = "OK"});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      title: Center(
        child: Icon(
          icon,
          color: primaryColor,
          size: 25,
        ),
      ),
      content: Text(text!,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            color: Colors.black87,
            fontSize: 16,
          )),
      actions: <Widget>[
        onClickCancel != null
            ? MaterialButton(
                onPressed: onClickCancel!,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  "Batal",
                  style: TextStyle(
                      color: primaryColor, fontWeight: FontWeight.w600),
                ),
              )
            : SizedBox(),
        MaterialButton(
          color: primaryColor,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          onPressed: onClickOK!,
          child: Text(
            clickText!,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
