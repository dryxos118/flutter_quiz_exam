import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_quiz_exam/models/leaderboard.dart';

class User {
  final String? uid;
  final String? firstName;
  final String? lastName;
  final String? email;
  final List<Leaderboard> leaderboard;

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
      leaderboard: (data['leaderboard'] as List<dynamic>?)
              ?.map((q) => Leaderboard.fromJson(q as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toSnapshot() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'leaderboard': leaderboard.map((l) => l.toJson()).toList(),
    };
  }

  factory User.fromSnapshot(Map<String, dynamic>? json) {
    return User(
      uid: json?["uid"],
      firstName: json?['firstName'],
      lastName: json?['lastName'],
      email: json?['email'],
      leaderboard: (json?['leaderboard'] as List<dynamic>?)
              ?.map((q) => Leaderboard.fromJson(q as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  User copyWith({
    String? firstName,
    String? lastName,
    List<Leaderboard>? leaderboard,
    String? uid,
  }) {
    return User(
      uid: uid ?? this.uid,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email,
      leaderboard: leaderboard ?? this.leaderboard,
    );
  }
}
