// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Quiz _$QuizFromJson(Map<String, dynamic> json) => Quiz(
      json['userId'] as String?,
      json['userName'] as String?,
      name: json['name'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      questions: (json['questions'] as List<dynamic>)
          .map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList(),
      leaderboard: (json['leaderboard'] as List<dynamic>?)
              ?.map((e) => Leaderboard.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$QuizToJson(Quiz instance) => <String, dynamic>{
      'name': instance.name,
      'tags': instance.tags,
      'questions': instance.questions,
      'leaderboard': instance.leaderboard,
      'userId': instance.userId,
      'userName': instance.userName,
    };
