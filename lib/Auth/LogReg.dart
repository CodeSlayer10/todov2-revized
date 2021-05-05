import 'package:notakv2/Auth/Log.dart';
import 'package:notakv2/Auth/Reg.dart';

import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool show = true;
  void toggleView() {
    setState(() {
      show = !show;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (show) {
      return Login(toggleView);
    } else {
      return Register(toggleView);
    }
  }
}
