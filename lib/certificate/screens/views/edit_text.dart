 import 'package:flutter/material.dart';

import '../utils/constants.dart';

class MyEditText extends StatefulWidget {
  // Icon icon;
  final IconData? iconData;

  final String? labelText;
  final String prefixText;
  final String? initialValue;
  final FormFieldSetter<String>? onSaved;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final TextEditingController? controller;
  final bool readOnly;
  final bool obscureText;
  final int maxLines ;
  final  int minLines;
  final GestureTapCallback? onTap;

  MyEditText({
    this.iconData,
    this.onSaved,
    this.controller,
    this.labelText = '',
    this.readOnly = false,
    this.obscureText = false,
    this.prefixText = '',
    this.initialValue ,
    this.onTap,
    this.maxLines = 1,
    this.minLines = 1,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.done,

  });

  @override
  State<StatefulWidget> createState() {
    return MyEditTextState();
  }
}

class MyEditTextState extends State<MyEditText> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      textAlignVertical: TextAlignVertical.center,

      onSaved: widget.onSaved,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      textAlign: TextAlign.start,
      enableInteractiveSelection: false,
      onTap: widget.onTap,
      style: TextStyle(
        color: Colors.black,
        fontSize: appFontSize,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
      ),
      initialValue: widget.initialValue??null,
      readOnly: widget.readOnly,
      obscureText:widget.obscureText,


      textInputAction: widget.textInputAction,
      keyboardType: widget.textInputType,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        filled: true,
        fillColor: Colors.grey[100],
        contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),

        helperStyle: TextStyle(
          color: Colors.black.withOpacity(0.65),
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
        ),
        prefixText:widget.prefixText,

        errorStyle: TextStyle(
          fontSize: appFontSize,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
        ),
        hintStyle: TextStyle(
          color: Colors.black54,
          fontSize: appFontSize,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
        ),
        prefixIcon:Icon(
          widget.iconData,
          color: Colors.grey[400],
        ),
        prefixIconConstraints: BoxConstraints(
          minWidth:widget.iconData==null?0: 50.0,
        ),
        labelText: widget.labelText,
        labelStyle: TextStyle(
          fontSize: appFontSize,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }

  @override
  State<StatefulWidget>? createState() {
    return null;
  }
}
