import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

import 'dialog_utils.dart';

void shareText(BuildContext context, {String? subject, String? text}) {
  if (kIsWeb) {
    DialogUtils.instance.showInfo(
        context,
        'Fitur share hanya tersedia untuk aplikasi Mobile',
        Icons.info,
        'Tutup');
  }
  Share.share(text!, subject: subject!);
}

void shareFiles(BuildContext context,
    {String? subject, String? text, List<String>? images}) {
  if (kIsWeb) {
    DialogUtils.instance.showInfo(
        context,
        'Fitur share hanya tersedia untuk aplikasi Mobile',
        Icons.info,
        'Tutup');
  }
  Share.shareFiles(images!, text: text!, subject: subject!);
}
