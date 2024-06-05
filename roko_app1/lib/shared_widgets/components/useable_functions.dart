import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AppFunctions{
  static void navigateTo(BuildContext context,Widget route){
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  }
  static void navigateToAndRemove(BuildContext context,Widget route){
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => route),
        (Route<dynamic> route) => false,
    );
  }
  static void navigateFrom(BuildContext context) => Navigator.pop(context);

  static void showSnackBar(BuildContext context,String content,Color? color){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(content),backgroundColor: color,)
    );
  }
  static void showAlert({
    required BuildContext context,
    String? title,
    AlertType? alertType,
    String? message,
    List<DialogButton>? dialogButtons
}){
    Alert(
      context: context,
      desc: message,
      title: title,
      type:alertType,
      buttons: dialogButtons
    ).show();
  }
}