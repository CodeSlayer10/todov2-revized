import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:notakv2/models/user.dart';
import 'package:provider/provider.dart';


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

class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  @override
  Widget build(BuildContext context) {
    User user5 = Provider.of<User>(context);
    String uid = user5.uid;
    return Scaffold(
      backgroundColor: Color(0xff353C45),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 150),
            child: Column(
              children: <Widget>[

                Center(
                  child: Container(

                    child: TextField(
                      controller: myController,
                      decoration: InputDecoration(
                        hintText: "Enter title",
                        border: InputBorder.none,
                      //  icon: Icon(Icons.title),
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),

                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    width: 350,
                    height: 40,
                    padding: EdgeInsets.only(top: 20, left: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),

                    ),

                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 50),
                  child: TextField(
                    maxLines: 20,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(

                        hintText: "after every item place a ,",
                        border: InputBorder.none,
                       // icon: Icon(Icons.text_fields),

                        hintStyle: TextStyle(
                            color:  Colors.black,

                            fontSize: 20
                        ),
                    ),
                    controller: myController1,
                    style: TextStyle(

                        color: Colors.black,
                        fontSize: 20
                    ),

                  ),
                  width: 350,
                  height: 200,
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
                Container(
                  child: InkWell(
                    onTap: (){
                      // var array = myController.text.split(',');
                      final CollectionReference collection = Firestore.instance.collection(uid);
                      setState(() {

                        collection.add({
                          'title': myController.text,
                          'inertext': myController1.text,
                          'index': 0,
                          'text': '',
                        });
                        myController.clear();
                        myController1.clear();
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 8, left: 10),
                      child: AutoSizeText("Add", style: TextStyle(color: Colors.white,), maxLines: 1, minFontSize: 20, maxFontSize: 30,),
                    )
                  ),
                  margin: EdgeInsets.only(top: 47, right: 240),

                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(color: Color(0xff47b39d), borderRadius: BorderRadius.circular(10)),
                  
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
