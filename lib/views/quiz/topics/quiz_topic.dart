import 'package:flutter/material.dart';
import 'package:flutter_quiz_exam/models/quiz.dart';
import 'package:flutter_quiz_exam/models/question.dart';

class QuizTopic extends StatelessWidget {
  final Quiz quiz;
  const QuizTopic({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.white,
      ),
      margin: const EdgeInsets.all(30.0),
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          const SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.asset(
                'assets/images/quiz-logo.png',
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.4,
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          ..._buildQuestions(
              quiz.questions), // Afficher les questions et options
        ],
      ),
    );
  }

  List<Widget> _buildQuestions(List<Question> questions) {
    if (questions.isNotEmpty) {
      return [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                questions[0].text, // Affiche le texte de la première question
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              _buildOptions(questions[0]
                  .options), // Affiche les options de la première question
            ],
          ),
        ),
      ];
    } else {
      return [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
          child: Text(
            "Aucune question disponible.",
            style: TextStyle(fontSize: 18),
          ),
        ),
      ];
    }
  }

  Widget _buildOptions(List<String> options) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 30.0,
        mainAxisSpacing: 0,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: options.length,
      itemBuilder: (context, index) {
        return Padding(
          padding:
              const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 0, right: 0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                options[index],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      },
    );
  }
}
