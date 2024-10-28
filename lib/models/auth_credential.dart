import 'package:firebase_auth/firebase_auth.dart';

class AuthCredential {
  final bool isAuth;
  final FirebaseAuth? firebaseAuth;

  AuthCredential({this.isAuth = false, this.firebaseAuth});
}
