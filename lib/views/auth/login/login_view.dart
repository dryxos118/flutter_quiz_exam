import 'package:flutter/material.dart';
import 'package:flutter_quiz_exam/constants/constants.dart';
import 'package:flutter_quiz_exam/views/auth/login/login_form.dart';
import 'package:go_router/go_router.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            ClipRRect(
              borderRadius: generalBorderRadius(),
              child: Image.asset(
                'assets/images/quiz-logo.png',
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            // Formulaire de connexion
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: LoginForm(),
            ),
            // Bouton pour aller à la page d'inscription
            TextButton(
              onPressed: () {
                context.go("/register");
              },
              child: const Text('Pas encore de compte ? Inscrivez-vous'),
            ),
          ],
        ),
      ),
    );
  }
}
