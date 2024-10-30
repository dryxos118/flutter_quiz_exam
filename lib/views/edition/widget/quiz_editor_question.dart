import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_quiz_exam/constants/constants.dart';
import 'package:flutter_quiz_exam/models/quiz.dart';
import 'package:flutter_quiz_exam/views/edition/widget/question_editor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuizEditorQuestion extends HookConsumerWidget {
  final Function() onAddQuestion;
  final Function(int) onRemoveQuestion;
  final int questionCount;
  final Quiz quiz;
  const QuizEditorQuestion(this.questionCount, this.quiz,
      {super.key, required this.onAddQuestion, required this.onRemoveQuestion});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expandedPanels = useState<List<bool>>(
      List.generate(questionCount, (_) => false),
    );
    return Column(
      children: [
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
                if (i == panelIndex) isExpanded else expandedPanels.value[i]
            ];
          },
          dividerColor: Colors.grey[300],
          elevation: 3,
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
                    onPressed: () => onRemoveQuestion(index),
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
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
        const SizedBox(height: 20),
        Center(
          child: questionCount == 10
              ? Text(
                  'Vous avez atteind le maximum de question',
                  style: TextStyle(
                    color: colorSecondary(),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : TextButton.icon(
                  onPressed: onAddQuestion,
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
      ],
    );
  }
}
