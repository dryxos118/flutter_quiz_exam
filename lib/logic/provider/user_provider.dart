import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_quiz_exam/models/leaderboard.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_quiz_exam/models/user.dart' as app;
import 'package:flutter_quiz_exam/logic/provider/firebase_auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = StateProvider<app.User?>((ref) => null);

final userNotifier =
    StateNotifierProvider<UserNotifier, app.User?>((ref) => UserNotifier(ref));

class UserNotifier extends StateNotifier<app.User?> {
  Ref ref;
  UserNotifier(this.ref) : super(null);

  Future<bool> registerInFirebase(
      {required app.User user,
      required String email,
      required String password}) async {
    await ref
        .read(firebaseNotifier.notifier)
        .register(email: email, password: password)
        .then((value) async {
      if (value != null && value.user != null) {
        user.uid = value.user!.uid;
        await createNewUser(user: user);
        return true;
      }
    }, onError: (error) => false);
    return false;
  }

  Future<void> createNewUser({required app.User user}) async {
    try {
      await FirebaseFirestore.instance
          .collection('user')
          .doc(user.uid)
          .set(user.toSnapshot());
      state = user;
    } catch (e) {
      print(e);
    }
  }

  Future<bool> loginInFirebase(
      {required String email, required String password}) async {
    try {
      final userCredential = await ref
          .read(firebaseNotifier.notifier)
          .login(email: email, password: password);
      if (userCredential != null && userCredential.user != null) {
        final snapshot = await FirebaseFirestore.instance
            .collection('user')
            .doc(userCredential.user!.uid)
            .get();
        if (snapshot.exists) {
          state =
              app.User.fromSnapshot(snapshot.data(), userCredential.user!.uid);
          return true;
        }
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

  Future<void> addQuizToLeaderboard({
    required String quizUid,
    required String quizName,
    required int score,
    required bool isAbandoned,
  }) async {
    if (state != null) {
      final quizLeaderboardEntry = Leaderboard(
        quizUid: quizUid,
        quizName: quizName,
        score: score,
        isAbandoned: isAbandoned,
      );

      state!.leaderboard.insert(0, quizLeaderboardEntry);
      if (state!.leaderboard.length > 5) {
        state!.leaderboard.removeLast();
      }

      state = state;

      await FirebaseFirestore.instance
          .collection('user')
          .doc(state!.uid)
          .update({
        'leaderboard': state!.leaderboard.map((q) => q.toJson()).toList(),
      });
    }
  }
}
