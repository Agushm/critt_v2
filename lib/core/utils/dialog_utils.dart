import 'package:animations/animations.dart';
import 'package:critt_v2/core/model/models.dart';
import 'package:critt_v2/ui/constants/constants.dart';
import 'package:critt_v2/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DialogUtils {
  static DialogUtils instance = DialogUtils();

  void showInfo(
      BuildContext context, String message, IconData icon, String buttonText,
      {Function()? onClick}) {
    showModal(
        context: context,
        configuration:
            const FadeScaleTransitionConfiguration(barrierDismissible: false),
        builder: (context) {
          return InfoDialog(
            text: message,
            onClickOK: () => onClick != null ? onClick() : Get.back(),
            icon: icon,
            clickText: buttonText,
          );
        });
  }

  void showCustomInfo(BuildContext context, String title,
      {Widget? content,
      String? buttonOKText,
      String? buttonCancelText,
      Function()? onClick}) {
    showModal(
        context: context,
        configuration:
            const FadeScaleTransitionConfiguration(barrierDismissible: false),
        builder: (context) {
          return CustomInfoDialog(
            title: title,
            content: content!,
            onClickOK: () => onClick != null ? onClick() : Get.back(),
            clickOKText: buttonOKText!,
          );
        });
  }

  void showInvoice(
    BuildContext context,
    String title,
    Transaction data,
    String buttonText, {
    Function()? onClick,
    Function()? onClickCancel,
  }) {
    showModal(
        context: context,
        configuration:
            const FadeScaleTransitionConfiguration(barrierDismissible: false),
        builder: (context) {
          return InvoiceDialog(
            title: title,
            data: data,
            onClickOK: () => onClick != null ? onClick() : Get.back(),
            clickText: buttonText,
            onClickCancel: () =>
                onClickCancel != null ? onClickCancel() : Get.back(),
          );
        });
  }

  void showChoose(
      BuildContext context, String message, IconData icon, String buttonText,
      {Function()? onClick}) {
    showModal(
        context: context,
        configuration:
            const FadeScaleTransitionConfiguration(barrierDismissible: false),
        builder: (context) {
          return InfoDialog(
            text: message,
            onClickOK: () => onClick != null ? onClick() : Get.back(),
            icon: icon,
            onClickCancel: () => Get.back(),
            clickText: buttonText,
          );
        });
  }

  void showChooseLogin(
      BuildContext context, String message, IconData icon, String buttonText,
      {Function()? onClick}) {
    showModal(
        context: context,
        configuration:
            const FadeScaleTransitionConfiguration(barrierDismissible: false),
        builder: (context) {
          return InfoDialog(
            text: message,
            onClickOK: () => onClick != null ? onClick() : Get.back(),
            icon: icon,
            clickText: buttonText,
          );
        });
  }

  void showLoading(BuildContext context, String message) {
    showModal(
        context: context,
        configuration:
            const FadeScaleTransitionConfiguration(barrierDismissible: false),
        builder: (context) {
          return LoadingDialog(
            text: message,
          );
        });
  }

  Future<bool?> showConfirmDialog(
      BuildContext context, String title, String message,
      {String? btnCancel, String? btnOK}) {
    return showModal(
        context: context,
        configuration:
            const FadeScaleTransitionConfiguration(barrierDismissible: false),
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              MaterialButton(
                child: Text(
                  btnCancel != null ? btnCancel : 'Tidak',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onPressed: () {
                  Get.back(result: false);
                },
              ),
              MaterialButton(
                color: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(btnOK != null ? btnOK : 'Ya',
                    style: GoogleFonts.poppins(color: Colors.white)),
                onPressed: () {
                  Get.back(result: true);
                },
              ),
            ],
          );
        });
  }

  Future<String?> showGetImageFromDialog(BuildContext context) {
    return showModal(
        context: context,
        configuration:
            const FadeScaleTransitionConfiguration(barrierDismissible: false),
        builder: (context) {
          return PickImageDialog();
        });
  }
}
