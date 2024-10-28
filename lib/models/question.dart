import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

@JsonSerializable()
class Question {
  final String text;
  final int isTrueOrFalse;
  final List<String> options;
  final int correctAnswerIndex;

  Question({
    required this.text,
    required this.isTrueOrFalse,
    required this.options,
    required this.correctAnswerIndex,
  });

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}
