import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:notakv2/Services/auth.dart';

class Register extends StatefulWidget {
  Function toggle;
  Register(this.toggle);
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  AuthService _auth = AuthService();
  String email = '';
  String pass = '';
  String pass1 = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff353C45),
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 90, left: 60),
              child: AutoSizeText("Welcome,", style: TextStyle(color: Color(0xff0BC6AB)), maxLines: 1, maxFontSize: 50, minFontSize: 45,),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 140, left: 60),
              child: AutoSizeText("to Notak", style: TextStyle(color: Color(0xff0BC6AB)), maxLines: 1, maxFontSize: 50, minFontSize: 45,),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 120),
              child: Center(child: TextFromField1("Example@gmail.com", false, 0, true)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Center(child: TextFromField1("Password", true, 1, false)),
            ),
            Padding(
              padding: EdgeInsets.only(top: 470, left: 60),
              child: AutoSizeText(error, style: TextStyle(fontSize: 22, color: Colors.red),),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 240),
              child: Center(child: TextFromField1("Password", true, 2, false)),
            ),
            Padding(
              padding: EdgeInsets.only(top: 600, left: 60),

              child: Container(
                padding: EdgeInsets.only(top: 5, left: 5),
                height: 35,
                width: 110,
                decoration: BoxDecoration(color: Color(0xffE16070),
                    borderRadius: BorderRadius.circular(5)
                ),
                child: InkWell(
                  onTap: ()
                  async {

                    if (_formKey.currentState.validate()) {

                      if (pass == pass1) {


                        dynamic result = await _auth.Register(email, pass);
                        if (result ==  null) {

                          setState(() {
                            error = 'please apply a valid Email';

                          });
                        }
                      } else {
                        setState(() {
                          error = "passwords don't match";

                        });


                      }

                    }

                  },

                  child: AutoSizeText("SignUp", maxFontSize: 25, minFontSize: 20, style: TextStyle(color: Colors.white),),
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(top: 660, left: 30),
              child: underline(
                text: "have an account?",
                text1: "Login",
                onTap: (){widget.toggle();},
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget TextFromField1(String text, bool cool, int cool1, bool sav){
    return Container(
      width: 250,
      height: 35,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5)
      ),
      child: TextFormField(
        validator: sav ? (val) => val.isEmpty ? 'Enter Email' : null : (val) => val.length < 6 ? 'Enter A password 6 + chars long' : null,
        obscureText: cool,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: text,
        ),
        onChanged: (val){
          if(cool1 == 0) {
            email = val;
          } if(cool1 == 1) {
            pass = val;
          } if(cool1 == 2) {
            pass1 = val;
          }
        },
      ),
    );
  }
}

class underline extends StatelessWidget {
  final Function onTap;
  final String text;
  final String text1;
  const underline({Key key, this.text, this.text1, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AutoSizeText(text, minFontSize: 20, maxFontSize: 30, style: TextStyle(color: Colors.white),),
        FlatButton(
            onPressed: onTap,
            child: AutoSizeText(text1, minFontSize: 20, maxFontSize: 30, style: TextStyle(color: Colors.white, decoration:   TextDecoration.underline),)),
      ],
    );
  }
}
