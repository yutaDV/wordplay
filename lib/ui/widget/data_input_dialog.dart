import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

class DataInputDialog extends StatefulWidget {
  final String title;
  final List<String> questions;
  final Function(List<String>) onDone;

  DataInputDialog({
    required this.title,
    required this.questions,
    required this.onDone,
  });

  @override
  _DataInputDialogState createState() => _DataInputDialogState();
}

class _DataInputDialogState extends State<DataInputDialog> {
  List<TextEditingController> controllers = [];

  @override
  void initState() {
    super.initState();
    // Initialize text controllers for each question
    for (int i = 0; i < widget.questions.length; i++) {
      controllers.add(TextEditingController());
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Dialog(
      backgroundColor: theme.scaffoldBackgroundColor, // Колір фону діалогового вікна
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0), // Коло в кутах діалога
      ),
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.title,
                  style: theme.textTheme.bodyMedium,
                ),
              ),
              for (int i = 0; i < widget.questions.length; i++)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: controllers[i],
                    style: theme.textTheme.bodyMedium,
                    decoration: InputDecoration(
                      labelText: widget.questions[i],
                      labelStyle: TextStyle(color: Colors.black12), // Колір тексту мітки
                    ),
                  ),
                ),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0), // Відступ з правого краю
                  child: ElevatedButton(
                    onPressed: () {
                      List<String> answers = [];
                      for (int i = 0; i < controllers.length; i++) {
                        answers.add(controllers[i].text);
                      }
                      widget.onDone(answers);
                      Navigator.of(context).pop();
                    },
                    child: Text(
                        S.of(context).ok,
                        style: theme.textTheme.labelSmall
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(theme.primaryColor),
                    ),
                  ),
                ),
              ),

            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: Icon(
                Icons.close,
                color: theme.primaryColor,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}


// кудись винести цей метод
Future<void> _showGameCodeDialog(BuildContext context) async {
  final result = await showDialog(
    context: context,
    builder: (context) {
      return DataInputDialog(
        title: S
            .of(context)
            .dialogStartGame,
        questions: [S
            .of(context)
            .accessCode, S
            .of(context)
            .yourName
        ],
        onDone: (List<String> answers) {
          String gameCode = answers[0];
          String playerName = answers[1];
          Navigator.of(context).pop(answers); // Повертаємо дані
        },
      );
    },
  );
}
