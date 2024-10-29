import 'package:flutter/material.dart';
import 'package:flutter_quiz_exam/layout/quiz_scaffold.dart';
import 'package:flutter_quiz_exam/views/auth/login/login_view.dart';
import 'package:flutter_quiz_exam/views/auth/register/register_view.dart';
import 'package:flutter_quiz_exam/views/edition/quiz_editor.dart';
import 'package:flutter_quiz_exam/views/edition/quiz_editor_list.dart';
import 'package:flutter_quiz_exam/views/quiz/games/quiz_games.dart';
import 'package:flutter_quiz_exam/views/quiz/quiz_page.dart';
import 'package:go_router/go_router.dart';

final List<GoRoute> appRoutes = [
  GoRoute(
      path: '/login',
      name: "Login",
      pageBuilder: (context, state) {
        return _buildFadeTransitionPage(context, state, const LoginView());
      }),
  GoRoute(
      path: '/register',
      name: "Register",
      pageBuilder: (context, state) {
        return _buildFadeTransitionPage(context, state, const RegisterView());
      }),
  GoRoute(
      path: '/quiz',
      name: "Quiz",
      pageBuilder: (context, state) {
        return _buildFadeTransitionPage(
            context, state, QuizScaffold(body: const QuizPage()));
      }),
  GoRoute(
    path: '/playquiz/:id',
    name: 'Play quiz',
    pageBuilder: (context, state) {
      final quizId = state.pathParameters['id'] ?? "";
      return _buildFadeTransitionPage(
          context, state, QuizGames(quizId: quizId));
    },
  ),
  GoRoute(
      path: '/editor',
      name: "Editor",
      pageBuilder: (context, state) {
        return _buildFadeTransitionPage(
            context, state, QuizScaffold(body: const QuizEditorList()));
      }),
  GoRoute(
    path: '/quizeditor/:id',
    name: "Quiz Editor",
    pageBuilder: (context, state) {
      final quizId = state.pathParameters['id'] ?? "";
      return _buildFadeTransitionPage(
          context, state, QuizScaffold(body: QuizEditor(quizId)));
    },
  ),
];

Page _buildFadeTransitionPage(
    BuildContext context, GoRouterState state, Widget child) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
        child: child,
      );
    },
  );
}
