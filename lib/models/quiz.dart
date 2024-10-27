import 'package:flutter_quiz_exam/models/leaderboard.dart';
import 'package:flutter_quiz_exam/models/question.dart';
import 'package:json_annotation/json_annotation.dart';

part 'quiz.g.dart';

@JsonSerializable()
class Quiz {
  final String name;
  final List<String> tags;
  final List<Question> questions;

  int get questionCount => questions.length;
  final List<Leaderboard> leaderboard;

  Quiz({
    required this.name,
    required this.tags,
    required this.questions,
    this.leaderboard = const [],
  });

  factory Quiz.fromJson(Map<String, dynamic> json) => _$QuizFromJson(json);
  Map<String, dynamic> toJson() => _$QuizToJson(this);
}
