import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String? id;
  String? email;

  User({this.id, this.email});

  factory User.fromQueryDocumentSnapshot(QueryDocumentSnapshot doc) {
    return User(
      id: doc.id,
      email: doc["email"],
    );
  }

  Map<String, dynamic> toSnapshot() {
    return {"email": email};
  }

  factory User.fromSnapshot(Map<String, dynamic>? json, String id) {
    return User(
      id: id,
      email: json?["email"],
    );
  }
}
