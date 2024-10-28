import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

final firebaseProvider = StateProvider<User?>((ref) => null);

final firebaseNotifier = StateNotifierProvider<FirebaseProvider, FirebaseAuth?>(
    (ref) => FirebaseProvider(ref));

class FirebaseProvider extends StateNotifier<FirebaseAuth?> {
  Ref ref;
  FirebaseProvider(this.ref) : super(null);

  Future<void> initialize() async {
    state = FirebaseAuth.instance;
    if (state != null) {
      state!.authStateChanges().listen(
        (User? user) {
          if (user == null) {
            ref.read(firebaseProvider.notifier).state = null;
          } else {
            ref.read(firebaseProvider.notifier).state = user;
          }
        },
      );
    }
  }

  Future<UserCredential?> register(
      {required String email, required String password}) async {
    try {
      final t = await state!.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('résultat : $t');
      return t;
    } on FirebaseAuthException catch (e) {
      print(e.message);
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<bool> logout() async {
    try {
      await state!.signOut();
      return true;
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
    return false;
  }

  Future<UserCredential?> login(
      {required String email, required String password}) async {
    try {
      var t = await state!.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(state);
      return t;
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
    return null;
  }
}
