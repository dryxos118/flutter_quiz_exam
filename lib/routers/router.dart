import 'package:flutter_quiz_exam/logic/provider/firebase_auth_provider.dart';
import 'package:flutter_quiz_exam/routers/route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: appRoutes,
  redirect: (context, state) {
    final container = ProviderScope.containerOf(context);
    final isSignedIn = container.read(firebaseNotifier);

    if (isSignedIn == null) {
      if (state.fullPath == "/login" || state.fullPath == "/register") {
        return null;
      }
      print("login");
      return '/login';
    }
    return null;
  },
);
