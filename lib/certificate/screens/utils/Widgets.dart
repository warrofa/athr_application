import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../views/my_text.dart';
import 'MyColors.dart';

Widget myDivider({Color? color}) {
  return Divider(
    color: color != null ? color : Colors.grey,
    thickness: 1,
  );
}



Widget get verticalSpace30 => SizedBox(
      height: 30,
    );

Widget get verticalSpace20 => SizedBox(
      height: 20,
    );

Widget get verticalSpace15 => SizedBox(
      height: 15,
    );

Widget get verticalSpace5 => SizedBox(
      height: 5,
    );

Widget get horizontalSpace25 => SizedBox(
      width: 25,
    );

Widget get horizontalSpace10 => SizedBox(
      width: 10,
    );

Widget get horizontalSpace5 => SizedBox(
      width: 5,
    );

Widget emptyWidget(BuildContext? context, {String? text}) {
  return Container(
    height: MediaQuery.of(context!).size.height * .7,
    width: MediaQuery.of(context).size.width,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          FontAwesomeIcons.folderOpen,
          color: Colors.grey[400],
          size: 100,
        ),
        MyText(
          '$text',
          fontSize: 10.0,
          color: appPrimaryColor,
        ),
      ],
    ),
  );
}

Widget myAlert({Widget? content}) {
  return AlertDialog(
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.black, width: 2.0),
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
      elevation: 1.0,
      contentPadding: const EdgeInsets.only(
          left: 30.0, right: 30.0, top: 20.0, bottom: 20.0),
      content: Directionality(
        child: content!,
        textDirection: TextDirection.ltr,
      ));
}
