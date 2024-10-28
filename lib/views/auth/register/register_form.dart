import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_quiz_exam/logic/provider/firebase_auth_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RegisterForm extends HookConsumerWidget {
  RegisterForm({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = useState("");
    final password = useState("");
    final obscureText = useState(false);
    //final test = ref.watch(firebaseUser);

    Future<void> submitForm(VoidCallback onSubmited) async {
      if (_formKey.currentState?.validate() ?? false) {
        _formKey.currentState?.save();
        print(email.value);
        print(password.value);

        await ref
            .read(firebaseNotifier.notifier)
            .register(email: email.value, password: password.value);

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
          TextFormField(
            decoration: const InputDecoration(labelText: 'Email'),
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
          TextFormField(
            decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    obscureText.value ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: togglePasswordVisibility,
                )),
            obscureText: !obscureText.value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Entrez votre password !';
              }
              return null;
            },
            onSaved: (value) {
              password.value = value ?? '';
            },
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
            child: const Text('Se connecter'),
          ),
        ],
      ),
    );
  }
}
