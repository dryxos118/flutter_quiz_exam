import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_quiz_exam/logic/provider/firebase_auth_provider.dart';
import 'package:flutter_quiz_exam/models/question.dart';
import 'package:flutter_quiz_exam/models/quiz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Provider pour gérer l'état du quiz
final quizProvider = StateNotifierProvider<QuizEditorProvider, Quiz>((ref) {
  return QuizEditorProvider(ref);
});

class QuizEditorProvider extends StateNotifier<Quiz> {
  Ref ref;
  QuizEditorProvider(this.ref) : super(Quiz(name: '', tags: [], questions: []));

  void setQuiz(Quiz quiz) {
    state = quiz;
  }

  // Méthode pour mettre à jour le nom du quiz
  void updateQuizName(String name) {
    state = state.copyWith(name: name);
  }

  // Méthode pour mettre à jour les tags du quiz
  void updateTags(List<String> tags) {
    state = state.copyWith(tags: tags);
  }

  // Méthode pour ajouter une question
  void addQuestion() {
    final newQuestion = Question(
      text: '',
      options: ['', '', '', ''],
      correctAnswerIndex: 0,
      isTrueOrFalse: false,
    );
    state = state.copyWith(questions: [...state.questions, newQuestion]);
  }

  // Méthode pour mettre à jour une question
  void updateQuestion(int index, Question question) {
    final updatedQuestions = [...state.questions];
    updatedQuestions[index] = question;
    state = state.copyWith(questions: updatedQuestions);
  }

  void removeQuestion(int index) {
    final updatedQuestions = [...state.questions]..removeAt(index);
    state = state.copyWith(questions: updatedQuestions);
  }

  Future<void> saveQuiz(String id, String name) async {
    final firestore = FirebaseFirestore.instance;
    state = state.copyWith(userId: id, userName: name);
    final quizJson = state.toJsonFirebase();
    await firestore.collection("quizzes").add(quizJson);
    state = Quiz(name: "", tags: [], questions: []);
  }

  Future<List<Quiz>> getQuizByName() async {
    final firestore = FirebaseFirestore.instance;
    final user = ref.watch(firebaseProvider);
    final quizzes = firestore
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
    return quizzes;
  }
}
