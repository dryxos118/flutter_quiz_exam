import 'package:json_annotation/json_annotation.dart';

part 'leaderboard.g.dart';

@JsonSerializable()
class Leaderboard {
  final String quizUid;
  final String quizName;
  final int score;
  final bool isAbandoned;

  Leaderboard({
    required this.quizUid,
    required this.quizName,
    required this.score,
    required this.isAbandoned,
  });

  factory Leaderboard.fromJson(Map<String, dynamic> json) =>
      _$LeaderboardFromJson(json);
  Map<String, dynamic> toJson() => _$LeaderboardToJson(this);
}
