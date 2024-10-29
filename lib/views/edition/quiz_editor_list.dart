import 'package:flutter/material.dart';
import 'package:flutter_quiz_exam/constants/constants.dart';
import 'package:flutter_quiz_exam/logic/provider/quiz_editor_provider.dart';
import 'package:flutter_quiz_exam/models/quiz.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuizEditorList extends HookConsumerWidget {
  const QuizEditorList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<List<Quiz>> getQuizzes() async {
      final t = await ref.read(quizProvider.notifier).getQuizByName();
      print(t);
      return t;
    }

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
      body: FutureBuilder<List<Quiz>>(
        future: getQuizzes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Aucun quiz disponible',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xffa6fafd),
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }

          final quizList = snapshot.data!;

          return ListView.builder(
            itemCount: quizList.length,
            itemBuilder: (context, index) {
              final quiz = quizList[index];
              return ListTile(
                title: Text(
                  quiz.name,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text("${quiz.questions.length} questions"),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  ref.read(quizProvider.notifier).setQuiz(quiz);
                  context.go('/quizeditor');
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action à réaliser lors de l'appui sur le bouton
          // context.go('/createquiz');
        },
        tooltip: 'Créer un quiz',
        backgroundColor: colorSecondary(),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
