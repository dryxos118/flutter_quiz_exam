import 'package:flutter/material.dart';
import 'package:flutter_quiz_exam/views/profile/auth_tab.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: CircleAvatar(
            radius: 50,
            backgroundImage: const AssetImage('assets/images/thinking.jpg'),
            backgroundColor: Colors.grey[300],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            'Profile',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const Expanded(
          child: AuthTab(),
        ),
      ],
    );
  }
}
