import 'package:flutter/material.dart';
import 'package:flutter_quiz_exam/constants/constants.dart';
import 'package:flutter_quiz_exam/logic/provider/quiz_editor_provider.dart';
import 'package:flutter_quiz_exam/views/edition/widget/multiple_choice_option_editor.dart';
import 'package:flutter_quiz_exam/views/edition/widget/option_true_false_editor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuestionEditor extends ConsumerWidget {
  final int questionIndex;
  const QuestionEditor(this.questionIndex, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final question = ref.watch(quizEditorProvider).questions[questionIndex];
    final quizNotifier = ref.read(quizEditorProvider.notifier);

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            initialValue: question.text,
            decoration: textFormFieldDecoration("Question"),
            onChanged: (value) => quizNotifier.updateQuestion(
              questionIndex,
              question.copyWith(text: value),
            ),
            validator: (value) =>
                value == null || value.isEmpty ? 'Ce champ est requis' : null,
            maxLines: null,
            minLines: 2,
            keyboardType: TextInputType.multiline,
          ),
          // Row
          Row(
            children: [
              Checkbox(
                  value: question.isTrueOrFalse,
                  onChanged: (value) => quizNotifier.updateQuestion(
                      questionIndex,
                      question.copyWith(
                        isTrueFalse: value ?? false,
                        options:
                            value == true ? ["Vrai", "Faux"] : ['', '', '', ''],
                      ))),
              const Text('Question Vrai/Faux')
            ],
          ),
          //
          question.isTrueOrFalse
              ? OptionTrueFalseEditor(
                  question: question,
                  questionIndex: questionIndex,
                )
              : MultipleChoiceOptionEditor(
                  question: question,
                  questionIndex: questionIndex,
                ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
