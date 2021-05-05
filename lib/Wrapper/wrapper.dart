import 'package:notakv2/Auth/Log.dart';
import 'package:notakv2/Home/Home.dart';
import 'package:notakv2/models/user.dart';
import 'package:flutter/material.dart';
import 'package:notakv2/Auth/LogReg.dart';
import 'package:provider/provider.dart';
import 'package:notakv2/Home/Notak.dart';


void main() => runApp(Wrapper());

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user1 = Provider.of<User>(context);
    //final user = Provider.of<User>(context);
    if (user1 == null) {
      return Authenticate();
    } else {
      return Home11();
    }
  }
}


