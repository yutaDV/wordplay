import 'package:flutter/material.dart';
import '../../controllers/theme_controler.dart';
import '../../generated/l10n.dart';
import 'logo.dart';

class BurgerMenu extends StatefulWidget {
  const BurgerMenu({Key? key}) : super(key: key);

  @override
  _BurgerMenuState createState() => _BurgerMenuState();
}

class _BurgerMenuState extends State<BurgerMenu> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Dialog(
      backgroundColor: theme.scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      alignment: Alignment.topCenter,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: theme.primaryColor,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.close, color: theme.primaryColor),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(S.of(context).language, style: theme.textTheme.titleMedium),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ToggleButtons(
                isSelected: [true, false], // Example selection, use your own logic
                children: const [
                  Text('Українська'),
                  Text('English'),
                ],
                onPressed: (int index) {
                  // Handle button tap
                },
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(S.of(context).theme, style: theme.textTheme.titleMedium),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: ToggleButtons(
                isSelected: [ThemeController.isDarkTheme, !ThemeController.isDarkTheme], // Приклад вибору, використовуйте власну логіку
                children: [
                  Text(S.of(context).dark),
                  Text(S.of(context).light),
                ],
                onPressed: (int index) {
                  setState(() {
                    ThemeController.switchTheme(); // Оновлення теми за допомогою контролера теми
                  });
                },
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
              child: TextButton(
                onPressed: () {
                  // Правила
                },
                child: Text(
                  S.of(context).rules,
                  style: theme.textTheme.titleMedium?.copyWith(decoration: TextDecoration.underline),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 20, 20),
              child: Align(
                alignment: Alignment.topRight,
                child: Opacity(
                  opacity: 0.4,
                  child: Logo(size: 50.00),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
