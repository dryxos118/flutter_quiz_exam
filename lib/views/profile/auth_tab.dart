import 'package:flutter/material.dart';
import 'package:flutter_quiz_exam/views/profile/last_quizzes.dart';
import 'package:flutter_quiz_exam/views/profile/user_info.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthTab extends ConsumerWidget {
  const AuthTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(text: 'Informations utilisateur'),
                Tab(text: 'Derniers quiz joués'),
              ],
              labelColor: Color(0xffa6fafd),
              indicatorColor: Color(0xffa6fafd),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  UserInfo(),
                  LastQuizzes(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
