import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class QuizEditorSave extends StatelessWidget {
  final Function() onSaveQuiz;
  const QuizEditorSave({super.key, required this.onSaveQuiz});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 32,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          onSaveQuiz();
          context.go('/editor');
        },
        child: const Text(
          'Enregistrer le Quiz',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
