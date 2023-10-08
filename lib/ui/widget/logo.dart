import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../themes/theme.dart';

class Logo extends StatelessWidget {
  final double size;

  const Logo({
    Key? key,
    this.size = 100.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    String logoAsset;
    //if (Theme.of(context).primaryColor == const Color(0xFF6BD8B6)) { // змінити даний підхід
    if (theme.brightness == Brightness.dark) {
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
