import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
void errorToast(String msg){
  Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 15.0
    );
}
