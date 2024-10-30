import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_quiz_exam/constants/constants.dart';
import 'package:flutter_quiz_exam/logic/provider/firebase_auth_provider.dart';
import 'package:flutter_quiz_exam/logic/provider/user_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserInfo extends HookConsumerWidget {
  UserInfo({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userNotifier);
    final firebaseUser = ref.watch(firebaseProvider);

    // Controller
    final firstNameController = useTextEditingController();
    final lastNameController = useTextEditingController();
    final emailController = useTextEditingController();

    useEffect(() {
      if (user != null) {
        firstNameController.text = user.firstName ?? '';
        lastNameController.text = user.lastName ?? '';
        emailController.text = user.email ?? '';
      }
      return null;
    }, [user]);

    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Champ pour l'email
              Container(
                decoration: BoxDecoration(
                  borderRadius: buttonBorderRadius(),
                ),
                child: TextFormField(
                  enabled: false,
                  controller: emailController,
                  decoration: textFormFieldDecoration("Email"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Modifier votre email';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 50),

              // Champ pour le prénom
              Container(
                decoration: BoxDecoration(
                  borderRadius: buttonBorderRadius(),
                ),
                child: TextFormField(
                  controller: firstNameController,
                  decoration: textFormFieldDecoration("Prénom"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Modifier votre prénom';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 50),

              // Champ pour le nom
              Container(
                decoration: BoxDecoration(
                  borderRadius: buttonBorderRadius(),
                ),
                child: TextFormField(
                  controller: lastNameController,
                  decoration: textFormFieldDecoration("Nom"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Modifier votre nom';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 50),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();
                    // Logique d'enregistrement ici
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorSecondary(),
                  foregroundColor: colorOfTextWhite(),
                  shape: RoundedRectangleBorder(
                    borderRadius: buttonBorderRadius(),
                  ),
                ),
                child: const Text('Enregistrer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
