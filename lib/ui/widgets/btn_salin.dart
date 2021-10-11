part of 'widgets.dart';

Widget btnSalin(String? data, String? title) {
  return InkWell(
      onTap: () {
        copyToClipboard(data!, title!);
      },
      child: const Icon(
        Icons.copy_outlined,
        color: Colors.orange,
      ));
}
