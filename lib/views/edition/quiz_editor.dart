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
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Bouton de retour
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    context.go('/editor'); // Retourne à la page précédente
                  },
                ),
                const Spacer(),
                Text(quiz.name, style: const TextStyle(fontSize: 18)),
              ],
            ),
            const SizedBox(height: 20),
            Form(
              key: formKey,
              child: ListView(
                shrinkWrap: true, // Important pour les ListView imbriquées
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Nom du Quiz'),
                    onChanged: quizNotifier.updateQuizName,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Ce champ est requis'
                        : null,
                  ),
                  TextFormField(
                    controller: tagsController,
                    decoration: const InputDecoration(
                        labelText: 'Tags (séparés par des virgules)'),
                    onChanged: (value) {
                      final tags =
                          value.split(',').map((tag) => tag.trim()).toList();
                      quizNotifier.updateTags(tags);
                    },
                  ),
                  const SizedBox(height: 20),
                  const Center(
                    child: Text('Questions',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
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
                    children: quiz.questions.asMap().entries.map((entry) {
                      int index = entry.key;
                      return ExpansionPanel(
                        headerBuilder: (context, isExpanded) {
                          return ListTile(
                            title: Text('Question ${index + 1}'),
                            leading: IconButton(
                              onPressed: () => removeQuestion(index),
                              icon: const Icon(Icons.delete, color: Colors.red),
                            ),
                          );
                        },
                        body: QuestionEditor(
                            index), // Remplacez cela par votre éditeur de question
                        isExpanded: expandedPanels.value[index],
                      );
                    }).toList(),
                  ),
                  TextButton(
                    onPressed: addQuestion,
                    child: const Text('Ajouter une Question'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: saveQuiz,
                    child: const Text('Enregistrer le Quiz'),
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
