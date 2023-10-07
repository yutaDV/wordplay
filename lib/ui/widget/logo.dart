import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Logo extends StatelessWidget {
  final double size;
  final ThemeData theme; // Додайте параметр для передачі теми

  const Logo({
    Key? key,
    this.size = 100.0,
    required this.theme, // Додайте обов'язковий параметр теми
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String logoAsset;
    if (theme == Brightness.dark) {
      logoAsset = 'assets/logo/logo_d.svg';
    } else {
      logoAsset = 'assets/logo/logo_l.svg';
    }

    return SizedBox(
      width: size,
      height: size,
      child: SvgPicture.asset(logoAsset),
    );
  }
}
