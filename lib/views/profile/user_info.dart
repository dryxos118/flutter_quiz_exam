import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_quiz_exam/constants/constants.dart';
import 'package:flutter_quiz_exam/logic/provider/user_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserInfo extends HookConsumerWidget {
  UserInfo({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userNotifier);
    final userProvider = ref.read(userNotifier.notifier);
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

    void onSaveUser() {
      if (_formKey.currentState?.validate() ?? false) {
        _formKey.currentState?.save();
        userProvider.updateUser(
            firstNameController.text, lastNameController.text);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              "Utilisateur modifier",
              style: TextStyle(color: Colors.white),
            ),
            duration: Duration(seconds: 1),
            backgroundColor: Color(0xff00696c)));
      }
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 30, bottom: 16, left: 16, right: 16),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: buttonBorderRadius(),
                ),
                child: TextFormField(
                    enabled: false,
                    controller: emailController,
                    decoration: textFormFieldDecoration("Email")),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
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
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
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
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                onPressed: () => onSaveUser(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorSecondary(),
                  foregroundColor: colorOfTextWhite(),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: buttonBorderRadius(),
                  ),
                ),
                child: const Text('Enregistrer'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
