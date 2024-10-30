import 'package:flutter/material.dart';
import 'package:flutter_quiz_exam/logic/provider/user_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LastQuizzes extends ConsumerWidget {
  const LastQuizzes({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final leaderboard = user?.leaderboard.take(5).toList() ?? [];

    print("User: $user");
    print("Leaderboard: $leaderboard");

    return ListView.builder(
      itemCount: leaderboard.length,
      itemBuilder: (context, index) {
        final quiz = leaderboard[index];
        return ListTile(
          title: Text(quiz.quizName),
          subtitle: Text("Score: ${quiz.score}"),
          trailing: quiz.isAbandoned
              ? const Text("Abandonné", style: TextStyle(color: Colors.red))
              : null,
        );
      },
    );
  }
}
