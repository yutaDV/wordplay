import 'package:flutter/material.dart';
import 'package:wordplay/ui/widget/logo.dart';

class LogoRow extends StatelessWidget {
  const LogoRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Logo(size: 16),
        SizedBox(width: 12),
        Logo(size: 30),
        SizedBox(width: 12),
        Logo(size: 40),
        SizedBox(width: 12),
        Logo(size: 60),
        SizedBox(width: 12),
        Logo(size: 40),
        SizedBox(width: 12),
        Logo(size: 30),
        SizedBox(width: 12),
        Logo(size: 16),
      ],
    );
  }
}
