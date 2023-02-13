import 'package:flutter/material.dart';

import '../utils/Widgets.dart';
import 'my_text.dart';


 class FullButton extends StatelessWidget {
  final String? textContent;
  final VoidCallback onPressed;
  final  Color? color;
  final Color? textColor;

  final IconData? iconData;
  final double buttonPadding;

  FullButton({
    required this.textContent,
    required this.onPressed,
    this.color,
    this.textColor,
    this.iconData,
    this.buttonPadding=10.0 ,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: Container(
          // width: MediaQuery.of(context).size.width,
          padding:   EdgeInsets.symmetric(vertical: buttonPadding),
          decoration: BoxDecoration(
            color: color == null ? Theme.of(context).primaryColor : color,
            borderRadius: BorderRadius.all(Radius.circular(5)),
              border: Border.all(color: textColor == null ? Colors.white : textColor!,width: .5)
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
