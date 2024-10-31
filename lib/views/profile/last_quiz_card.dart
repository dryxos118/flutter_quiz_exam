import 'package:flutter/material.dart';
import 'package:flutter_quiz_exam/constants/constants.dart';
import 'package:flutter_quiz_exam/logic/provider/bottom_nav_provider.dart';
import 'package:flutter_quiz_exam/models/leaderboard.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LastQuizCard extends ConsumerWidget {
  const LastQuizCard({super.key, required this.quiz});
  final Leaderboard quiz;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: colorPrimary(),
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/gameOver.png',
              fit: BoxFit.cover,
              width: 90,
              height: 120,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        quiz.quizName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      if (quiz.isAbandoned) ...{
                        const SizedBox(width: 8),
                        const Icon(Icons.warning, color: Colors.redAccent),
                      },
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Score: ${quiz.score}/${quiz.questionCount}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          ref
                              .read(bottomNavIndexProvider.notifier)
                              .updateIndex(0);
                          context.go('/playquiz/${quiz.quizUid}');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorSecondary(),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                          ),
                        ),
                        child: const Text(
                          'Accéder',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
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
