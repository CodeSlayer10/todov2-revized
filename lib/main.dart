import 'package:flutter/material.dart';
import 'package:notakv2/Auth/Log.dart';
import 'package:notakv2/Auth/LogReg.dart';
import 'package:notakv2/Auth/Reg.dart';
import 'package:notakv2/Home/Home.dart';
import 'package:notakv2/Home/Notak.dart';
import 'package:notakv2/Home/Text.dart';
import 'package:provider/provider.dart';
import 'package:notakv2/Wrapper/wrapper.dart';
import 'package:notakv2/Services/auth.dart';
import 'package:flutter/services.dart';
import 'package:notakv2/models/user.dart';

void main() => (runApp(MyApp()));

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
