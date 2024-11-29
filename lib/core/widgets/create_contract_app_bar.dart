import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/styles.dart';

AppBar buildAppBar({final String? title, final void Function()? onPressed}) {
  return AppBar(
    leading: Center(
      child: IconButton(
        onPressed: onPressed,
        icon: const Icon(Icons.arrow_back_ios),
      ),
    ),
    elevation: 0,
    backgroundColor: Colors.transparent,
    centerTitle: true,
    title: Text(
      title ?? '',
      textAlign: TextAlign.center,
      style: Styles.textStyle26,
    ),
  );
}
