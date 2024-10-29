import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_quiz_exam/data/quiz_data.dart';
import 'package:flutter_quiz_exam/models/quiz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final quizGamesStreamProvider =
    StreamNotifierProvider<QuizGamesStreamProvider, List<Quiz>>(
        QuizGamesStreamProvider.new);

class QuizGamesStreamProvider extends StreamNotifier<List<Quiz>> {
  @override
  Stream<List<Quiz>> build() {
    return FirebaseFirestore.instance.collection('quizzes').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Quiz.fromDocument(doc)).toList());
  }

  Future<Quiz> getQuizById({String? id, String? name}) async {
    if (state.hasValue) {
      if (id!.isNotEmpty) {
        return state.value!.firstWhere((x) => x.uid == id);
      } else if (name!.isNotEmpty) {
        return state.value!.firstWhere((x) => x.name == name);
      } else {
        return state.value!.first;
      }
    } else {
      print("Pas de data");
      return Quiz(name: "", tags: [], questions: []);
    }
  }

  Future<void> initializeDb() async {
    final quizzes = getQuiz();

    await FirebaseFirestore.instance
        .collection('quizzes')
        .add(quizzes.first.toJsonFirebase());
  }
}
