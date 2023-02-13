import 'package:flutter/material.dart';

import '../utils/Widgets.dart';
import 'my_text.dart';


class MyButton extends StatelessWidget {
  final String textContent;
  final VoidCallback onPressed;
  final  Color? color;
  final Color? textColor;

  final IconData? iconData;

  MyButton({
    required this.textContent,
    required this.onPressed,
    this.color,
    this.textColor,
    this.iconData,
   });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: Container(
          padding:   const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
          decoration: BoxDecoration(
              color: color == null ? Theme.of(context).primaryColor : color,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
           ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              iconData==null?SizedBox(): Icon(
                iconData,
                color: textColor == null ? Colors.white : textColor,
                size: 20.0,
              ),
              iconData==null?SizedBox():horizontalSpace10,
              MyText(
                textContent,
                fontSize: 15,
                color: textColor == null ? Colors.white : textColor,
               )

            ],
          ),
        ));
  }
}
