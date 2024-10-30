import 'package:flutter/material.dart';
import 'package:flutter_quiz_exam/constants/constants.dart';
import 'package:flutter_quiz_exam/logic/provider/quiz_editor_provider.dart';
import 'package:flutter_quiz_exam/models/question.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MultipleChoiceOptionEditor extends ConsumerWidget {
  final Question question;
  final int questionIndex;

  const MultipleChoiceOptionEditor({
    super.key,
    required this.question,
    required this.questionIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Récupération de l'instance de notifier via ConsumerWidget
    final quizNotifier = ref.read(quizEditorProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...List.generate(4, (i) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: TextFormField(
              initialValue: question.options[i],
              decoration: textFormFieldDecoration("Réponse ${i + 1}"),
              onChanged: (value) {
                final updatedOptions = [...question.options];
                updatedOptions[i] = value;
                quizNotifier.updateQuestion(
                  questionIndex,
                  question.copyWith(options: updatedOptions),
                );
              },
              validator: (value) =>
                  value == null || value.isEmpty ? 'Ce champ est requis' : null,
            ),
          );
        }),
        const SizedBox(height: 10),
        DropdownButtonFormField<int>(
          decoration: textFormFieldDecoration("Choisissez la bonne réponse"),
          value: question.correctAnswerIndex,
          items: List.generate(
            question.options.length,
            (i) => DropdownMenuItem(
              value: i,
              child: Text(question.options[i]),
            ),
          ),
          onChanged: (value) {
            quizNotifier.updateQuestion(
              questionIndex,
              question.copyWith(correctAnswerIndex: value ?? 0),
            );
          },
        ),
      ],
    );
  }
}
