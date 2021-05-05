import 'package:notakv2/Services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notakv2/models/user.dart';


class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on firebaseuser

  User _userFromFireBaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;

  }
  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
    //.map((FirebaseUser user) => _userFromFireBaseUser(user));
        .map(_userFromFireBaseUser);

  }


  // sign in anun
  Future signinAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return user.uid;

      return _userFromFireBaseUser(user);

    } catch(e) {
      print('errorrrr');
      print(e.toString());
      return null;
    }
  }


  // sign in email & password
  Future Signin(String Email, String Pass) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: Email, password: Pass);
      FirebaseUser user = result.user;
      return _userFromFireBaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // register with email & password
  Future Register(String Email, String Pass) async {
    try {

      AuthResult result = await _auth.createUserWithEmailAndPassword(email: Email, password: Pass);
      FirebaseUser user = result.user;
      // create a new document for user with the uid

      await DataBaseService(uid: user.uid).Create();
      await DataBaseService(uid: user.uid).Add("New User");


      return _userFromFireBaseUser(user);

    }catch(e) {
      print(e.toString());
      return null;
    }
  }
  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e){
      print('errororr');
      print(e.toString());
      return null;
    }
  }


}