import 'package:firebase_auth/firebase_auth.dart';

import '../apps/data/enums/app_enums.dart';

class AuthService {
  AuthService._privateConstructor();
  static final AuthService instance = AuthService._privateConstructor();
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  User? get currentUser => FirebaseAuth.instance.currentUser;
  bool get isLogin => currentUser == null ? false : true;
  SignInType loginType = SignInType.none;
  Future signInAnno() async {
    try {
      final response = await _auth.signInAnonymously();
      return response.user;
    } catch (e) {
      print(e.toString());
    }
  }
}
