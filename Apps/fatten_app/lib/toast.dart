import 'package:flutter/material.dart';

class Toasts {
  static void showMessage(BuildContext context , String message) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
            label: "我知道了", onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  static void showMessageWithKey(GlobalKey<ScaffoldState> key , String message) {
    key.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
            label: "我知道了", onPressed: key.currentState.hideCurrentSnackBar),
      ),
    );
  }
}