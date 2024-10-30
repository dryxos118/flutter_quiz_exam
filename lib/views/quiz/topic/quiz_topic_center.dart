import 'package:flutter/material.dart';
import 'package:flutter_quiz_exam/constants/constants.dart';

class QuizTopicCenter extends StatelessWidget {
  final String name;
  final int questionsCounts;
  final List<String> tags;
  const QuizTopicCenter(
      {super.key,
      required this.name,
      required this.questionsCounts,
      required this.tags});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            "$questionsCounts Questions",
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 6,
            children: tags.map((tag) {
              return Chip(
                label: Text(tag),
                backgroundColor: colorSecondary(),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
