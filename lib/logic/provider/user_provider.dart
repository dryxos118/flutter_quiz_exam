import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_quiz_exam/models/leaderboard.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_quiz_exam/models/user.dart' as app;
import 'package:flutter_quiz_exam/logic/provider/firebase_auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userNotifier =
    StateNotifierProvider<UserNotifier, app.User?>((ref) => UserNotifier(ref));

class UserNotifier extends StateNotifier<app.User?> {
  Ref ref;
  UserNotifier(this.ref) : super(null);

  Future<bool> registerInFirebase(String email, String password) async {
    await ref
        .read(firebaseNotifier.notifier)
        .register(email: email, password: password)
        .then((value) async {
      if (value != null && value.user != null) {
        final user = app.User(email: value.user!.email);
        await createNewUser(user);
        return true;
      }
    }, onError: (error) => false);
    return false;
  }

  Future<void> createNewUser(app.User user) async {
    try {
      var test = await FirebaseFirestore.instance
          .collection('users')
          .add(user.toSnapshot());
      state = user.copyWith(uid: test.id);
    } catch (e) {
      print(e);
    }
  }

  Future<bool> loginInFirebase(String email, String password) async {
    try {
      final userCredential = await ref
          .read(firebaseNotifier.notifier)
          .login(email: email, password: password);
      if (userCredential != null && userCredential.user != null) {
        final snapshot = await FirebaseFirestore.instance
            .collection('users')
            .where("email", isEqualTo: email)
            .get();
        state = app.User.fromSnapshot(snapshot.docs.first.data());
        return true;
      }
    } catch (error) {
      print(error);
    }
    return false;
  }

  Future<bool> logoutFromFirebase() async {
    try {
      await ref.read(firebaseNotifier.notifier).logout();
      state = null;
      return true;
    } catch (error) {
      print(error);
    }
    return false;
  }

  Future<void> addQuizToLeaderboard(Leaderboard quizLeaderboardEntry) async {
    if (state != null) {
      final updatedLeaderboard = List<Leaderboard>.from(state!.leaderboard);
      updatedLeaderboard.add(quizLeaderboardEntry);

      if (updatedLeaderboard.length > 10) {
        updatedLeaderboard.removeAt(0);
      }

      state = state!.copyWith(leaderboard: updatedLeaderboard);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(state!.uid)
          .set(state!.toSnapshot());
    }
  }
}
