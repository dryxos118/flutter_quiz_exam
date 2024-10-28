import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

@JsonSerializable()
class Question {
  final String text;
  final bool isTrueOrFalse;
  final List<String> options;
  final int correctAnswerIndex;

  Question({
    required this.text,
    required this.isTrueOrFalse,
    required this.options,
    required this.correctAnswerIndex,
  });

  Question copyWith({
    String? text,
    List<String>? options,
    int? correctAnswerIndex,
    bool? isTrueFalse,
  }) {
    return Question(
      text: text ?? this.text,
      options: options ?? this.options,
      correctAnswerIndex: correctAnswerIndex ?? this.correctAnswerIndex,
      isTrueOrFalse: isTrueFalse ?? isTrueOrFalse,
    );
  }

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}
