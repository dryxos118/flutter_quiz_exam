import 'package:flutter/material.dart';
import 'package:flutter_quiz_exam/logic/provider/firebase_auth_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuizAppbar extends ConsumerWidget implements PreferredSizeWidget {
  final Function() onLogoutPressed;
  const QuizAppbar({super.key, required this.onLogoutPressed});

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userCredentials = ref.watch(firebaseNotifier);
    return AppBar(
      elevation: 10.0,
      title: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Text(
          'Quiz Flutter Exam',
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
              onLogoutPressed;
            },
            icon: const Icon(Icons.flag),
            color: userCredentials != null ? Colors.green : Colors.red),
      ],
    );
  }
}
