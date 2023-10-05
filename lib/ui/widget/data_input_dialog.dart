import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

class DataInputDialog extends StatefulWidget {
  final String title;
  final List<String> questions;
  final Function(List<String>) onDone;

  DataInputDialog({super.key,
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
      backgroundColor: theme.scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.title,
                  style: theme.textTheme.titleMedium,
                ),
              ),
              for (int i = 0; i < widget.questions.length; i++)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: controllers[i],
                    style: theme.textTheme.titleMedium,
                    decoration: InputDecoration(
                      labelText: widget.questions[i],
                      labelStyle: theme.textTheme.titleSmall?.copyWith(color: theme.dividerColor),// Колір тексту мітки
                    ),
                  ),
                ),
              const SizedBox(height: 16),
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
                      style: theme.textTheme.labelMedium,
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
              icon:  Icon(
                Icons.close,
                color: theme.highlightColor,
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


