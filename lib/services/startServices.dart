import 'package:firebase_core/firebase_core.dart';

class StartService {
  StartService._privateConstructor();
  static final StartService instance = StartService._privateConstructor();
  init() async {
    await Firebase.initializeApp();
  }
}
