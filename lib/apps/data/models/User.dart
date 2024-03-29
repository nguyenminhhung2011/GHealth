import 'package:cloud_firestore/cloud_firestore.dart';

import '../enums/app_enums.dart';

class User {
  String uid;
  String name;
  String username;
  String password;
  int height;
  int weight;
  int heightTarget;
  int weightTarget;
  DateTime dateOfBirth;
  Gender gender;
  Times duration;
  String avtPath;
  User({
    required this.uid,
    required this.name,
    required this.username,
    required this.password,
    required this.height,
    required this.weight,
    required this.heightTarget,
    required this.weightTarget,
    required this.dateOfBirth,
    required this.gender,
    required this.duration,
    required this.avtPath,
  });

  set email(email) {}

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'username': username,
        'password': password,
        'height': height,
        'weight': weight,
        'heightTarget': heightTarget,
        'weightTarget': weightTarget,
        'dateOfBirth': dateOfBirth,
        'gender': listGenderString[gender],
        'duration': listTimesString[duration],
        'avtPath': avtPath,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      uid: snapshot['uid'],
      name: snapshot['name'],
      username: snapshot['username'],
      password: snapshot['password'],
      height: snapshot['height'],
      weight: snapshot['weight'],
      heightTarget: snapshot['heightTarget'],
      weightTarget: snapshot['weightTarget'],
      dateOfBirth: snapshot['dateOfBirth'],
      gender: getGender(snapshot['gender']),
      duration: getTimes(snapshot['duration']),
      avtPath: snapshot['avtPath'],
    );
  }
}
