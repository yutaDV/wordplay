import 'package:flutter/material.dart';
import 'burger_menu.dart';
import 'logo.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String pageTitle;
  final bool showBackButton;

  const MyAppBar({
    Key? key,
    required this.pageTitle,
    this.showBackButton = false,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: showBackButton
          ? IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      )
          : null,
      title: Row(
        children: [
          const Logo(size: 40),
          const SizedBox(width: 10),
          Text(
            pageTitle,
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const BurgerMenu();
              },
            );
          },
        ),
      ],
    );
  }
}
