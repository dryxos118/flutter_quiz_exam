import 'package:flutter/material.dart';

class QuizAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Function() onLogoutPressed;
  const QuizAppbar({super.key, required this.onLogoutPressed});

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        bottom: Radius.circular(25),
      ),
      child: AppBar(
        elevation: 10.0,
        title: const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            'Le Petit Quiz',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                onLogoutPressed();
              },
              icon: const Icon(Icons.login),
              color: Colors.red),
        ],
      ),
    );
  }
}
