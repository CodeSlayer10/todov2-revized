import 'dart:math';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:notakv2/Home/Add.dart';
import 'package:notakv2/Home/Notak.dart';
import 'package:notakv2/Home/Settings.dart';
import 'package:custombottomnavbar/custombottomnavbar.dart';

class Home11 extends StatefulWidget {
  @override
  _Home11State createState() => _Home11State();
}

class _Home11State extends State<Home11> {

  int _index = 0;
  final indexList = [
    HomePage12(),
    Add(),
    Settings(),
  ];
  @override
  Widget build(BuildContext context)
  {

    return Scaffold(
      bottomSheet: CustomBottomNavigation(
        color1: Colors.white,
        backgroundColor: Color(0xff353C45),
        radius: BorderRadius.circular(10),
        items: [
          NavItem(
            icon: Icons.home,
            bg: _index == 0 ? colors21[6] : colors21[5],
            size: 30,
            current: 0,
            onTap: (){
              setState(() {
                _index = 0;
              });
            },
          ),

          Transform.rotate(

              angle: _index != 1 ? 0 : 150,
              child: Material(
                color: Color(0xff353C45),
                borderRadius: BorderRadius.circular(10),
                child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Color(0xff353C45),
                  borderRadius: BorderRadius.circular(10)

                ),
                child: Transform.rotate(
                  angle: _index != 1 ? 0 : 150,
                  child: NavItem(
                    icon: Icons.add,
                    bg: _index == 1 ? colors21[6] : colors21[5],
                    size: 30,
                    current: 1,
                    onTap: (){
                      setState(() {
                        _index = 1;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
          NavItem(
            icon: Icons.settings,
            bg: _index == 2 ? colors21[6] : colors21[5],
            size: 30,
            current: 2,
            onTap: (){
              setState(() {
                _index = 2;
              });
            },
          ),
        ],
      ),
      body: indexList.elementAt(_index),
    );
  }
}
