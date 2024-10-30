import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_quiz_exam/logic/provider/firebase_auth_provider.dart';
import 'package:flutter_quiz_exam/logic/provider/quiz_editor_provider.dart';
import 'package:flutter_quiz_exam/models/quiz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loadingProvider = StateProvider<bool>((ref) => true);

final quizListEditorProvider =
    StateNotifierProvider<QuizListEditorProvider, List<Quiz>>(
        (ref) => QuizListEditorProvider(ref));

class QuizListEditorProvider extends StateNotifier<List<Quiz>> {
  Ref ref;
  QuizListEditorProvider(this.ref) : super([]);

  Future<void> getQuizzesByUser() async {
    final firestore = FirebaseFirestore.instance;
    final user = ref.watch(firebaseProvider);
    state = await firestore
        .collection('quizzes')
        .where('userId', isEqualTo: user!.uid)
        .get()
        .then((snapshots) {
      return List<Quiz>.from(
        snapshots.docs
            .map(
              (doc) => Quiz.fromDocument(doc),
            )
            .toList(),
      );
    });
  }

// Méthode pour créer un quiz
  Future<void> createQuiz(String name) async {
    final user = ref.watch(firebaseProvider);
    ref.read(quizProvider.notifier).setQuiz(Quiz(
        name: name,
        tags: [],
        questions: [],
        userId: user!.uid,
        userName: user.email));
  }

  // Méthode pour delete un quiz
  Future<void> deleteQuiz(String id) async {
    final firestore = FirebaseFirestore.instance;
    await firestore.collection("quizzes").doc(id).delete();
  }
}
