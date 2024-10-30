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

    return Stack(
      children: [
        Column(
          children: [
            // Titre de la page
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  "Éditeur de Quiz",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: quizzes.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Aucun quiz disponible',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffa6fafd),
                            ),
                          ),
                          const SizedBox(height: 10),
                          IconButton(
                            onPressed: () async {
                              await ref
                                  .read(quizListEditorProvider.notifier)
                                  .getQuizzesByUser();
                            },
                            icon: const Icon(Icons.replay_outlined),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: quizzes.length,
                      itemBuilder: (context, index) {
                        final quiz = quizzes[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          shadowColor: const Color(0xffa6fafd),
                          elevation: 4,
                          child: Padding(
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
                                  "${quiz.questions.length} Questions",
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.grey),
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
                                Divider(
                                  color: colorSecondary(),
                                ),
                                // Alignement des boutons
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        if (quiz.uid != null) {
                                          ref
                                              .read(quizListEditorProvider
                                                  .notifier)
                                              .deleteQuiz(quiz.uid!);
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    'Erreur : ID du quiz introuvable')),
                                          );
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors
                                            .red, // Couleur du texte en rouge
                                      ),
                                      child: const Text(
                                        "Supprimer le quiz",
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        ref
                                            .read(quizProvider.notifier)
                                            .setQuiz(quiz);
                                        context.go('/quizeditor');
                                      },
                                      child: const Text(
                                        "Éditer le quiz",
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 0),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: () {
              ref
                  .read(quizListEditorProvider.notifier)
                  .createQuiz("Quiz_${quizzes.length}");
              context.go('/quizeditor');
            },
            tooltip: 'Créer un quiz',
            backgroundColor: colorSecondary(),
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
