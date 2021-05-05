import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:notakv2/Home/Settings.dart';
import 'package:notakv2/Loading/loading.dart';
import 'package:notakv2/Services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notakv2/Services/database.dart';
import 'package:notakv2/models/user.dart';
import 'dart:math';
import 'package:provider/provider.dart';
bool selected = true;


class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> with TickerProviderStateMixin {
  String _currentName = '';
  String Name = '';
  @override
  Widget build(BuildContext context) {
    double ifDark(){
      final Brightness brightnessValue = MediaQuery.of(context).platformBrightness;

      if (brightnessValue == Brightness.dark) {
        return 0;
      } else {
        return 1;
      }
    }
    double dark = ifDark();
    User user5 = Provider.of<User>(context);
    String uid = user5.uid;
    return Scaffold(
      backgroundColor: Color(0xff353C45),
      body: Stack(
        children: [
          StreamBuilder<UserData>(
              stream: DataBaseService(uid: user5.uid).userData,
              builder: (context, snapshot) {
                if(snapshot.hasData)
                {
                  UserData userData = snapshot.data;
                  _currentName = userData.name;


                  return AnimatedOpacity(
                    duration: Duration(microseconds: 1),
                    opacity: 1,
                    child: Container(

                      width: 500,
                      height: 600,
                      child: Stack(
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(top: 220, left: 10),
                            child: AutoSizeText("UserName: ", style: TextStyle(
                                color: dark == 1 ? Colors.white : Colors.black,
                                fontSize: 30),),
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 220, left:  175),
                              child: AutoSizeText(_currentName,  style: TextStyle(fontSize: 30, color: dark == 1 ? Colors.white : Colors.black,),)
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 65, left: 30),
                            child: AutoSizeText("Settings", style: TextStyle(color: Colors.white), maxFontSize: 45, minFontSize: 35, maxLines: 1,),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 65, left: 310),
                            child: AnimatedSwitcher(

                              child: IconButton(
                                onPressed: (){
                                  setState(() {
                                    selected = !selected;
                                  });
                                },
                                icon:  Icon(Icons.account_circle, size: 30, color: Colors.white),
                              ),
                              duration: Duration(minutes: 400),
                              transitionBuilder: (Widget child, Animation<double> animation) {
                              return ScaleTransition(
                                child: child,
                                scale: animation,
                              );
                              },

                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(top: selected ? 260 : 220, left: selected ? 50 : 85),
                            child: AnimatedSize(
                              duration: Duration(milliseconds: 700),
                              vsync: this,
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                height: selected ? 153 : 200,
                                width: selected ? 50 : 200,

                                decoration: BoxDecoration(
                                  color: Color(0xff353C45),
                                  boxShadow: selected ? [] : [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(0, 2), // changes position of shadow
                                    ),
                                  ],
                                  borderRadius: selected ? BorderRadius.circular(0) : BorderRadius.circular(30),
                                ),
                                child: selected ? Text("") : Column(
                                  children: [
                                    Padding(
                                      padding:  EdgeInsets.only(top: 40),
                                      child: TextFormField(
                                        onChanged: (val){
                                          Name = val;
                                        },
                                        initialValue: _currentName,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintStyle: TextStyle(color: Colors.white),
                                        ),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.only(top: 40, right: 105),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(5)
                                        ),
                                        width: 80,
                                        height: 20,
                                        child: InkWell(
                                          onTap: (){
                                            setState(() {
                                              DataBaseService(uid: uid).updateUser(Name);
                                              selected = !selected;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.only(top: 5, left: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Loading();
                }
              }
          ),
        ],
      ),
    );
  }
}

