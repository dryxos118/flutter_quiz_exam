import 'package:flutter/material.dart';
import 'package:flutter_quiz_exam/views/auth/register/register_form.dart';
import 'package:go_router/go_router.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo en SVG
              Image.asset(
                'assets/images/quiz-logo.png',
                height: 100,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: RegisterForm(),
              ),
              TextButton(
                onPressed: () {
                  context.go("/login");
                },
                child: const Text('Déjà un compte ? Connectez-vous'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
