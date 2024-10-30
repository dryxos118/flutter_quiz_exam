import 'package:flutter/material.dart';

class QuizQuestion extends StatelessWidget {
  final int questionIndex;
  final int questionsCount;
  final String questionText;
  final String quizName;

  const QuizQuestion(
      {super.key,
      required this.questionIndex,
      required this.questionText,
      required this.questionsCount,
      required this.quizName});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            quizName,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: Text(
            'Question ${questionIndex + 1} sur $questionsCount',
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
              questionText,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
