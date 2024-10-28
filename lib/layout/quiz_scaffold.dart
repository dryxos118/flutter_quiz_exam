import 'package:flutter/material.dart';
import 'package:flutter_quiz_exam/layout/quiz_appbar.dart';
import 'package:flutter_quiz_exam/layout/quiz_bottom_navigation.dart';
import 'package:flutter_quiz_exam/logic/provider/firebase_auth_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuizScaffold extends ConsumerWidget {
  final Widget body;
  QuizScaffold({super.key, required this.body});
  final dynamic _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(firebaseProvider);
    void onLoginPressed() {
      print(user);
      if (user != null) {
        print("logout");
        ref.read(firebaseNotifier.notifier).logout();
        context.go("/login");
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
