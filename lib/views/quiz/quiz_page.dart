import 'package:flutter/material.dart';
import 'package:flutter_quiz_exam/models/quiz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_quiz_exam/views/quiz/topics/quiz_topic_items.dart';
import 'package:flutter_quiz_exam/data/quiz_data.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({Key? key}) : super(key: key);

  Future<List<Quiz>> getQuizs() async {
    return getQuiz();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Quiz>>(
      future: getQuizs(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // return const LoadingScreen();
          return Text("load");
        } else if (snapshot.hasError) {
          // return ErrorMessage(message: snapshot.error.toString());
          return Text("error");
        } else if (snapshot.hasData) {
          var topics = snapshot.data!;
          return Scaffold(
            body: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(5),
              crossAxisSpacing: 10,
              crossAxisCount: 2,
              children:
                  topics.map((topic) => QuizTopicItems(quiz: topic)).toList(),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: Text('No topics found in Firestore. Check database'),
            ),
          );
        }
      },
    );
  }
}
