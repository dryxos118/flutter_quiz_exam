import 'package:flutter/material.dart';
import 'package:flutter_quiz_exam/constants/constants.dart';
import 'package:flutter_quiz_exam/logic/provider/user_provider.dart';
import 'package:flutter_quiz_exam/models/leaderboard.dart';
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
              return QuizCard(quiz: quiz);
            },
          );
  }
}

class QuizCard extends StatelessWidget {
  const QuizCard({super.key, required this.quiz});

  final Leaderboard quiz;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colorPrimary(),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0xffa6fafd),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Image.asset(
              'assets/images/gameOver.png',
              fit: BoxFit.cover,
              width: 100,
              height: 100,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    quiz.quizName,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Score: ${quiz.score}',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  if (quiz.isAbandoned)
                    const Text(
                      "Abandonné",
                      style: TextStyle(color: Colors.red),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
