import 'package:flutter_quiz_exam/models/question.dart';
import 'package:flutter_quiz_exam/models/quiz.dart';

class QuizData {
  Quiz getQuiz() {
    Quiz flutterQuiz = Quiz(
      name: "Quiz Flutter",
      tags: ["Flutter", "Dart", "Mobile Development"],
      questions: [
        Question(
          text:
              "Quel langage de programmation est utilisé pour développer avec Flutter ?",
          options: ["JavaScript", "Dart", "Swift", "Kotlin"],
          correctAnswerIndex: 1,
        ),
        Question(
          text:
              "Quel widget est couramment utilisé pour les mises en page dans Flutter ?",
          options: ["Column", "Container", "Text", "Stack"],
          correctAnswerIndex: 1,
        ),
        Question(
          text: "Quelle commande permet de crée un nouveau projet Flutter ?",
          options: [
            "flutter new project",
            "flutter create",
            "flutter init",
            "flutter start"
          ],
          correctAnswerIndex: 1,
        ),
        Question(
          text: "Quel widget permet d'afficher une liste déroulante ?",
          options: [
            "DropdownButton",
            "ListView",
            "ListTile",
            "SingleChildScrollView"
          ],
          correctAnswerIndex: 0,
        ),
        Question(
          text: "Quel est le widget parent de tous les widgets dans Flutter ?",
          options: ["Container", "MaterialApp", "Scaffold", "Widget"],
          correctAnswerIndex: 3,
        ),
        Question(
          text:
              "Quel widget permet d'afficher une page complète avec un AppBar dans Flutter ?",
          options: ["AppBar", "Scaffold", "Container", "Column"],
          correctAnswerIndex: 1,
        ),
        Question(
          text:
              "Quelle méthode est utilisée pour reconstruire l'interface utilisateur dans Flutter ?",
          options: ["build()", "setState()", "rebuild()", "refresh()"],
          correctAnswerIndex: 1,
        ),
        Question(
          text: "Quel type de widget ne possède pas d'état modifiable ?",
          options: [
            "StatefulWidget",
            "StatelessWidget",
            "InheritedWidget",
            "Container"
          ],
          correctAnswerIndex: 1,
        ),
        Question(
          text:
              "Dans Flutter, quel fichier contient la configuration principale de l'application ?",
          options: [
            "main.dart",
            "config.dart",
            "flutter.yaml",
            "settings.dart"
          ],
          correctAnswerIndex: 0,
        ),
        Question(
          text:
              "Quelle est la commande pour exécuter une application Flutter sur un appareil ?",
          options: [
            "flutter run",
            "flutter start",
            "flutter launch",
            "flutter build"
          ],
          correctAnswerIndex: 0,
        ),
      ],
    );
    return flutterQuiz;
  }
}
