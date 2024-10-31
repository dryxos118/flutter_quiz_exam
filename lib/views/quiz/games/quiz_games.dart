import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_quiz_exam/logic/provider/quiz_games_stream_provider.dart';
import 'package:flutter_quiz_exam/logic/provider/user_provider.dart';
import 'package:flutter_quiz_exam/models/leaderboard.dart';
import 'package:flutter_quiz_exam/views/quiz/games/widget/quiz_options.dart';
import 'package:flutter_quiz_exam/views/quiz/games/widget/quiz_question.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quickalert/quickalert.dart';

class QuizGames extends HookConsumerWidget {
  final String quizId;

  const QuizGames({super.key, required this.quizId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Quiz with the quizId
    final quiz = ref.watch(quizGamesStreamProvider.select((quizList) =>
        quizList.value!.firstWhere((quiz) => quiz.uid == quizId)));
    // Index for current question
    final currentQuestionIndex = useState(0);
    // Score of the quiz
    final score = useState(0);

    // Pass on the next Question
    void nextQuestion(String selectedAnswer) {
      final indexAnswer = quiz.questions[currentQuestionIndex.value].options
          .indexOf(selectedAnswer);
      if (indexAnswer ==
          quiz.questions[currentQuestionIndex.value].correctAnswerIndex) {
        score.value += 1;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "Mauvaise reponse",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xff00696c),
          duration: Duration(seconds: 1),
        ));
      }
      if (currentQuestionIndex.value < quiz.questions.length - 1) {
        currentQuestionIndex.value += 1;
      } else {
        final leaderboard = Leaderboard(
            quizUid: quiz.uid ?? quizId,
            quizName: quiz.name,
            score: score.value,
            questionCount: quiz.questionCount,
            isAbandoned: false);
        ref.read(userNotifier.notifier).addQuizToLeaderboard(leaderboard);
        showScoreDialog(context, score.value, quiz.questionCount);
      }
    }

    void showAbandonedDialog() {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Abandonner le Quiz'),
          content: const Text("Êtes-vous sûr de vouloir abandonner ce quiz ?"),
          actions: [
            TextButton(
              onPressed: () {
                if (currentQuestionIndex.value > 0) {
                  final leaderboard = Leaderboard(
                      quizUid: quiz.uid ?? quizId,
                      quizName: quiz.name,
                      score: score.value,
                      questionCount: quiz.questionCount,
                      isAbandoned: true);
                  ref
                      .read(userNotifier.notifier)
                      .addQuizToLeaderboard(leaderboard);
                }
                Navigator.pop(context);
                context.go("/quiz");
              },
              child: const Text('Oui, abandonner',
                  style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Continuer',
                  style: TextStyle(color: Colors.green)),
            ),
          ],
        ),
      );
    }

    final currentQuestion = quiz.questions[currentQuestionIndex.value];
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 70),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              QuizQuestion(
                questionIndex: currentQuestionIndex.value,
                questionText: currentQuestion.text,
                questionsCount: quiz.questionCount,
                quizName: quiz.name,
              ),
              const SizedBox(height: 10),
              QuizOptions(
                currentQuestion.options,
                currentQuestion.correctAnswerIndex,
                (String value) {
                  nextQuestion(value);
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: TextButton(
                  onPressed: () => showAbandonedDialog(),
                  child: const Text(
                    'Voulez-vous abandonner ?',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showScoreDialog(BuildContext context, int score, int questionCount) {
  QuickAlert.show(
      context: context,
      type: score >= questionCount / 2
          ? QuickAlertType.success
          : QuickAlertType.error,
      widget: AlertDialog(
        title: const Text('Quiz Terminé'),
        content: Text('Votre score: $score/$questionCount'),
      ),
      confirmBtnText: "Ok",
      onConfirmBtnTap: () {
        Navigator.pop(context);
        context.go("/quiz");
      });
}
