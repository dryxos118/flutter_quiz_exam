import 'package:flutter/material.dart';
import 'package:flutter_quiz_exam/logic/provider/quiz_editor_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuestionEditor extends HookConsumerWidget {
  final int questionIndex;
  const QuestionEditor(this.questionIndex, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final question = ref.watch(quizProvider).questions[questionIndex];
    final quizNotifier = ref.read(quizProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          initialValue: question.text,
          decoration: InputDecoration(
              labelText: 'Texte de la question ${questionIndex + 1}'),
          onChanged: (value) => quizNotifier.updateQuestion(
            questionIndex,
            question.copyWith(text: value),
          ),
          validator: (value) =>
              value == null || value.isEmpty ? 'Ce champ est requis' : null,
        ),
        Row(
          children: [
            Checkbox(
              value: question.isTrueOrFalse,
              onChanged: (value) {
                quizNotifier.updateQuestion(
                  questionIndex,
                  question.copyWith(
                    isTrueFalse: value ?? false,
                    options:
                        value == true ? ["Vrai", "Faux"] : ['', '', '', ''],
                  ),
                );
              },
            ),
            const Text('Question Vrai/Faux')
          ],
        ),
        if (!question.isTrueOrFalse)
          Column(
            children: List.generate(4, (i) {
              return TextFormField(
                initialValue: question.options[i],
                decoration: InputDecoration(labelText: 'Option ${i + 1}'),
                onChanged: (value) {
                  final updatedOptions = [...question.options];
                  updatedOptions[i] = value;
                  quizNotifier.updateQuestion(
                    questionIndex,
                    question.copyWith(options: updatedOptions),
                  );
                },
                validator: (value) => value == null || value.isEmpty
                    ? 'Ce champ est requis'
                    : null,
              );
            }),
          ),
        DropdownButtonFormField<int>(
          decoration: const InputDecoration(
              labelText: 'questionIndex de la bonne réponse'),
          value: question.correctAnswerIndex,
          items: List.generate(
            question.isTrueOrFalse ? 2 : 4,
            (i) => DropdownMenuItem(value: i, child: Text('Option ${i + 1}')),
          ),
          onChanged: (value) {
            quizNotifier.updateQuestion(
              questionIndex,
              question.copyWith(correctAnswerIndex: value ?? 0),
            );
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
