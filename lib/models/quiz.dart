import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_quiz_exam/models/leaderboard.dart';
import 'package:flutter_quiz_exam/models/question.dart';
import 'package:json_annotation/json_annotation.dart';

part 'quiz.g.dart';

@JsonSerializable()
class Quiz {
  final String? uid;
  final String name;
  final List<String> tags;
  final List<Question> questions;
  int get questionCount => questions.length;
  final List<Leaderboard> leaderboard;
  final String? userId;
  final String? userName;

  Quiz({
    required this.name,
    required this.tags,
    required this.questions,
    this.leaderboard = const [],
    this.userId,
    this.userName,
    this.uid,
  });

  // Method to create a Quiz object from Firestore DocumentSnapshot
  factory Quiz.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Quiz(
      uid: doc.id,
      name: data['name'] ?? '',
      tags: List<String>.from(data['tags'] ?? []),
      questions: (data['questions'] as List<dynamic>?)
              ?.map((q) => Question.fromJson(q as Map<String, dynamic>))
              .toList() ??
          [],
      leaderboard: (data['leaderboard'] as List<dynamic>?)
              ?.map((l) => Leaderboard.fromJson(l as Map<String, dynamic>))
              .toList() ??
          [],
      userId: data['userId'] as String?,
      userName: data['userName'] as String?,
    );
  }

  Map<String, dynamic> toJsonFirebase() => {
        "name": name,
        "tags": tags,
        "questions": questions.map((q) => q.toJson()).toList(),
        "leaderboard": leaderboard.map((l) => l.toJson()).toList(),
        "userId": userId,
        "userName": userName
      };

  Quiz copyWith({
    String? name,
    List<String>? tags,
    List<Question>? questions,
    List<Leaderboard>? leaderboard,
    String? userId,
    String? userName,
  }) {
    return Quiz(
        name: name ?? this.name,
        tags: tags ?? this.tags,
        questions: questions ?? this.questions,
        leaderboard: leaderboard ?? this.leaderboard,
        userId: userId ?? this.userId,
        userName: userName ?? this.userName,
        uid: uid);
  }
}
