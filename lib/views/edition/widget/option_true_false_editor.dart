import 'package:flutter/material.dart';
import 'package:flutter_quiz_exam/logic/provider/quiz_editor_provider.dart';
import 'package:flutter_quiz_exam/models/question.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OptionTrueFalseEditor extends ConsumerWidget {
  final Question question;
  final int questionIndex;

  const OptionTrueFalseEditor({
    super.key,
    required this.question,
    required this.questionIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizNotifier = ref.read(quizEditorProvider.notifier);
    return Column(
      children: [
        const Text("Options:"),
        ListTile(
          title: const Text("Vrai"),
          leading: Radio<int>(
            value: 0,
            groupValue: question.correctAnswerIndex,
            onChanged: (value) {
              quizNotifier.updateQuestion(
                  questionIndex, question.copyWith(correctAnswerIndex: 0));
            },
          ),
        ),
        ListTile(
          title: const Text("Faux"),
          leading: Radio<int>(
            value: 1,
            groupValue: question.correctAnswerIndex,
            onChanged: (value) {
              quizNotifier.updateQuestion(
                  questionIndex, question.copyWith(correctAnswerIndex: 1));
            },
          ),
        ),
      ],
    );
  }
}
