import 'package:flutter/material.dart';
import 'package:flutter_quiz_exam/logic/provider/bottom_nav_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuizBottomNavigation extends HookConsumerWidget {
  const QuizBottomNavigation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavIndexProvider);
    final indexNotifier = ref.read(bottomNavIndexProvider.notifier);

    void onItemTapped(int index) {
      indexNotifier.updateIndex(index); // Met à jour l'index
      switch (index) {
        case 0:
          context.go('/quiz');
          break;
        case 1:
          context.go('/editor');
          break;
        case 2:
          context.go('/profile');
          break;
      }
    }

    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.interests),
          label: 'Quiz',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.edit_note),
          label: 'Editor',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_box),
          label: 'Profile',
        ),
      ],
      currentIndex: currentIndex,
      onTap: (index) => onItemTapped(index),
    );
  }
}
