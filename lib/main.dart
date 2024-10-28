import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quiz_exam/firebase_options.dart';
import 'package:flutter_quiz_exam/logic/provider/firebase_auth_provider.dart';
import 'package:flutter_quiz_exam/routers/router.dart';
import 'package:flutter_quiz_exam/theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future.microtask(() => ref.read(firebaseNotifier.notifier).initialize());

    return ProviderScope(
      child: MaterialApp.router(
        title: 'Flutter Quiz Exam',
        // Theme
        theme: ThemeData(
            useMaterial3: true,
            colorScheme: MaterialTheme.lightHighContrastScheme()),
        darkTheme: ThemeData(
            useMaterial3: true, colorScheme: MaterialTheme.darkScheme()),
        themeMode: ThemeMode.dark,
        // Locale
        locale: const Locale('fr', 'fr'),
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}
