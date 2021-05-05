import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notakv2/models/Text.dart';

import 'package:notakv2/models/user.dart';
class DataBaseService {
  final String uid;

  DataBaseService({ this.uid });


  Future Create() async {
    Firestore.instance.collection(uid).add({
      "title": "Example",
      "inertext": "",
      "index": 0,
      "text": '',
    });
  }
  Future Add(String name) async {
    Firestore.instance.collection("Names").document(uid).setData({
      "name": name
    });
  }
  Future updateUser(String name) async {
    final CollectionReference collection = Firestore.instance.collection("Names");
    return await collection.document(uid).updateData({
      'name': name,
    });
  }



  List<Text1> _TextListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      return Text1(
        text: doc.data['text'],
      );
    }).toList();
  }
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.data['name'],



    );
  }


  // get data doc stream

  Stream<List<Text1>> get text {
    final CollectionReference collection = Firestore.instance.collection(uid);
    return collection.snapshots()
        .map(_TextListFromSnapshot);
  }


  // get user doc stream
  Stream<UserData> get userData {
    final DocumentReference collection = Firestore.instance.collection("Names").document(uid);
    return collection.snapshots().map(_userDataFromSnapshot);
  }





}

