import 'package:json_annotation/json_annotation.dart';

part 'leaderboard.g.dart';

@JsonSerializable()
class Leaderboard {
  final String userName;
  final int score;

  Leaderboard({
    required this.userName,
    required this.score,
  });

  factory Leaderboard.fromJson(Map<String, dynamic> json) =>
      _$LeaderboardFromJson(json);
  Map<String, dynamic> toJson() => _$LeaderboardToJson(this);
}
