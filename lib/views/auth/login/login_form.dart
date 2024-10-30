import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_quiz_exam/constants/constants.dart';
import 'package:flutter_quiz_exam/logic/provider/user_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginForm extends HookConsumerWidget {
  LoginForm({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = useState("");
    final password = useState("");
    final obscureText = useState(false);

    Future<void> submitForm(VoidCallback onSubmited) async {
      if (_formKey.currentState?.validate() ?? false) {
        _formKey.currentState?.save();
        print(email.value);
        print(password.value);

        await ref
            .read(userNotifier.notifier)
            .loginInFirebase(email.value, password.value);

        onSubmited();
      }
    }

    void togglePasswordVisibility() {
      obscureText.value = !obscureText.value;
    }

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: colorOfTextField(),
              borderRadius: buttonBorderRadius(),
            ),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: InputBorder.none,
                contentPadding: textFieldPadding(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Entrer votre email !';
                }
                return null;
              },
              onSaved: (value) {
                email.value = value ?? '';
              },
            ),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: colorOfTextField(),
              borderRadius: buttonBorderRadius(),
            ),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Password',
                border: InputBorder.none,
                contentPadding: textFieldPadding(),
                suffixIcon: IconButton(
                  icon: Icon(
                    obscureText.value ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: togglePasswordVisibility,
                ),
              ),
              obscureText: !obscureText.value,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Entrez votre mot de passe !';
                }
                return null;
              },
              onSaved: (value) {
                password.value = value ?? '';
              },
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => submitForm(
              () {
                // SnackbarService(context)
                //     .showSnackbar(title: "User Connected", type: Type.succes);
                context.go('/quiz');
              },
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: colorSecondary(),
              foregroundColor: colorOfTextWhite(),
              shape: RoundedRectangleBorder(
                borderRadius: buttonBorderRadius(),
              ),
            ),
            child: const Text('Se connecter'),
          ),
        ],
      ),
    );
  }
}
