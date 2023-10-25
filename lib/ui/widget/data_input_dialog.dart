import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import 'logo.dart';

class DataInputDialog extends StatefulWidget {
  final String title;
  final List<String> questions;
  final Function(List<String>) onDone;

  const DataInputDialog({
    Key? key,
    required this.title,
    required this.questions,
    required this.onDone,
  }) : super(key: key);

  @override
  _DataInputDialogState createState() => _DataInputDialogState();
}

class _DataInputDialogState extends State<DataInputDialog> {
  List<TextEditingController> controllers = [];

  @override
  void initState() {
    super.initState();
    // Ініціалізуємо контролери тексту для кожного питання
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
      child: SingleChildScrollView( // Додаємо SingleChildScrollView
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.title,
                style: theme.textTheme.headline6,
              ),
            ),
            for (int i = 0; i < widget.questions.length; i++)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: controllers[i],
                  style: theme.textTheme.subtitle1,
                  decoration: InputDecoration(
                    labelText: widget.questions[i],
                    labelStyle: theme.textTheme.subtitle2?.copyWith(color: theme.dividerColor),
                  ),
                ),
              ),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
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
                    style: theme.textTheme.button,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
