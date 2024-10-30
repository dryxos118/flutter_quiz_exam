// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaderboard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Leaderboard _$LeaderboardFromJson(Map<String, dynamic> json) => Leaderboard(
      quizUid: json['quizUid'] as String,
      quizName: json['quizName'] as String,
      score: (json['score'] as num).toInt(),
      isAbandoned: json['isAbandoned'] as bool,
    );

Map<String, dynamic> _$LeaderboardToJson(Leaderboard instance) =>
    <String, dynamic>{
      'quizUid': instance.quizUid,
      'quizName': instance.quizName,
      'score': instance.score,
      'isAbandoned': instance.isAbandoned,
    };
