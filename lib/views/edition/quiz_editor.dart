import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_quiz_exam/constants/constants.dart';
import 'package:flutter_quiz_exam/logic/provider/firebase_auth_provider.dart';
import 'package:flutter_quiz_exam/logic/provider/quiz_editor_provider.dart';
import 'package:flutter_quiz_exam/views/edition/widget/quiz_editor_question.dart';
import 'package:flutter_quiz_exam/views/edition/widget/quiz_editor_save.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuizEditor extends HookConsumerWidget {
  final String quizId;
  const QuizEditor(this.quizId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Call provider
    final quiz = ref.watch(quizEditorProvider);
    final quizNotifier = ref.read(quizEditorProvider.notifier);
    final user = ref.watch(firebaseProvider);
    // Variable with hook
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final nameController = useTextEditingController(text: quiz.name);
    final tagsController = useTextEditingController(text: quiz.tags.join(", "));
    final expandedPanels = useState<List<bool>>(
      List.generate(quiz.questions.length, (_) => false),
    );

    // Save a Quiz
    void saveQuiz(VoidCallback onSave) async {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        await quizNotifier.saveQuiz(user!.uid, user.email!);
        onSave();
      }
    }

    // Add a Question
    void addQuestion() {
      quizNotifier.addQuestion();
      expandedPanels.value = [...expandedPanels.value, true];
    }

    // Remouve a Question
    void removeQuestion(int index) {
      quizNotifier.removeQuestion(index);
      expandedPanels.value = [
        for (int i = 0; i < expandedPanels.value.length; i++)
          if (i != index) expandedPanels.value[i]
      ];
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.red,
                  onPressed: () {
                    context.go('/editor');
                  },
                ),
                const SizedBox(width: 10),
              ],
            ),
            //
            const SizedBox(height: 20),
            //
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //
                  TextFormField(
                    controller: nameController,
                    decoration: textFormFieldDecoration("Nom du quiz"),
                    onChanged: (value) => quizNotifier.updateQuizName(value),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Ce champ est requis'
                        : null,
                  ),
                  const SizedBox(height: 15),
                  //
                  TextFormField(
                    controller: tagsController,
                    decoration: textFormFieldDecoration(
                        "Tags (séparés apr des virgules)"),
                    onChanged: (value) {
                      final tags =
                          value.split(',').map((tag) => tag.trim()).toList();
                      quizNotifier.updateTags(tags);
                    },
                  ),
                  //
                  const SizedBox(height: 30),
                  //
                  QuizEditorQuestion(quiz.questionCount, quiz,
                      onAddQuestion: () => addQuestion,
                      onRemoveQuestion: (int index) => removeQuestion(index)),
                  //
                  const SizedBox(height: 20),
                  //
                  QuizEditorSave(
                      onSaveQuiz: () => saveQuiz(
                          () => ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Quiz créé avec succès !')),
                              ))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
