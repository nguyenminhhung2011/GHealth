import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:gold_health/apps/controls/storage_methods.dart.dart';
import 'package:gold_health/apps/data/list_error_string.dart';
import 'package:gold_health/apps/pages/LogInScreen/login_screen.dart';
import 'package:gold_health/apps/pages/dashboard/dashboard_screen.dart';
import 'package:gold_health/constains.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/enums/app_enums.dart';
import '../data/models/User.dart' as models;
import '../routes/route_name.dart';

class AuthC extends GetxController {
  static AuthC instance = Get.find();
  final _firStore = FirebaseFirestore.instance;
  late Rx<User?> _user;
  User get user => _user.value!;
  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setIntialScreen); // ghe moi khi co su thay doi
  }

  _setIntialScreen(User? user) {
    //if user == null screen will go to Login screen else go to home screen
    if (user == null) {
      Get.toNamed(RouteName.logIn);
    } else {
      Get.toNamed(RouteName.dashboardScreen);
    }
  }

  // Dang ky tai khoan
  Future<String> SignUp({
    required String name,
    required String username,
    required String password,
    required int height,
    required int weight,
    required int heightTarget,
    required int weightTarget,
    required DateTime dateOfBirth,
    required Gender gender,
    required Times duration,
    required Uint8List image,
  }) async {
    String resultString = "Some error";
    try {
      if (username.isNotEmpty && password.isNotEmpty) {
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
            email: username, password: password);
        String avtPath = await StorageMethods().UpLoadImageGroupToStorage(
          'ProfilePic',
          image,
        );
        models.User user = models.User(
          uid: cred.user!.uid,
          name: name,
          username: username,
          password: password,
          height: height,
          weight: weight,
          heightTarget: heightTarget,
          weightTarget: weightTarget,
          dateOfBirth: dateOfBirth,
          gender: gender,
          duration: duration,
          avtPath: avtPath,
        );
        await _firStore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
        resultString = "Create account is success";
        return resultString;
      } else {
        resultString = fieldNull;
        return resultString;
      }
    } on FirebaseAuthException catch (err) {
      // ignore: avoid_print
      print(err.toString());
      return err.toString();
    }
  }
}
