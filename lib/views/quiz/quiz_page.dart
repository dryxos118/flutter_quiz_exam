import 'package:flutter/material.dart';
import 'package:flutter_quiz_exam/data/quiz_data.dart';
import 'package:flutter_quiz_exam/logic/provider/quiz_games_stream_provider.dart';
import 'package:flutter_quiz_exam/models/quiz.dart';
import 'package:flutter_quiz_exam/views/quiz/topic/quiz_topic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizPage extends ConsumerWidget {
  const QuizPage({super.key});

  Future<List<Quiz>> getQuizs() async {
    return getQuiz();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizStream = ref.watch(quizGamesStreamProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: quizStream.when(
            data: (quizList) => quizList.isNotEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: quizList.length,
                    itemBuilder: (context, index) {
                      return QuizTopicItem(quiz: quizList[index]);
                    },
                  )
                : Center(
                    child: IconButton(
                        onPressed: () async {
                          await ref
                              .read(quizGamesStreamProvider.notifier)
                              .initializeDb();
                        },
                        icon: const Icon(Icons.replay_outlined))),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("Erreur : $error"),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
