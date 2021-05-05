import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:notakv2/Services/auth.dart';
class Login extends StatefulWidget {
  Function toggle;
  Login(this.toggle);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  AuthService _auth = AuthService();
  String email = '';
  String pass = '';
  String error = '';
  String error1 = '';
  String error2 = '';
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
              padding: const EdgeInsets.only(bottom: 80),
              child: Center(child: TextFromField1("Example@gmail.com", 1, false)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Center(child: TextFromField1("Password", 0, true)),
            ),
            Padding(
              padding: EdgeInsets.only(top: 490, left: 60),
              child: AutoSizeText(error, style: TextStyle(fontSize: 22, color: Colors.red),),
            ),
            Padding(
              padding: EdgeInsets.only(top: 530, left: 60),

              child: Container(
                padding: EdgeInsets.only(top: 5, left: 5),
                height: 35,
                width: 110,
                decoration: BoxDecoration(color: Color(0xffE16070),
                  borderRadius: BorderRadius.circular(5)
                ),
              child: InkWell(
                onTap: ()  async {
                  if (_formKey.currentState.validate()) {
                    dynamic result = await _auth.Signin(email, pass);

                    if (result == null) {

                      setState(() {
                        error = 'incorrect credentials';
                      });
                    }


                    // dynamic result = await _auth.Register(username, password);
                    // if (result ==  null) {
                    setState(() {
                      // error = 'please apply a valid Email';

                    });
                  }
                  //  }

                },
                child: AutoSizeText("Login", maxFontSize: 25, minFontSize: 20, style: TextStyle(color: Colors.white),),
              ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(top: 600, left: 30),
              child: underline(
                text: "don't have an account?",
                text1: "SignUp",
                onTap: (){widget.toggle();},
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget TextFromField1(String text, int one1, bool cord){
    return Container(
      width: 250,
      height: 35,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5)
      ),
      child: TextFormField(
        obscureText: cord,
        //validator: one1 == 1 ? (val) => val.isEmpty ? 'Enter Email' : null : (val) => val.isEmpty ? 'Enter Password' : null,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: text,
        ),
        onChanged: (val){
          if(one1 == 1) {
            email = val;
          } else {
            pass = val;
          }
        },
      ),
    );
  }
  Widget TextFromField2(String text, int one1, bool cord){
    print(error2);
    return SizedBox(
      width: 250,
      height: 35,

      child: Theme(
        data: new ThemeData(
          primaryColor: Colors.grey,


        ),
        child: TextFormField(
          textAlign: TextAlign.start,
          scrollPhysics: ClampingScrollPhysics(),
          obscureText: cord,
          validator: one1 == 1 ? (val) => val.isEmpty ? error1 = 'Enter Email' : error1 = '' : (val) => val.isEmpty ? error2 = 'Enter Password' : error2 = '',

          decoration: InputDecoration(
            labelText: error1.isEmpty ? "Password" : error1,
            contentPadding: EdgeInsets.only(top: 5, left: 3),
            hintStyle: TextStyle(color: Colors.white),
            hintText: text,
           alignLabelWithHint: true,
           errorBorder: OutlineInputBorder(
             borderSide: BorderSide(color: Colors.red)
           ),

           // labelText: "Username",

            border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.grey)
            ),
              enabledBorder: new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.white)
              ),
            //floatingLabelBehavior: FloatingLabelBehavior.always
          ),


          style: TextStyle(color: Colors.white),
          onChanged: (val){

            if(one1 == 1) {
              email = val;
            } else {
              pass = val;
            }
          },
        ),
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
