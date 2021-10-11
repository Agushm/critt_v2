import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void copyToClipboard(String data, String title) async {
  await Clipboard.setData(ClipboardData(text: data)).then((value) =>
      Get.snackbar(title, 'Berhasil disalin',
          colorText: Colors.black,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black26));
}
