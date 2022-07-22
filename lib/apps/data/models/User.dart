import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String username;
  String password;

  User({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      username: snapshot['username'],
      password: snapshot['password'],
    );
  }
}
