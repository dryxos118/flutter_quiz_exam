import 'package:flutter/material.dart';
import 'package:flutter_quiz_exam/layout/quiz_bottom_navigation.dart';
import 'package:flutter_quiz_exam/views/profile/auth_tab.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      bottomNavigationBar: const QuizBottomNavigation(),
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: const AuthTab(),
    );
  }
}
