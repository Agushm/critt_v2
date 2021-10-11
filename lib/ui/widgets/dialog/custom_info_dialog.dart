part of '../widgets.dart';

class CustomInfoDialog extends StatelessWidget {
  final String? title;
  final Widget? content;
  final String? clickOKText;
  final String? clickCancelText;
  final Function()? onClickOK;
  final Function()? onClickCancel;

  CustomInfoDialog(
      {@required this.title,
      @required this.content,
      @required this.onClickOK,
      this.onClickCancel,
      this.clickOKText = "OK",
      this.clickCancelText = "Tutup"});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      title: Center(
        child: Text(title!,
            style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600)),
      ),
      content: content,
      actions: <Widget>[
        onClickCancel != null
            ? MaterialButton(
                onPressed: onClickCancel!,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  clickCancelText!,
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
            clickOKText!,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
