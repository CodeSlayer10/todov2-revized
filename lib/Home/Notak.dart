import 'package:auto_size_text/auto_size_text.dart';
import 'package:notakv2/Home/Settings.dart';
import 'package:notakv2/Home/Text.dart';
import 'package:notakv2/Loading/loading.dart';
import 'package:notakv2/Services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notakv2/Services/database.dart';
import 'package:notakv2/models/user.dart';
import 'dart:math';

import 'package:provider/provider.dart';
bool isSelected1 = true;
bool isSelected2 = true;

final List<Color> colors21 = <Color>[Color(0xffE16070), Color(0xff9677DF), Color(0xff2c854e), Color(0xff256f41),  Color(0xff49DE82), Color(0xffb05f6d), Color(0xffeb6b56), Color(0xff47b39d), Color(0xffa2d4ae), Color(0xff3eacab), Color(0xff0bc6ab),  Color(0xffab84b0), Color(0xffab84b0)];
final myController = TextEditingController();
void dispose(){
  myController.dispose(); {
    dispose();
  }
}

final myController1 = TextEditingController();
void dispose1(){
  myController1.dispose(); {
    dispose1();
  }
}

final Color color21 = Color(0xffE16070);

class HomePage12 extends StatefulWidget {

  @override
  _HomePage12State createState() => _HomePage12State();
}

class _HomePage12State extends State<HomePage12>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override

  Widget build(BuildContext context) {
    //User user5 = Provider.of<User>(context);
    //String uid = user5.uid;

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color(0xff353C45),
        body: Home()
    );
  }
}


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override

  final AuthService _auth = AuthService();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _currentName = '';
  String Name = '';
  bool edit = true;
  bool selected = true;
  @override
  Widget build(BuildContext context) {
   /* double ifDark(){
      final Brightness brightnessValue = MediaQuery.of(context).platformBrightness;

      if (brightnessValue == Brightness.dark) {
        return 0;
      } else {
        return 1;
      }
    }
    double dark = ifDark();*/
    User user5 = Provider.of<User>(context);
    String uid = user5.uid;
    return Scaffold(

      backgroundColor: Color(0xff353C45),
      key: _scaffoldKey,
      drawer: Drawer(),
      body: Stack(



        children: <Widget>[

          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 80, left: 30),
                child: Text(
                  "NotakV2", style: TextStyle(fontSize: 62, color: Colors.white),),
              ),
            ],
          ),
          StreamBuilder<UserData>(
              stream: DataBaseService(uid: uid).userData,
              builder: (context, snapshot) {
                if(snapshot.hasData)
                {
                  UserData userData = snapshot.data;
                  _currentName = userData.name;


                  return AnimatedPositioned(
                    duration: Duration(milliseconds: 200),
                    width: 300,
                    height: 300,
                    child: Stack(
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(top: 180, left: 30),
                          child: AutoSizeText("hello, ", style: TextStyle(
                              color:  Colors.white ,
                              fontSize: 20),),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 180, left:  85),
                          child: AutoSizeText(_currentName,  style: TextStyle(fontSize: 20, color: Colors.white,),)
                        ),

                      ],
                    ),
                  );
                } else {
                  return Loading();
                }

              }
          ),


          Column(
            children: <Widget>[

              Container(
                width: 200,
                height: 50,
                //color: Colors.blueAccent,
                margin: EdgeInsets.only(top: 175, left: 260),
                child: InkWell(
                  onTap: () async {
                    await _auth.signOut();
                  },
                  child: AutoSizeText("sign out",
                    style: TextStyle(fontSize: 25, color: Colors.white),),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 220, left: 320),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 3,),
                  borderRadius: BorderRadius.circular(10)),
              child: InkWell(
                onTap: (){
                  setState(() {
                    isSelected1 = !isSelected1;
                    isSelected2 = !isSelected2;
                    //edit = !edit;
                  });
                },
                child: Icon(Icons.edit, size: 30, color: Colors.white,),
              ),
            ),
          ),


          Container(


              margin: EdgeInsets.only(top: 250),
              child: StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance.collection(uid).snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        margin: EdgeInsets.only(top: 5),
                        child: StaggeredGridView.countBuilder(

                            staggeredTileBuilder: (int index) {

                              return StaggeredTile.fit(2);
                            },
                            scrollDirection: Axis.vertical,
                            crossAxisCount: 4,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,

                            itemCount: snapshot.data.documents.length,

                            itemBuilder: (BuildContext context, int index) {
                              var id = snapshot.data.documents[index];
                              var title = id['title'];
                              var inerText = id['inertext'];
                              var index12 = id['index'];
                              var text = id['text'];
                              var docid = id.documentID;
                              final random = new Random();

                              CollectionReference collection = Firestore.instance
                                  .collection(uid);

                              var id2 = colors21.length - 1;
                              var string = inerText.split(',');
                              //var hello = string.split(',');

                              if (index12 > id2 - 1) {
                                collection.document(docid).updateData({
                                  'index': 0
                                });
                              }



                              // print(id2);


                              // var color = colors21;
                              // var element = colors21[random.nextInt(id2)];
                              // var color23 = colors21.indexOf(element);


                              return Stack(
                                  children: <Widget>[


                                    Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: con1(title, inerText, colors21[index12], 20, index12, id, uid,

                                              (){

                                        Navigator.of(context).push(MaterialPageRoute (
                                        builder: (context) {
                                          return Text2(
                                            title: title,
                                            text1: text,
                                            color: colors21[index12],
                                            docid: docid,
                                            etext: inerText,
                                          );
                                         },
                                        ));
                                      },
                                     ),
                                    ),
                                  ]
                              );
                            }
                        ),

                      );
                    }
                    else {
                      return Loading();
                    }
                  })
          ),
        ],
      ),
    );
  }

  Widget con1(String title, String text1, color, double fontSize1, index, DocumentSnapshot id, uid, Function press) {

    CollectionReference collection = Firestore.instance.collection(uid);
    var docid = id.documentID;
    if(text1.contains(",")) {
      var hello = text1.split(',');
      return Container(


        padding: EdgeInsets.only(),
        margin: EdgeInsets.only(left: 0, right: 0),

        constraints: BoxConstraints(
          maxWidth: 200,
          minWidth: 200,
          maxHeight: 260,
          minHeight: 200,
        ),
        decoration: BoxDecoration(
          // border: !selected ? Border.all(color: Colors.white, width: 2) : null,
          color: color,
          borderRadius: BorderRadius.circular(30),

        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: press,
            child: Stack(
              children: <Widget>[
                if(!isSelected1)
                  Container(
                    margin: EdgeInsets.only(left: 20, top: 4),
                    width: 30,
                    height: 30,

                    child: InkWell(
                      onLongPress: () {
                        CollectionReference collection = Firestore.instance.collection(uid);
                        collection.document(docid).delete();




                      },
                      child: Icon(Icons.delete_forever, color: Colors.white, size: 30,),
                    ),
                  ),
                if(!isSelected2)
                  Container(
                    margin: EdgeInsets.only(left: 140, top: 4),
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 3,),
                        color: color,
                        borderRadius: BorderRadius.circular(10)),
                    child: InkWell(
                      onTap: () {
                        if (index < colors21.length-1) {
                          collection.document(docid).updateData({
                            'index': index + 1,
                          });
                        }
                        if (index > colors21.length - 2) {
                          collection.document(docid).updateData({
                            'index': 0,
                          });
                        }
                      },
                    ),
                  ),

                Hero(
                  tag: title,
                  child: Container(
                      margin: EdgeInsets.only(top: 40, left: 20),
                      child: AutoSizeText(
                        title, style: TextStyle(color: Colors.white, decoration: TextDecoration.none, fontWeight: FontWeight.normal),
                        maxFontSize: 60,
                        minFontSize: 30,
                        maxLines: 2,)),
                ),
                //SizedBox(height: 10),

                if (hello.length > 1 )



                  Hero(
                    tag: docid,
                    child: Container(
                      margin:   EdgeInsets.only(top: 120),
                      child: Column(
                          children: hello.map((text)=>

                              AutoSizeText("~ $text", style: TextStyle(color: Colors.white, fontSize: 18, decoration: TextDecoration.none, fontWeight: FontWeight.normal), maxLines: 1, minFontSize: 16, maxFontSize: 25,)).toList()
                      ),
                    ),
                  ),

              ],
            ),
          ),
        ),
      );








    } else {
      var hello = text1;
       return Container(


         padding: EdgeInsets.only(),
         margin: EdgeInsets.only(left: 0, right: 0),

         constraints: BoxConstraints(
           maxWidth: 200,
           minWidth: 200,
           maxHeight: 260,
           minHeight: 200,
         ),
         decoration: BoxDecoration(
           // border: !selected ? Border.all(color: Colors.white, width: 2) : null,
           color: color,
           borderRadius: BorderRadius.circular(30),

         ),
         child: Material(
           color: Colors.transparent,
           child: InkWell(
             onTap: press,
             child: Stack(
               children: <Widget>[
                 if(!isSelected1)
                   Container(
                     margin: EdgeInsets.only(left: 20, top: 4),
                     width: 30,
                     height: 30,

                     child: InkWell(
                       onLongPress: () {
                         CollectionReference collection = Firestore.instance.collection(uid);
                         collection.document(docid).delete();




                       },
                       child: Icon(Icons.delete_forever, color: Colors.white, size: 30,),
                     ),
                   ),
                 if(!isSelected2)
                   Container(
                     margin: EdgeInsets.only(left: 140, top: 4),
                     width: 30,
                     height: 30,
                     decoration: BoxDecoration(
                         border: Border.all(color: Colors.white, width: 3,),
                         color: color,
                         borderRadius: BorderRadius.circular(10)),
                     child: InkWell(
                       onTap: () {
                         if (index < colors21.length-1) {
                           collection.document(docid).updateData({
                             'index': index + 1,
                           });
                         }
                         if (index > colors21.length - 2) {
                           collection.document(docid).updateData({
                             'index': 0,
                           });
                         }
                       },
                     ),
                   ),

                 Hero(
                   tag: title,
                   child: Container(
                       margin: EdgeInsets.only(top: 40, left: 20),
                       child: AutoSizeText(
                         title, style: TextStyle(color: Colors.white, decoration: TextDecoration.none, fontWeight: FontWeight.normal),
                         maxFontSize: 60,
                         minFontSize: 30,
                         maxLines: 2,)),
                 ),
                 //SizedBox(height: 10),

                 if (hello.length > 1 )



                   Hero(
                     tag: docid,
                     child: Container(
                       margin:   EdgeInsets.only(top: 120),
                       child: AutoSizeText("~ $hello", style: TextStyle(color: Colors.white, fontSize: 18, decoration: TextDecoration.none, fontWeight: FontWeight.normal), maxLines: 1, minFontSize: 16, maxFontSize: 25,))
                       ),
               ],
             ),
           ),
         ),
       );
    }
  }
}