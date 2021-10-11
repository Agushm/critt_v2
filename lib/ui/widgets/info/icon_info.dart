import 'package:flutter/material.dart';

Widget iconInfo(Function()? function, {IconData? icon}) {
  return IconButton(
      icon: Icon(
        icon == null ? Icons.info_outline : icon,
        color: Colors.grey[400],
        size: 20,
      ),
      onPressed: function!);
}
