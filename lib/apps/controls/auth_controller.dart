import 'dart:typed_data';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/storage_methods.dart.dart';
import 'package:gold_health/apps/data/list_error_string.dart';
import 'package:gold_health/apps/global_widgets/dialog/error_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../data/enums/app_enums.dart';
import '../data/models/user.dart' as models;
import '../routes/route_name.dart';

class AuthC extends GetxController {
  static AuthC instance = Get.find<AuthC>();
  final _firStore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  late Rx<User?> _user;
  User get user => _user.value!;
  late String initialPage;
  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen); // ghe moi khi co su thay doi
  }

  _setInitialScreen(User? user) {
    //if user == null screen will go to Login screen else go to home screen
    if (user == null) {
      //   Get.toNamed(RouteName.logIn);
      initialPage = RouteName.logIn;
    } else {
//      Get.toNamed(RouteName.dashboardScreen);
      initialPage = RouteName.dashboardScreen;
    }
  }

  // Dang ky tai khoan
  Future<String> signUp({
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
          cred.user!.uid,
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
            .set(user.toJson())
            .then((value) async {
          await _firStore
              .collection('users')
              .doc(cred.user!.uid)
              .collection('notification')
              .doc('DlWF8upzR4gdo70OpjUO')
              .set({
            'fCheck': false,
            'list_service': ['null']
          });
          await _firStore
              .collection('users')
              .doc(cred.user!.uid)
              .collection('sleep_basic_time')
              .doc('sleep')
              .set({
            'alarm': DateTime.now(),
            'bedTime': DateTime.now(),
            'isTurnOn': true,
            'isTurnOn1': true,
          });
          await _firStore
              .collection('users')
              .doc(cred.user!.uid)
              .collection('timeEat')
              .doc('time')
              .set({
            'list': [
              DateTime(2022, 10, 10, 6, 30, 0, 0),
              DateTime(2022, 10, 10, 13, 0, 0, 0),
              DateTime(2022, 10, 10, 17, 45, 0, 0),
              DateTime(2022, 10, 10, 19, 30, 0, 0),
            ]
          });
          await _firStore
              .collection('users')
              .doc(cred.user!.uid)
              .collection('water')
              .add({
            'date': DateTime.now(),
            'target': 400,
            'waterConsume': [
              {
                'consume': 0,
                'date': DateTime.now(),
              }
            ],
          });
          DateTime now = DateTime.now();
          DateTime cur = DateTime.now().add(const Duration(days: 7));
          await _firStore
              .collection('users')
              .doc(cred.user!.uid)
              .collection('workout_plan')
              .add({
            'endTime': DateTime(now.year, now.month, now.day, 11, 02, 42, 0),
            'isFinish': false,
            'startTime': DateTime(cur.year, cur.month, cur.day, 11, 02, 42),
            'workoutPlanID': 'YcWnDUmNSYjAQjcgLSf2',
          });
        });
        resultString = "Create account is success";

        return resultString;
      } else {
        resultString = fieldNull;
        Get.dialog(ErrorDialog(question: 'Log In', title1: resultString));
        return resultString;
      }
    } on FirebaseAuthException catch (err) {
      // ignore: avoid_print
      Get.dialog(ErrorDialog(question: 'Log In', title1: err.toString()));
      return err.toString();
    }
  }

  Future<UserCredential?> signInWithEmailAndPassword({
    required String username,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: username, password: password);
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.dialog(const ErrorDialog(
            question: 'Log In', title1: 'No user found for that email'));
      } else if (e.code == 'wrong-password') {
        Get.dialog(const ErrorDialog(
            question: 'Log In',
            title1: 'Wrong password provided for that user'));
      }
      return null;
    }
  }

  // void closeAllStreamOfNotification() {
  //   AwesomeNotifications().actionSink.close();
  //   AwesomeNotifications().createdSink.close();
  //   AwesomeNotifications().dismissedSink.close();
  //   AwesomeNotifications().displayedSink.close();
  // }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
    // closeAllStreamOfNotification();
    Get.offAllNamed(RouteName.logIn);
  }

  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCredential?> signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    } catch (e) {
      return null;
    }
  }
}
