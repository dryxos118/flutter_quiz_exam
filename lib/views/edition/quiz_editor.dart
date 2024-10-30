import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_quiz_exam/logic/provider/firebase_auth_provider.dart';
import 'package:flutter_quiz_exam/logic/provider/quiz_editor_provider.dart';
import 'package:flutter_quiz_exam/views/edition/question_editor.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuizEditor extends HookConsumerWidget {
  final String quizId;
  const QuizEditor(this.quizId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quiz = ref.watch(quizProvider);
    final quizNotifier = ref.read(quizProvider.notifier);
    final user = ref.watch(firebaseProvider);

    final formKey = useMemoized(() => GlobalKey<FormState>());
    final nameController = useTextEditingController(text: quiz.name);
    final tagsController = useTextEditingController(text: quiz.tags.join(", "));

    // Initialisation de l'état d'expansion
    final expandedPanels = useState<List<bool>>(
      List.generate(quiz.questions.length, (_) => false),
    );

    void saveQuiz() async {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        await quizNotifier.saveQuiz(user!.uid, user.email!);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Quiz créé avec succès !')),
        );
      }
    }

    // Gestion de l'ajout de question
    void addQuestion() {
      quizNotifier.addQuestion();
      expandedPanels.value = [
        ...expandedPanels.value,
        true
      ]; // La nouvelle question est étendue par défaut
    }

    // Gestion de la suppression de question
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
            const SizedBox(height: 30),
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Nom du Quiz',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: quizNotifier.updateQuizName,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Ce champ est requis'
                        : null,
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: tagsController,
                    decoration: InputDecoration(
                      labelText: 'Tags (séparés par des virgules)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: (value) {
                      final tags =
                          value.split(',').map((tag) => tag.trim()).toList();
                      quizNotifier.updateTags(tags);
                    },
                  ),
                  const SizedBox(height: 30),
                  const Center(
                    child: Text(
                      'Questions',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ExpansionPanelList(
                    expansionCallback: (panelIndex, isExpanded) {
                      expandedPanels.value = [
                        for (int i = 0; i < expandedPanels.value.length; i++)
                          if (i == panelIndex)
                            isExpanded
                          else
                            expandedPanels.value[i]
                      ];
                    },
                    dividerColor: Colors.grey[300],
                    children: quiz.questions.asMap().entries.map((entry) {
                      int index = entry.key;
                      return ExpansionPanel(
                        headerBuilder: (context, isExpanded) {
                          return ListTile(
                            title: Text(
                              'Question ${index + 1}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            leading: IconButton(
                              onPressed: () => removeQuestion(index),
                              icon: const Icon(Icons.delete,
                                  color: Colors.redAccent),
                            ),
                          );
                        },
                        body: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: QuestionEditor(index),
                        ),
                        isExpanded: expandedPanels.value[index],
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: TextButton.icon(
                      onPressed: addQuestion,
                      icon: const Icon(Icons.add, color: Colors.blueAccent),
                      label: const Text(
                        'Ajouter une Question',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 32,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        saveQuiz();
                        context.go('/editor');
                      },
                      child: const Text(
                        'Enregistrer le Quiz',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
