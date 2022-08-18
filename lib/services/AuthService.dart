import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signInAnno() async {
    try {
      final response = await _auth.signInAnonymously();
      return response.user;
    } catch (e) {
      print(e.toString());
    }
  }
}
