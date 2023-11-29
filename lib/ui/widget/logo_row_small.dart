import 'package:flutter/material.dart';
import 'package:wordplay/ui/widget/logo.dart';

class LogoRowSmall extends StatelessWidget {
  final int repeatCount;
  final double logoSize;

  const LogoRowSmall({Key? key, required this.repeatCount, required this.logoSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < repeatCount; i++)
          Padding(
            padding: EdgeInsets.only(right: i < repeatCount - 1 ? 12 : 0),
            child: Logo(size: logoSize),
          ),
      ],
    );
  }
}
