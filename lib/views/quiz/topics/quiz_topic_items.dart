import 'package:flutter/material.dart';
import 'package:flutter_quiz_exam/models/quiz.dart';
import 'package:flutter_quiz_exam/views/quiz/topics/quiz_topic.dart';
// import 'package:quizzapp/shared/progress_bar.dart';

class QuizTopicItems extends StatelessWidget {
  final Quiz quiz;

  const QuizTopicItems({Key? key, required this.quiz}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        clipBehavior: Clip.antiAlias,
        color: Colors.indigo, // à enlever
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => QuizTopic(quiz: quiz),
              ),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                flex: 3,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset(
                    'assets/images/quiz-logo.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      quiz.name,
                      style: const TextStyle(
                        height: 1.5,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      softWrap: false,
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
