import 'package:flutter/material.dart';
import 'dart:async';
import 'package:fatten_app/toast.dart';

class ShowAwait extends StatefulWidget {
  ShowAwait(this.requestCallback);
  final Future<int> requestCallback;

  @override
  _ShowAwaitState createState() => new _ShowAwaitState();


  static void buildProgressingWithKey<T>(GlobalKey<ScaffoldState> key, Future<T> callback) {
    FocusScope.of(key.currentContext).requestFocus(new FocusNode());
    showDialog<int>(
        context: key.currentContext,
        barrierDismissible: false,
        builder:(context) => new ShowAwait(callback.then((value) => 1).catchError((e){
          Toasts.showMessageWithKey(key, e.toString());
        }))
    );
  }

  static void buildProgressing<T>(BuildContext context, Future<T> callback) {
    FocusScope.of(context).requestFocus(new FocusNode());
    showDialog<int>(
        context: context,
        barrierDismissible: false,
        builder:(context) => new ShowAwait(callback.then((value) => 1).catchError((e){
          Toasts.showMessage(context, e.toString());
        }))
    );
  }
}

class _ShowAwaitState extends State<ShowAwait> {
  @override
  initState() {
    super.initState();
    widget.requestCallback.then((int onValue) {
        Navigator.of(context).pop(onValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new CircularProgressIndicator(),
    );
  }
}