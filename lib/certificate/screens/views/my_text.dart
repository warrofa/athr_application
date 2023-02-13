import 'package:flutter/material.dart';
import '../utils/constants.dart';

class MyText extends StatelessWidget {
  final String? textContent;
  final Color? color;
  final int maxLines;
  final double fontSize;
  final double height;
  final FontWeight fontWeight;
  final TextDecoration decoration;

  MyText(
    this.textContent, {
    this.color = Colors.black,
    this.maxLines = 1,
    this.fontSize = appFontSize,
    this.height = 1.3,
    this.fontWeight = FontWeight.w500,
    this.decoration = TextDecoration.none,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      textContent!,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight,
          height: height,
          decoration: decoration),
    );
  }
}
