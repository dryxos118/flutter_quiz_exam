// import 'package:flutter/material.dart';
// import 'package:flutter_pocket_budget/views/auth/login/login_view.dart';
// import 'package:flutter_pocket_budget/views/auth/register/register_view.dart';
// import 'package:flutter_pocket_budget/views/home/home_page.dart';
// import 'package:flutter_pocket_budget/views/months/month_page.dart';
// import 'package:flutter_pocket_budget/views/layout/pocket_scaffold.dart';
// import 'package:flutter_pocket_budget/views/years/year_page.dart';
// import 'package:go_router/go_router.dart';

// final List<GoRoute> appRoutes = [
//   GoRoute(
//       path: '/',
//       name: "Home",
//       pageBuilder: (context, state) {
//         return _buildFadeTransitionPage(
//             context, state, PocketScaffold(body: const HomePage()));
//       }),
//   GoRoute(
//       path: '/login',
//       name: "Login",
//       pageBuilder: (context, state) {
//         return _buildFadeTransitionPage(context, state, const LoginView());
//       }),
//   GoRoute(
//       path: '/register',
//       name: "Register",
//       pageBuilder: (context, state) {
//         return _buildFadeTransitionPage(context, state, const RegisterView());
//       }),
//   GoRoute(
//       path: '/month',
//       name: "Months",
//       pageBuilder: (context, state) {
//         return _buildFadeTransitionPage(
//             context, state, PocketScaffold(body: const MonthPage()));
//       }),
//   GoRoute(
//       path: '/year',
//       name: "Year",
//       pageBuilder: (context, state) {
//         return _buildFadeTransitionPage(
//             context, state, PocketScaffold(body: const YearPage()));
//       })
// ];

// Page _buildFadeTransitionPage(
//     BuildContext context, GoRouterState state, Widget child) {
//   return CustomTransitionPage(
//     key: state.pageKey,
//     child: child,
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       return FadeTransition(
//         opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
//         child: child,
//       );
//     },
//   );
// }
