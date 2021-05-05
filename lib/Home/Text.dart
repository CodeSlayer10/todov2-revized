import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notakv2/Loading/loading.dart';
import 'package:notakv2/Services/database.dart';
import 'package:notakv2/models/Text.dart';
import 'package:notakv2/models/user.dart';
import 'package:provider/provider.dart';



bool lock = false;

class Text2 extends StatefulWidget
{
  final String title;
  String text1;
  final Color color;
  final docid;
  final String etext;
  Text2({
    Key key,
    this.title,
    this.text1,
    this.color,
    this.docid,
    this.etext,
  }) : super(key: key);
  @override
  _Text2State createState() => _Text2State();
}

class _Text2State extends State<Text2> {
  final _formKey = GlobalKey<FormState>();
  String text = '';
  String _currentText = '';

  @override
  Widget build(BuildContext context) {

    var hello = widget.etext.split(',');
    User user5 = Provider.of<User>(context);
    String uid = user5.uid;
    Future updateUser(String text, docid) async {
      final CollectionReference collection = Firestore.instance.collection(uid);
      return await collection.document(docid).updateData({
        'text': text,
      });
    }

    _currentText = widget.text1;
    return Scaffold(
      backgroundColor: Color(0xff353C45),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Hero(
              tag: widget.title,
              child: Container(
                padding: EdgeInsets.only(top: 100, left: 20),
                width: double.infinity,
                height: 350,
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
                ),
                child: AutoSizeText(widget.title, maxFontSize: 70, minFontSize: 50, style: TextStyle(color: Colors.white, decoration: TextDecoration.none, fontWeight: FontWeight.normal),),
              ),
            ),
            if (hello.length > 1 )
              Hero(
                tag: widget.docid,
                child: Container(
                  margin:   EdgeInsets.only(top: 160),
                  child: Column(
                      children: hello.map((text)=>

                          AutoSizeText("~ $text", style: TextStyle(color: Colors.white, fontSize: 18, decoration: TextDecoration.none, fontWeight: FontWeight.normal) , maxLines: 1, minFontSize: 16, maxFontSize: 23,)).toList()
                  ),
                ),
              ),
            
            Container(
            margin: EdgeInsets.only(top: 300, left: 10),
            child: Form(
              key: _formKey,
              child: Stack(
                children: [
                  Container(
                    height: 700,
                    width: 360,
                    margin: EdgeInsets.only(top: 40),
                    child: TextFormField(
                      initialValue: _currentText,


                      onChanged: (val) {
                        text = val;
                        setState(() {


                        });





                      },
                      keyboardType: TextInputType.multiline,
                      maxLines: 30,

                      readOnly: lock,
                      style: TextStyle(fontSize: 20, color: Colors.white,),
                      decoration: InputDecoration(

                        hintText: "",

                        border: InputBorder.none,

                      ),

                    ),
                  ),

                  //deia(text2),

                  // ignore: missing_return, missing_return

                ],
              ),
            ),
          ),
            Padding(
              padding: EdgeInsets.only(top: 40),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios, size: 30, color: Colors.white,),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 250, left: 280),
              child: Container(
                width: 60,
                height: 60,
          
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: InkWell(
                    onTap: () async {
                      updateUser(text, widget.docid);
                    },
                    child: Icon(Icons.done, size: 30, color: widget.color,)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
