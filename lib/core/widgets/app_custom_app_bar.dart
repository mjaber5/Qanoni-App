import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

AppBar buildCustomAppBar({final String? title}) {
  return AppBar(
    title: SvgPicture.asset(
      'assets/images/q-high-resolution-logo-transparent.svg',
    ),
    elevation: 0,
    backgroundColor: Colors.transparent,
  );
}
