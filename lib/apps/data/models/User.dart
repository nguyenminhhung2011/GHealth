import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String username;
  String password;
  String email;
  String photoUrl;
  List followers;
  List following;
  String uid;
  String bio;

  User({
    required this.username,
    required this.password,
    required this.email,
    required this.photoUrl,
    required this.followers,
    required this.following,
    required this.uid,
    required this.bio,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
        'email': email,
        'photoUrl': photoUrl,
        'followers': followers,
        'following': following,
        'uid': uid,
        'bio': bio,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      username: snapshot['username'],
      password: snapshot['password'],
      email: snapshot['email'],
      photoUrl: snapshot['photoUrl'],
      followers: snapshot['followers'],
      following: snapshot['following'],
      uid: snapshot['uid'],
      bio: snapshot['bio'],
    );
  }
}
