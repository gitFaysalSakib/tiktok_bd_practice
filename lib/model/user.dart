import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  String uid;
  String username;
  String email;
  String proPic;

  MyUser(
      {required this.email,
      required this.proPic,
      required this.uid,
      required this.username});

  Map<String, dynamic> toJason() {
    return {"email": email, "username": username, "uid": uid, "proPic": proPic};
  }

  static MyUser fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return MyUser(
        email: snapshot["email"],
        proPic: snapshot["proPic"],
        uid: snapshot["uid"],
        username: snapshot["username"]);
  }
}
