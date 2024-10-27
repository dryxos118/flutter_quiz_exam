// import 'package:flutter_pocket_budget/logic/provider/user_provider.dart';
// import 'package:flutter_pocket_budget/routers/route.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';

// final GoRouter router = GoRouter(
//   routes: appRoutes,
//   redirect: (context, state) {
//     final container = ProviderScope.containerOf(context);
//     final isSignedIn = container.read(userNotifier);

//     if (!isSignedIn.isAuth) {
//       if (state.fullPath == "/login" || state.fullPath == "/register") {
//         return null;
//       }
//       return '/login';
//     }
//     return null;
//   },
//   debugLogDiagnostics: true,
// );
