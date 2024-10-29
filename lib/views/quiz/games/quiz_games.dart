import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_quiz_exam/logic/provider/quiz_games_stream_provider.dart';
import 'package:flutter_quiz_exam/views/quiz/games/quiz_options.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quickalert/quickalert.dart';

class QuizGames extends HookConsumerWidget {
  final String quizId;

  const QuizGames({super.key, required this.quizId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quiz = ref.watch(quizGamesStreamProvider.select((quizList) =>
        quizList.value!.firstWhere((quiz) => quiz.uid == quizId)));
    final currentQuestionIndex = useState(0);
    final userAnswers =
        useState<List<String?>>(List.filled(quiz.questions.length, null));
    final score = useState(0);

    void nextQuestion(String selectedAnswer) {
      userAnswers.value[currentQuestionIndex.value] = selectedAnswer;
      final indexAnswer = quiz.questions[currentQuestionIndex.value].options
          .indexOf(selectedAnswer);

      // Vérifie si la réponse est correcte
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
        ));
      }

      // Passe à la question suivante
      if (currentQuestionIndex.value < quiz.questions.length - 1) {
        currentQuestionIndex.value += 1;
      } else {
        QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            widget: AlertDialog(
              title: const Text('Quiz Terminé'),
              content:
                  Text('Votre score: ${score.value}/${quiz.questions.length}'),
            ),
            confirmBtnText: "Ok",
            onConfirmBtnTap: () {
              Navigator.pop(context);
              context.go("/quiz");
            });
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

    // Récupère la question actuelle
    final currentQuestion = quiz.questions[currentQuestionIndex.value];

    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, bottom: 50, top: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                quiz.name,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                'Question ${currentQuestionIndex.value + 1} sur ${quiz.questions.length}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  currentQuestion.text,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 10),
            QuizOptions(
              currentQuestion.options,
              currentQuestion.correctAnswerIndex,
              (String value) {
                nextQuestion(value);
              },
            ),
            const Spacer(),
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
    );
  }
}
