import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_quiz_exam/models/leaderboard.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class User {
  String? uid;
  String? firstName;
  String? lastName;
  String? email;
  List<Leaderboard> leaderboard;

  User({
    this.uid,
    this.firstName,
    this.lastName,
    required this.email,
    List<Leaderboard>? leaderboard,
  }) : leaderboard = leaderboard ?? [];

  factory User.fromQueryDocumentSnapshot(QueryDocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return User(
      uid: doc.id,
      firstName: data['firstName'],
      lastName: data['lastName'],
      email: data['email'],
    );
  }

  Map<String, dynamic> toSnapshot() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
    };
  }

  factory User.fromSnapshot(Map<String, dynamic>? json, String uid) {
    return User(
      uid: uid,
      firstName: json?['firstName'],
      lastName: json?['lastName'],
      email: json?['email'],
      leaderboard: (json?['leaderboard'] as List<dynamic>?)
              ?.map((q) => Leaderboard.fromJson(q as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
