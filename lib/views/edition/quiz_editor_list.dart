import 'package:flutter/material.dart';
import 'package:flutter_quiz_exam/constants/constants.dart';
import 'package:flutter_quiz_exam/logic/provider/quiz_editor_provider.dart';
import 'package:flutter_quiz_exam/logic/provider/quiz_list_editor_provicer.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuizEditorList extends HookConsumerWidget {
  const QuizEditorList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Récupérer les quizzes à partir du provider
    ref.read(quizListEditorProvider.notifier).getQuizzesByUser();

    // Écouter les quizzes
    final quizzes = ref.watch(quizListEditorProvider);

    return Scaffold(
      appBar: AppBar(
        title: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Center(
            child: Text(
              'Éditeur de Quiz',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
      body: quizzes.isEmpty
          ? const Center(
              child: Text(
                'Aucun quiz disponible',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xffa6fafd),
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : ListView.builder(
              itemCount: quizzes.length,
              itemBuilder: (context, index) {
                final quiz = quizzes[index];
                return ListTile(
                  title: Text(
                    quiz.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text("${quiz.questions.length} questions"),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    ref.read(quizProvider.notifier).setQuiz(quiz);
                    context.go('/quizeditor');
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Créer un quiz',
        backgroundColor: colorSecondary(),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
