import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_quiz_exam/models/question.dart';
import 'package:flutter_quiz_exam/models/quiz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final quizEditorProvider =
    StateNotifierProvider<QuizEditorProvider, Quiz>((ref) {
  return QuizEditorProvider(ref);
});

class QuizEditorProvider extends StateNotifier<Quiz> {
  Ref ref;
  QuizEditorProvider(this.ref) : super(Quiz(name: '', tags: [], questions: []));

  /// Methods for set new quiz state
  void setQuiz(Quiz quiz) {
    state = quiz;
  }

  /// Methods for update quiz name
  void updateQuizName(String name) {
    state = state.copyWith(name: name);
  }

  /// Methods for update quiz tags
  void updateTags(List<String> tags) {
    state = state.copyWith(tags: tags);
  }

  /// Methods for add a new question
  void addQuestion() {
    final newQuestion = Question(
      text: '',
      options: ['', '', '', ''],
      correctAnswerIndex: 0,
      isTrueOrFalse: false,
    );
    state = state.copyWith(questions: [...state.questions, newQuestion]);
  }

  /// Methods for update questions
  void updateQuestion(int index, Question question) {
    final updatedQuestions = [...state.questions];
    updatedQuestions[index] = question;
    state = state.copyWith(questions: updatedQuestions);
  }

  /// Methods for remove question
  void removeQuestion(int index) {
    final updatedQuestions = [...state.questions]..removeAt(index);
    state = state.copyWith(questions: updatedQuestions);
  }

  /// Methods for save quiz in Firebase
  Future<void> saveQuiz(String id, String name) async {
    final firestore = FirebaseFirestore.instance;
    state = state.copyWith(userId: id, userName: name);
    final quizJson = state.toJsonFirebase();
    if (state.uid == null) {
      await firestore.collection("quizzes").add(quizJson);
    } else {
      await firestore.collection("quizzes").doc(state.uid).set(quizJson);
    }
    state = Quiz(name: "", tags: [], questions: []);
  }
}
