import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tut_app/app/app.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  void updateAppState() {
     MyApp.instance.appState = 10;
  }

  void getAppState() {
    if (kDebugMode) {
      print(MyApp.instance.appState);
    } // 10
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
