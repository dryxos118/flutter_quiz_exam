import 'package:flutter/material.dart';
import 'package:flutter_quiz_exam/logic/provider/user_provider.dart';
import 'package:flutter_quiz_exam/views/profile/last_quiz_card.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LastQuizzes extends ConsumerWidget {
  const LastQuizzes({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userNotifier);
    final leaderboard = user?.leaderboard ?? [];

    return leaderboard.isEmpty
        ? const Center(
            child: Text("Il n'y a pas de partie jouée"),
          )
        : ListView.builder(
            itemCount: leaderboard.length,
            itemBuilder: (context, index) {
              final quiz = leaderboard[index];
              return LastQuizCard(quiz: quiz);
            },
          );
  }
}
