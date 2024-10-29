import 'package:flutter/material.dart';
import 'package:flutter_quiz_exam/constants/constants.dart';
import 'package:flutter_quiz_exam/models/quiz.dart';
import 'package:go_router/go_router.dart';

class QuizTopicItem extends StatelessWidget {
  final Quiz quiz;

  const QuizTopicItem({required this.quiz, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      shadowColor: const Color(0xffa6fafd),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image placeholder pour l'image du quiz
          Container(
            height: 100,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              image: DecorationImage(
                image:
                    AssetImage('assets/images/gameOver.png'), // Image du quiz
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  quiz.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "${quiz.questionCount} Questions",
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 6,
                  children: quiz.tags.map((tag) {
                    return Chip(
                      label: Text(tag),
                      backgroundColor: colorSecondary(),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Divider(
            color: colorSecondary(),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                context.go('/playquiz/${quiz.uid}');
              },
              child: const Text(
                "Commencer le Quiz",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
