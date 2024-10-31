import 'package:flutter/material.dart';
import 'package:flutter_quiz_exam/layout/quiz_appbar.dart';
import 'package:flutter_quiz_exam/layout/quiz_bottom_navigation.dart';
import 'package:flutter_quiz_exam/logic/provider/firebase_auth_provider.dart';
import 'package:flutter_quiz_exam/logic/provider/user_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuizScaffold extends ConsumerWidget {
  final Widget body;
  QuizScaffold({super.key, required this.body});
  final dynamic _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userCredentials = ref.watch(firebaseNotifier);
    final user = ref.read(userNotifier.notifier);
    void onLoginPressed() {
      if (userCredentials != null) {
        user.logoutFromFirebase();
        context.go('/login');
      }
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: QuizAppbar(
        onLogoutPressed: () => onLoginPressed(),
      ),
      bottomNavigationBar: const QuizBottomNavigation(),
      body: body,
    );
  }
}
