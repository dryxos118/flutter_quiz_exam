import 'package:flutter/material.dart';
import 'package:flutter_quiz_exam/logic/provider/user_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserInfo extends ConsumerWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return Center(
      child: user != null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Email: ${user.email}"),
              ],
            )
          : const Text("Aucune information utilisateur disponible"),
    );
  }
}
